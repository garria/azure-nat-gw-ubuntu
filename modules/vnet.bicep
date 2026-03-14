
param vnetName string
param gwSubnetCidr string
param appSubnetCidr string
param location string = resourceGroup().location

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: { addressPrefixes: ['10.10.0.0/16'] }
    subnets: [
      { name: 'GatewaySubnet', properties: { addressPrefix: gwSubnetCidr } },
      { name: 'AppSubnet',     properties: { addressPrefix: appSubnetCidr } }
    ]
  }
}

output gwSubnetId string = vnet.properties.subnets[0].id
output appSubnetId string = vnet.properties.subnets[1].id
