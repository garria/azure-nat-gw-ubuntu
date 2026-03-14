
# Troubleshooting

## Verifiche base
```bash
ip route
sysctl net.ipv4.ip_forward
sudo iptables -t nat -L -n -v
curl -s https://ifconfig.me
```

## Test con una VM nella AppSubnet
- ping 8.8.8.8
- curl http://example.com
