
#!/bin/bash
echo '[+] Enable IP Forwarding'
sudo sysctl -w net.ipv4.ip_forward=1
sudo sed -i '/net.ipv4.ip_forward/d' /etc/sysctl.conf
echo 'net.ipv4.ip_forward=1' | sudo tee -a /etc/sysctl.conf

echo '[+] NAT setup'
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

echo '[+] Persist rules'
sudo netfilter-persistent save
sudo netfilter-persistent reload

echo '[✓] Completed.'
