//param location string = 'centralindia'
param frontDoorEndpointName string = 'afd-${uniqueString(resourceGroup().id)}'

resource frontdoorprofile 'Microsoft.Cdn/profiles@2023-05-01' = {
  name: 'MyMyFrontDoor'
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
  name: 'MyOriginGroup'
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
  name: 'MyOriginGroup'
  parent: frontendorigingroups
  properties: {
    hostName: '20.193.137.195'
    httpPort: 80
    httpsPort: 443
    priority: 1
    weight: 1000
  }
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
