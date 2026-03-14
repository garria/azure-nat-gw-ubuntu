#!/usr/bin/env bash
set -euxo pipefail

echo "[*] Restoring NAT gateway configuration..."

# 1) IP forwarding (persistent)
echo 'net.ipv4.ip_forward=1' > /etc/sysctl.d/99-azure-nat.conf
sysctl -p /etc/sysctl.d/99-azure-nat.conf

# 2) Install nftables
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y nftables

# 3) Restore nftables rules
cat >/etc/nftables.conf <<'EOF'
#!/usr/sbin/nft -f
flush ruleset

table ip nat {
  chain postrouting {
    type nat hook postrouting priority srcnat; policy accept;
    oifname "eth0" masquerade
  }
}

table inet filter {
  chain input {
    type filter hook input priority filter; policy drop;
    iifname "lo" accept
    ct state established,related accept
    # tcp dport 22 accept
  }
  chain output {
    type filter hook output priority filter; policy accept;
  }
  chain forward {
    type filter hook forward priority filter; policy drop;
    ct state established,related accept
    iifname != "lo" oifname != "lo" accept
    tcp flags syn tcp option maxseg size set 1350
  }
}
EOF

# 4) Disable conflicting services
systemctl disable --now ufw || true
systemctl disable --now netfilter-persistent || true

# 5) Enable nftables
systemctl enable --now nftables
nft -f /etc/nftables.conf

echo "[✓] NAT Gateway restored successfully."
sysctl net.ipv4.ip_forward
nft list ruleset
