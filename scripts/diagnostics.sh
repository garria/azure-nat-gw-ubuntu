
#!/bin/bash
echo '== Interfaces =='
ip a
echo
echo '== Forwarding Status =='
sysctl net.ipv4.ip_forward
echo
echo '== NAT Rules =='
sudo iptables -t nat -L -n -v
echo
echo '== Ping test =='
ping -c 2 8.8.8.8 || true
