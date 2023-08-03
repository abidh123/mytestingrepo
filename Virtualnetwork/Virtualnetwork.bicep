param virtualnetworkname string 
param location string 
param vnetaddressspace string   
param AppGatewaysubnetname string 
param Functionappsubnetname string
param APIMSubnetname string
param PrivateEndpointSubnetname string
param AppGWsubnetaddressspace string 
param Functionappsubnetaddresspace string
param APIMsubnetaddressspace string
param Privateendpointsubnetaddressspace string
param APPGWNSG string
param APIMNSG string
param FANSG string
param APPGWNSGgroupname string
param APIMNSGgroupname string
param FANSGGroupname string
param priority int 
param protocol string 
param access string
param direction string
param Natgatewayname string
param NatgatewaySKU string
param idleTimeoutInMinutes int
param Publicipname string
param Publicipsku string
param Publicipskutier string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: virtualnetworkname
  location: location
  properties: {

    addressSpace: {
      addressPrefixes: [
        vnetaddressspace
      ]
    }
  }
}
resource APPGatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2023-02-01' = {
  name: AppGatewaysubnetname
  parent: virtualNetwork

  properties: {
    addressPrefix: AppGWsubnetaddressspace
     
    networkSecurityGroup: {
      id: AppGWNetworkSecurityGroup.id
    }
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Disabled'

  }
}
resource APIMSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-02-01' = {
  name: APIMSubnetname
  parent: virtualNetwork
  properties: {
    addressPrefix: APIMsubnetaddressspace
    networkSecurityGroup: {
      id: APIMNetworkSecurityGroup.id
    }
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Disabled'

  }
}
resource PrivateEndpointSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-02-01' = {
  name: PrivateEndpointSubnetname
  parent: virtualNetwork
  properties: {
    addressPrefix: Privateendpointsubnetaddressspace
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Disabled'

  }
}
resource FunctionappSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-02-01' = {
  name: Functionappsubnetname
  parent: virtualNetwork
  properties: {
    addressPrefix: Functionappsubnetaddresspace
    networkSecurityGroup: {
      id: FANetworksecuritygroup.id
    }
    natGateway: {
      id: NatGateway.id
    }
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Disabled'

  }
}
resource AppGWNetworkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: APPGWNSG
  location: location
  properties: {
    securityRules: [
      {
        name: APPGWNSGgroupname
        properties: {
          
          protocol: protocol
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: access
          priority: priority
          direction: direction
        }
      }
    ]
  }
  
  
}
resource APIMNetworkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: APIMNSG
  location: location
  properties: {
    securityRules: [
      {
        name: APIMNSGgroupname
        properties: {
          
          protocol: protocol
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: access
          priority: priority
          direction: direction
        }
      }
    ]
  }
  
  
}

resource FANetworksecuritygroup 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: FANSG
  location: location
  properties: {
    securityRules: [
      {
        name: FANSGGroupname
        properties: {
          
          protocol: protocol
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: access
          priority: priority
          direction: direction
        }
      }
    ]
  }
  
}
resource publicIpAddressName_1 'Microsoft.Network/publicIPAddresses@2023-02-01' = {
  name: Publicipname
  location: location
  sku: {
    name: Publicipsku
    tier: Publicipskutier
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
}

resource NatGateway 'Microsoft.Network/natGateways@2023-04-01' = {
  name: Natgatewayname
  location: location
  sku: {
    name: NatgatewaySKU
  }
  properties: {
    idleTimeoutInMinutes: idleTimeoutInMinutes
    publicIpAddresses: [
      {
        id: publicIpAddressName_1.id
      }
    ]
  }
}
output Vnetid string = virtualNetwork.id
output Vnetname string = virtualNetwork.name
output AppGWsubnetid string = APPGatewaySubnet.id
output APIMsubnetid string = APIMSubnet.id
output PrivateSubnetid string = PrivateEndpointSubnet.id
output Functionappsubnetid string = FunctionappSubnet.id
output Natgatewayid string = NatGateway.id
output Natgatewayname string = NatGateway.name









  







