param vmname string = 'vms001'
param ultraSSDEnabled bool = true
@secure()
param vmpassword string
param vmadminuser string = 'Azureuser'
param location string = 'centralindia' 
param applicationGatewayName string ='NewappgatewayWAF'
param tier string = 'WAF_v2'
param skuSize string = 'WAF_v2'
param subnetName string = 'front-door-subnet'
param capacity int = 2
param publicIpAddressName array = ['AppGW-IPWAF']
param sku array = ['Standard']
param allocationMethod array =['Static']
param ipAddressVersion array = ['IPv4']
param autoScaleMaxCapacity int  = 1 


var vnetId = '/subscriptions/e872e2e5-a98e-44d9-a891-9ac18c7444c8/resourceGroups/newdev/providers/Microsoft.Network/virtualNetworks/Myvnet'
var networkinterfaceid = '/subscriptions/e872e2e5-a98e-44d9-a891-9ac18c7444c8/resourceGroups/newdev/providers/Microsoft.Network/networkInterfaces/myinterface123'
var publicipaddress= '20.235.83.98'

var publicIPRef = [
  publicIpAddressName_0.id
]
var subnetRef = '${vnetId}/subnets/${subnetName}'
var applicationGatewayId = resourceId('Microsoft.Network/applicationGateways',applicationGatewayName)

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
          id: networkinterfaceid
          
          
        }
      ]

    

    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        
      }
    }
  }
  
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
        name: 'AppGWBE'
        properties: {
          backendAddresses: [
            {
              ipAddress: publicipaddress
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
  zones: [
    '1'
  ]
}

resource publicIpAddressName_0 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: publicIpAddressName[0]
  location: location
  sku: {
    name: sku[0]
  }
  zones: [
    '1'
  ]
  
  properties: {
    publicIPAddressVersion: ipAddressVersion[0]
    publicIPAllocationMethod: allocationMethod[0]
  }
}




