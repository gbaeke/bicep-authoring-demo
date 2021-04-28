param bastionName string
param vnetName string

resource bastionIP 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'ip-${bastionName}'
  location: resourceGroup().location
  properties:{
    publicIPAllocationMethod: 'Static'
  }
  sku:{
    name: 'Standard'
  }
}

resource bastion 'Microsoft.Network/bastionHosts@2020-11-01' = {
  name: bastionName
  location: resourceGroup().location
  properties: {
   ipConfigurations: [
     {
        name: 'ipconfig1'
        properties:{
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, 'AzureBastionSubnet')
          }
          publicIPAddress: {
            id: bastionIP.id
          }
          privateIPAllocationMethod: 'Dynamic'
        }      
     }
   ] 
  }
}
