param aksclustername string = 'newaks'
param location string = 'centralindia'
param skutype string = 'Basic'
param skutier string = 'Free'
param enableazurerbac bool = true


resource aksCluster 'Microsoft.ContainerService/managedClusters@2023-05-02-preview' = {
  name: aksclustername
  location: location
  sku: {
    name: skutype
    tier: skutier
  }

  identity: {
    type: 'SystemAssigned'
    userAssignedIdentities: {}
  }

  properties: {
    aadProfile: {
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
    kubernetesVersion: '1.19.7'
    dnsPrefix: 'dnsprefix'
    enableRBAC: true
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: 1
        vmSize: 'Standard B2s'
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
        osDiskType: 'Ephemeral'
        vnetSubnetID: 'sssss'

      }
    ]
    

  }

}
