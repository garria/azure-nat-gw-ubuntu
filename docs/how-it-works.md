
# Come funziona il Gateway

Il gateway effettua NAT (MASQUERADE) sull'interfaccia eth0.
Le VM nella AppSubnet puntano la default route verso l'IP del gateway.
iptables -> NAT -> Internet.
