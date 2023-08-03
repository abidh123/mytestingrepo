@secure()
param vmpassword string
param vmadminuser string = 'Azureuser'
param ultraSSDEnabled bool = true
param applicationGatewayName string = 'NewappgatewayWAF'
param tier string = 'WAF_v2'
param skuSize string = 'WAF_v2'
param capacity int = 2
//param subnetName string 
param publicIpAddressName array = ['AppGW-IPWAF']
//param sku array 
param allocationMethod array = ['Static']
param ipAddressVersion array =['IPv4']
param autoScaleMaxCapacity int = 1
param frontDoorEndpointName string = 'afd-${uniqueString(resourceGroup().id)}'
param FrontDoorProfile string = 'MyMyFrontDoor'
param FrontendOriginGroups string = 'MyOriginGroup'
param publicIpAddressName2 array
param sku string
param skutier string
param vmname string 
@secure()
param vmpassword string
param vmadminuser string 
param ultraSSDEnabled bool
param applicationGatewayName string
param tier string 
param skuSize string 
param capacity int 
//param subnetName string 
param publicIpAddressName array 
//param sku array 
param allocationMethod array 
param ipAddressVersion array 
param autoScaleMaxCapacity int 
param frontDoorEndpointName string = 'afd-${uniqueString(resourceGroup().id)}'
param FrontDoorProfile string
param FrontendOriginGroups string

var vnetId = virtualNetwork.id
var publicIPRef = [
  publicIpAddressName_0.id
]
var publicIPRef2 = [
  publicIpAddressName_1.id
]
//var subnetRef = '${vnetId}/subnets/${subnet2name}'
var applicationGatewayId = resourceId('Microsoft.Network/applicationGateways',applicationGatewayName)

resource publicIpAddressName_1 'Microsoft.Network/publicIPAddresses@2023-02-01' = {
  name: publicIpAddressName2[0]
  location: location
  sku: {
    name: sku
    tier: skutier
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
}
resource publicIpAddressName_0 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: publicIpAddressName[0]
  location: location
  sku: {
    name: sku
    tier: skutier
  }
  zones: [
    '1'
  ]
  
  properties: {
    publicIPAddressVersion: ipAddressVersion[0]
    publicIPAllocationMethod: allocationMethod[0]
  }
}


resource networkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'myinterface123'
  location: location
  
  properties: {
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }
    enableIPForwarding: true
    

    ipConfigurations: [
      {
        name: 'myinterface123'
        properties: {
          
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIpAddressName_1.id
          }
          subnet: {
            id: subnet.id
          }


        }

      }
    ]

  }
}
resource virtualmachine 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: vmname
  location: location
  tags: {}
  

  properties: {
    additionalCapabilities: {
      ultraSSDEnabled: ultraSSDEnabled
    }
    hardwareProfile: {
      vmSize: 'Standard_B1ms'
    }
    osProfile: {
      computerName: 'vms001'
      adminUsername: vmadminuser
      adminPassword: vmpassword
      allowExtensionOperations: true
      
    }
    

    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '18.04-LTS'
        version: 'latest'
      }
      osDisk: {
        name: 'name'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      
      networkInterfaces: [
        {
          id: networkInterface.id
          
          
        }
      ]

    

    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        
      }
    }
  }
  dependsOn: [
    virtualNetwork
  ]
  
}

resource symbolicname 'Microsoft.Network/applicationGateways@2022-07-01' = {
  name: applicationGatewayName
  location: location
  tags: {
  }
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
            id: subnet2.id
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
        name: 'AppGWBE'
        properties: {
          backendAddresses: [
            {
              ipAddress: publicIpAddressName_1.properties.ipAddress
            }
          ]
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'AppGWBESetting'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Enabled'
          requestTimeout: 30
          affinityCookieName: 'ApplicationGatewayAffinity'
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
        name: 'AppGWListner'
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
            id: '${applicationGatewayId}/httpListeners/AppGWListner'
          }
          priority: 10000
          backendAddressPool: {
            id: '${applicationGatewayId}/backendAddressPools/AppGWBE'
          }
          backendHttpSettings: {
            id: '${applicationGatewayId}/backendHttpSettingsCollection/AppGWBESetting'
          }
        }
      }
    ]
    routingRules: []
    enableHttp2: true
    sslCertificates: []
    probes: []
    autoscaleConfiguration: {
      maxCapacity: capacity
      minCapacity: autoScaleMaxCapacity
    }
    webApplicationFirewallConfiguration: {
      enabled: true
      firewallMode: 'Detection'
      ruleSetType: 'OWASP'
      ruleSetVersion: '3.1'
      disabledRuleGroups: [
        {
          ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
          rules: [
            920320
          ]
        }
      ]
      
      exclusions: [
      ]
      
      requestBodyCheck: false
      
    }  
  }
  dependsOn: [
    virtualmachine
  ]
  zones: [
    '1'
  ]
}

resource frontdoorprofile 'Microsoft.Cdn/profiles@2023-05-01' = {
  name: FrontDoorProfile
  location: 'global'
  sku: {
    name: 'Standard_AzureFrontDoor'

  }
  
}
resource frontdoorendpoints 'Microsoft.Cdn/profiles/afdEndpoints@2023-05-01' = {
  name: frontDoorEndpointName
  location: 'global'
  parent: frontdoorprofile
  properties: {
    enabledState: 'Enabled'
  }
}

resource frontendorigingroups 'Microsoft.Cdn/profiles/originGroups@2023-05-01' = {
  name: FrontendOriginGroups
  parent: frontdoorprofile
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3 
    }
    healthProbeSettings: {
      probePath: '/'
      probeProtocol: 'Http'
      probeIntervalInSeconds: 100
      probeRequestType: 'HEAD'
    }
  }
}

resource frontdoororigin 'Microsoft.Cdn/profiles/originGroups/origins@2023-05-01' = {
  name: FrontendOriginGroups
  parent: frontendorigingroups
  properties: {
    hostName: publicIpAddressName_0.properties.ipAddress
    httpPort: 80
    httpsPort: 443
    priority: 1
    weight: 1000
  }
  dependsOn: [
    symbolicname
  ]
}

resource frontdoorroute 'Microsoft.Cdn/profiles/afdEndpoints/routes@2023-05-01' = {
  name: 'MyRoute'
  parent: frontdoorendpoints
  dependsOn: [
    frontdoororigin
  ]
  properties: {
    originGroup: {
      id: frontendorigingroups.id
    }
    supportedProtocols: [
      'Http'
    ]
    patternsToMatch: [
      '/*'
    ]
    forwardingProtocol: 'HttpOnly'
    linkToDefaultDomain: 'Enabled'
  }
}
