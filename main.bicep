targetScope='subscription'

param rgName string = 'gebarg'

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: rgName
  location: 'westeurope'
  tags:{
    'environment': 'dev'
  }
}

module vnet 'modules/vnet.bicep' = {
  name: 'vnet-geba'
  scope: rg
  params: {
    vnetName: 'vnet-geba'
    vnetAddressPrefix: '10.30.0.0/16'
    vnetSubnets:[
      {
        name: 'servers'
        addressPrefix: '10.30.1.0/24'
      }
      {
        name: 'AzureBastionSubnet'
        addressPrefix: '10.30.2.0/24'
      }
    ]
  }
}

module bastion 'modules/bastion.bicep' = {
  name: 'bast-geba'
  scope: rg
  params: {
    bastionName: 'bast-geba'
    vnetName: vnet.outputs.name
  }
}
