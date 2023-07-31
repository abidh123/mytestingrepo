param virtualnetworkname string = 'Myvnet'
param location string = 'centralindia'
param vnetaddressspace string = '10.0.0.0/16'
param ddosProtectionPlanEnabled bool = true
param enableVmProtection bool = true
param subnetname string = 'AppGwsubnet'
param subnet2name string = 'front-door-subnet'
param subnetaddressspace string = '10.0.0.0/24'
param subnet2addresspace string = '10.0.2.0/24'
param nsgname string = 'appgwnsg'
param nsggroupname string = 'appgwnsg'
param priority int = 100
param protocol string = 'Tcp'
param access string = 'Allow'
param direction string = 'Inbound'
param publicIpAddressName2 array = ['Mypublicip']
param sku string = 'Standard'
param skutier string = 'Regional'
param vmname string  = 'vms-001'
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

module VNET '../Virtualnetwork/Virtualnetwork.bicep'= {
  name: 'Vnetmodule'
  params: {
  virtualnetworkname: virtualnetworkname
  location: location
  vnetaddressspace: vnetaddressspace
  ddosProtectionPlanEnabled: ddosProtectionPlanEnabled
  enableVmProtection: enableVmProtection
  subnetname: subnetname
  subnet2name: subnet2name
  subnet2addresspace: subnet2addresspace
  subnetaddressspace: subnetaddressspace
  access: access
  nsggroupname: nsggroupname
  nsgname: nsgname
  priority: priority
  protocol: protocol
  direction: direction
  publicIpAddressName2: publicIpAddressName2
  sku: sku
  skutier: skutier
  vmname: vmname
  vmadminuser: vmadminuser
  vmpassword: vmpassword
  ultraSSDEnabled: ultraSSDEnabled
  applicationGatewayName: applicationGatewayName
  tier: tier
  skuSize: skuSize
  capacity: capacity
  publicIpAddressName: publicIpAddressName
  allocationMethod: allocationMethod
  ipAddressVersion: ipAddressVersion
  autoScaleMaxCapacity: autoScaleMaxCapacity
  frontDoorEndpointName: frontDoorEndpointName
  FrontDoorProfile: FrontDoorProfile
  FrontendOriginGroups: FrontendOriginGroups

  }
  

}
 
