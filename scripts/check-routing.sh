
#!/bin/bash
echo '[Routing Table]'
ip route
echo
echo '[NAT Rules]'
sudo iptables -t nat -L -n -v
