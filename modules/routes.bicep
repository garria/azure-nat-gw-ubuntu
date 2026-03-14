
param appSubnetId string
param gatewayPrivateIp string
param location string = resourceGroup().location

resource rt 'Microsoft.Network/routeTables@2023-09-01' = {
  name: 'rt-gateway'
  location: location
  properties: {
    routes: [
      {
        name: 'default-route'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: gatewayPrivateIp
        }
      }
    ]
  }
}
