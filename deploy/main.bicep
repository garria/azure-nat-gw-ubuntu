
param location string = resourceGroup().location
param adminUsername string = 'azureuser'
@secure()
param adminPassword string

param vnetName string = 'vnet-gw'
param gwSubnetCidr string = '10.10.0.0/24'
param appSubnetCidr string = '10.10.1.0/24'
@description('IP privato statico della VM Gateway nella GatewaySubnet')
param gatewayPrivateIp string = '10.10.0.4'

// VNet + Subnet
module vnet './modules/vnet.bicep' = {
  name: 'vnet'
  params: {
    vnetName: vnetName
    gwSubnetCidr: gwSubnetCidr
    appSubnetCidr: appSubnetCidr
  }
}

// Route table con default route verso il gateway
module routes './modules/routes.bicep' = {
  name: 'routes'
  params: {
    appSubnetId: vnet.outputs.appSubnetId
    gatewayPrivateIp: gatewayPrivateIp
  }
}

// VM gateway Ubuntu
module gatewayvm './modules/gatewayvm.bicep' = {
  name: 'gatewayvm'
  params: {
    adminPassword: adminPassword
    adminUsername: adminUsername
    gwSubnetId: vnet.outputs.gwSubnetId
    location: location
    gatewayPrivateIp: gatewayPrivateIp
  }
}

output publicIp string = gatewayvm.outputs.publicIp
