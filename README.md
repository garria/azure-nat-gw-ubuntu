
# Azure VNet Gateway Ubuntu (NAT Router)

Questa soluzione deploya una VM Ubuntu 22.04 configurata automaticamente come
NAT Gateway per una Virtual Network Azure, con approccio modulare stile opnazure.

## Funzionalità
- NAT via iptables (MASQUERADE)
- IP forwarding attivo e persistente
- Subnet dedicata per gateway + route table automatica
- Deploy modulare (Bicep)
- Script di diagnostica e manutenzione
- Cloud-init per auto-configurazione completa
- Validazione CI per Bicep (GitHub Actions)

## Deploy rapido (pulsante)
https://portal.azure.com/#create/Microsoft.Template/uri/https://raw.githubusercontent.com/garria/azure-vnet-gateway-ubuntu/main/deploy/azuredeploy.json

## Deploy via CLI
```bash
az deployment group create           --resource-group RG-GW           --template-file deploy/main.bicep           --parameters adminPassword=MyPassw0rd!
```

Documentazione tecnica in `/docs`.
