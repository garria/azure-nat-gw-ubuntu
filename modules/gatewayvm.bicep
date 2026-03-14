
param adminPassword string
param adminUsername string
param gwSubnetId string
param location string
@description('Indirizzo IP privato statico per la NIC del gateway')
param gatewayPrivateIp string

resource pip 'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: 'gw-pip'
  location: location
  sku: { name: 'Standard' }
  properties: { publicIPAllocationMethod: 'Static' }
}

resource nic 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: 'gw-nic'
  location: location
  properties: {
    enableIPForwarding: true
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: { id: gwSubnetId }
          privateIPAllocationMethod: 'Static'
          privateIPAddress: gatewayPrivateIp
          publicIPAddress: { id: pip.id }
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: 'ubuntu-gateway'
  location: location
  properties: {
    hardwareProfile: { vmSize: 'Standard_B1s' }
    osProfile: {
      computerName: 'ubuntu-gateway'
      adminUsername: adminUsername
      adminPassword: adminPassword
      customData: loadFileAsBase64('../deploy/cloud-init.yaml')
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts'
        version: 'latest'
      }
      osDisk: { createOption: 'FromImage' }
    }
    networkProfile: { networkInterfaces: [{ id: nic.id }] }
  }
}

output publicIp string = pip.properties.ipAddress
