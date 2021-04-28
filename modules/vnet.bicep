param vnetName string
param vnetAddressPrefix string
param vnetSubnets array

resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: vnetName
  location: resourceGroup().location
  properties:{
    addressSpace: {
      addressPrefixes:[
        vnetAddressPrefix
      ]
    }
    subnets:[for item in vnetSubnets: {
      name: item.name
      properties: {
        addressPrefix: item.addressPrefix
      }
    }]
  }
}

output name string = vnetName
