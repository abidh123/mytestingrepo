param location string
param applicationGatewayName string
param tier string
param skuSize string
param capacity int = 2
param subnetName string
param zones array  
  

param virtualNetworkName string
param virtualNetworkPrefix array 
param publicIpZones array
param publicIpAddressName array
param sku array
param allocationMethod array
param ipAddressVersion array
param autoScaleMaxCapacity int

var vnetId = resourceId('Appgw-rg', 'Microsoft.Network/virtualNetworks/', virtualNetworkName)
var publicIPRef = [
  publicIpAddressName_0.id
]
var subnetRef = '${vnetId}/subnets/${subnetName}'
var applicationGatewayId = resourceId('Microsoft.Network/applicationGateways',applicationGatewayName)

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-09-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: virtualNetworkPrefix
    }
    subnets: [
      {
        name: 'appgwsubnet'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
}

resource applicationGateway 'Microsoft.Network/applicationGateways@2023-02-01' = {
  name: applicationGatewayName
  location: location
  zones: zones
  tags: {}
  properties: {
    sku: {
      name: skuSize
      tier: tier
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: subnetRef
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGwPublicFrontendIpIPv4'
        properties: {
          publicIPAddress: {
            id: publicIPRef[0]
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_80'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'Mybackendpool'
        properties: {
          backendAddresses: []
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'backendagw'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          requestTimeout: 20
          connectionDraining: {
            drainTimeoutInSec: 60
            enabled: true
          }
        }
      }
    ]
    backendSettingsCollection: []
    httpListeners: [
      {
        name: 'Httplistner'
        properties: {
          frontendIPConfiguration: {
            id: '${applicationGatewayId}/frontendIPConfigurations/appGwPublicFrontendIpIPv4'
          }
          frontendPort: {
            id: '${applicationGatewayId}/frontendPorts/port_80'
          }
          protocol: 'Http'
          sslCertificate: null
        }
      }
    ]
    listeners: []
    requestRoutingRules: [
      {
        name: 'MyRule'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: '${applicationGatewayId}/httpListeners/Httplistner'
          }
          priority: 1
          backendAddressPool: {
            id: '${applicationGatewayId}/backendAddressPools/Mybackendpool'
          }
          backendHttpSettings: {
            id: '${applicationGatewayId}/backendHttpSettingsCollection/backendagw'
          }
        }
      }
    ]
    routingRules: []
    enableHttp2: true
    sslCertificates: []
    probes: []
    autoscaleConfiguration: {
      minCapacity: capacity
      maxCapacity: autoScaleMaxCapacity
    }
    firewallPolicy: {
      id: '/subscriptions/e872e2e5-a98e-44d9-a891-9ac18c7444c8/resourceGroups/Appgw-rg/providers/Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/waf'
    }
  }
  
}






resource publicIpAddressName_0 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: publicIpAddressName[0]
  location: location
  sku: {
    name: sku[0]
  }
  zones: publicIpZones
  properties: {
    publicIPAddressVersion: ipAddressVersion[0]
    publicIPAllocationMethod: allocationMethod[0]
  }
  
}

