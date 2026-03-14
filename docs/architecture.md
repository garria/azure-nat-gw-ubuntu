
# Architettura

La soluzione crea:
- 1 VNet (10.10.0.0/16)
- 1 GatewaySubnet (10.10.0.0/24)
- 1 AppSubnet (10.10.1.0/24)
- 1 VM Ubuntu come NAT Router
- 1 Route Table con 0.0.0.0/0 verso l'IP privato del gateway (es. 10.10.0.4)
