param aksclustername string
param location string
param sku string
param tier string
param identity string
param 

resource aksagentpools 'Microsoft.ContainerService/managedClusters/agentPools@2023-05-02-preview' = {
  name: 
}

resource aksCluster 'Microsoft.ContainerService/managedClusters@2021-03-01' = {
  name: aksclustername
  location: location
  sku: {
    name: sku
    tier: tier
  }
  
  identity: {
    type: identity
  }
  properties: {
    
    aadProfile: {
      enableAzureRBAC: true
      managed: true
    }
    addonProfiles: {}
    
    
    kubernetesVersion: '1.19.7'
    dnsPrefix: 'dnsprefix'
    enableRBAC: true
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: 3
        vmSize: 'Standard_DS2_v2'
        osType: 'Linux'
        mode: 'System'
      }
    ]
    linuxProfile: {
      adminUsername: 'adminUserName'
      ssh: {
        publicKeys: [
          {
            keyData: 'REQUIRED'
          }
        ]
      }
    }
  }
}
