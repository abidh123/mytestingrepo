param virtualnetworkname string = 'Kerry_VNET_Sandbox'
param location string = 'northeurope'
param vnetaddressspace string = '172.29.0.0/16'
param AppGatewaysubnetname string = 'AppGwsubnet'
param APIMSubnetname string = 'APIMSubnet'
param PrivateEndpointSubnetname string = 'PVTsubnet'
param Functionappsubnetname string = 'Functionappsubnet'
param AppGWsubnetaddressspace string = '172.29.24.0/20'
param Functionappsubnetaddresspace string = '172.29.26.0/28'
param APIMsubnetaddressspace string = '172.29.33.0/26'
param Privateendpointsubnetaddressspace string = '172.29.43.0/24'
param APPGWNSG string = 'appgwnsg'
param APIMNSG string = 'apimnsg'
param FANSG string = 'functionnsg'
param APPGWNSGgroupname string = 'appgwnsg'
param APIMNSGgroupname string = 'apimnsg'
param FANSGGroupname string = 'functionnsg'
param Natgatewayname string = 'Kerry_Natgateway'
param NatgatewaySKU string = 'Standard'
param idleTimeoutInMinutes int = 4
param priority int = 100
param protocol string = 'Tcp'
param access string = 'Allow'
param direction string = 'Inbound'
param Publicipname string = 'NatGwpublicip'
param Publicipsku string = 'Standard'
param Publicipskutier string = 'Regional'


module VNET '../Virtualnetwork/Virtualnetwork.bicep'= {
  name: 'Vnetmodule'
  params: {
  virtualnetworkname: virtualnetworkname
  location: location
  vnetaddressspace: vnetaddressspace
  AppGatewaysubnetname: AppGatewaysubnetname
  APIMSubnetname: APIMSubnetname
  PrivateEndpointSubnetname: PrivateEndpointSubnetname
  Functionappsubnetname: Functionappsubnetname
  AppGWsubnetaddressspace: AppGWsubnetaddressspace
  APIMsubnetaddressspace: APIMsubnetaddressspace
  Privateendpointsubnetaddressspace: Privateendpointsubnetaddressspace
  Functionappsubnetaddresspace: Functionappsubnetaddresspace
  APPGWNSG: APPGWNSG
  APPGWNSGgroupname: APPGWNSGgroupname
  APIMNSG: APIMNSG
  APIMNSGgroupname: APIMNSGgroupname
  FANSG: FANSG
  FANSGGroupname: FANSGGroupname
  access: access
  priority: priority
  protocol: protocol
  direction: direction
  Publicipname: Publicipname
  Publicipsku: Publicipsku
  Publicipskutier: Publicipskutier
  Natgatewayname: Natgatewayname
  NatgatewaySKU: NatgatewaySKU
  idleTimeoutInMinutes: idleTimeoutInMinutes
  }
  

}
 
