param location string ='centralindia'
param applicationGatewayName string = 'NewappgatewayWAF'
param tier string = 'WAF_v2'
param skuSize string = 'WAF_v2'
param capacity int = 1
param subnetName string ='Appgateway'
param publicIpAddressName array = ['AppGW-IPWAF']
param sku array = ['Standard']
param allocationMethod array = ['Static']
param ipAddressVersion array = ['IPv4']
param autoScaleMaxCapacity int = 2

module AppGW 'AppGW.bicep' = {
  name: 'Newappgateway'
  params: {
    location: location
    applicationGatewayName: applicationGatewayName
    tier: tier
    skuSize: skuSize
    capacity: capacity
    subnetName: subnetName
    publicIpAddressName: publicIpAddressName
    sku: sku
    allocationMethod: allocationMethod
    ipAddressVersion: ipAddressVersion
    autoScaleMaxCapacity: autoScaleMaxCapacity
  }
  
}

