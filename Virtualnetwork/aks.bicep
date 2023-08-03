param aksclustername string = 'newaks'
param location string = 'centralindia'
param skutype string = 'Base'
param skutier string = 'Free'
param enableazurerbac bool = true
param virtualnetworkname string = 'My-vnet'
param vnetaddressspace string = '10.0.0.0/16'
param enableVmProtection bool = true




resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: virtualnetworkname
  location: location
  properties: {

    addressSpace: {
      addressPrefixes: [
        vnetaddressspace
      ]
    }
    subnets: [
      {
        name: 'aksnew2subnet'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
    enableVmProtection: enableVmProtection
  }
}



resource aksCluster 'Microsoft.ContainerService/managedClusters@2023-05-02-preview' = {
  name: aksclustername
  location: location
  
  sku: {
    name: skutype
    tier: skutier
  }

  identity: {
    type: 'SystemAssigned'
  }

  properties: {
    aadProfile: {
      managed: true
      enableAzureRBAC: enableazurerbac
      
    }

    apiServerAccessProfile: {
      
      enablePrivateCluster: false
      
}
    
    publicNetworkAccess: 'Enabled' 
    autoUpgradeProfile: {
      upgradeChannel: 'patch'
    }
    identityProfile: {}
    networkProfile: {
      networkPlugin: 'azure'
      networkPolicy: 'azure'
      loadBalancerSku: 'standard'
      networkPluginMode: 'overlay'
      

    }
    kubernetesVersion: '1.25.11'
    dnsPrefix: 'dnsprefix'
    enableRBAC: true
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: 1
        vmSize: 'standard_d2s_v3'
        vnetSubnetID: virtualNetwork.properties.subnets[0].id
        osType: 'Linux'
        mode: 'System'
        availabilityZones: [
          '1'
        ]
        enableAutoScaling: true
        maxPods: 110
        maxCount: 2
        minCount: 1
        nodeLabels: {}
        osSKU:'Ubuntu'
        
        

      }
    ]
    nodeResourceGroup: 'dev'
    upgradeSettings: {
      overrideSettings: {
        controlPlaneOverrides:  [
          'IgnoreKubernetesDeprecations'

        ]

      }
    }
    
    nodeResourceGroupProfile: {
      restrictionLevel: 'Unrestricted'
}

    
    

  }

}
