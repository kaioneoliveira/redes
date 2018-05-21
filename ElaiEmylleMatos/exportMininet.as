/* Discentes:
* Elai Emylle Matos de Lima
* Isabelle Borges Santos Vieira
* João Vitor Rebouças
* Laiane Pereira
* Maile Caroline Santos Novaes
* Sara Costa
*/


import action_alert.HMensagens;


import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.FileReference;
import flash.net.URLRequest;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.events.Request;
public var fileRefScript_mininet:FileReference;// = new FileReference();

public function exportMininetScriptFile():void {
	var objSend:Object = new Object;
	var temp_mininet:ArrayCollection=new ArrayCollection();
	var objeto_mininet:Object=new Object();
	var cont_mininet:int=0;
	var expo:Boolean=true;	
	var computerMask:String;
	var stationMask:String;
	var computerIPAddress:String;
	var stationIPAddress:String;
	var arrayStationPassword:String;
	var arrayNumberOfRadios:String;
	var arraySignalRange:String;
	var computerMacAddress:String;
	var stationMacAddress:String;
	var controllerPort:String;
	var countControllerSource:String;
	var countControllerDestination:String;
	var countSwitchSource:String;
	var countSwitchDestination:String;
	var ssid:String;
	var storeSwitches:Array=[];
	var storeConnectivity:Array=[];
	var stations:Array=[];
	var exists:Boolean=false;
	var controllerIPAddress:String;
	var isRemote:Boolean;
	var urlRequest:URLRequest;
	var ab:int;
	var p:int;
	var i:int;
	var j:int;
	var ir:int;
	var isWireless:Boolean=false;
	var nRadios:int=0;
	var x:int;
	//CHECK VALUES
	//----------------------------------------------------------------------
	for(p=0;p<dropCanvas.numChildren;p++){	
		var UIob:Object = dropCanvas.getChildAt(p);
		if(UIob.className =='objects'){
			var ob:objects=UIob as objects;		
			for(ir=0;ir<(ob.objparaArrayCol.length);ir++){
				obj=ob.objparaArrayCol[ir] as objParameter;
				if(ob.id=="Access Point"||ob.id=="Switch"){
					if(obj.name=="switch"){	
						switch_ = obj.arraySwitch;	
						if(switch_=="user")
							switch_="UserSwitch"
						else if(switch_=="ovsk")
							switch_="OVSKernelSwitch"
						else if(switch_=="ivs")
							switch_="IVSSwitch"
						else
							switch_="OVSKernelSwitch"
					}
				}
			}
		}
	}
	//----------------------------------------------------------------------
	cont_mininet++;
	sh = "#!/usr/bin/python@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "\n\"\"\"@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "Script created by VND - Visual Network Description (SDN version)@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "\"\"\"@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "from mininet.wifi.net import Mininet_wifi@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "from mininet.node import Controller, RemoteController@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "from mininet.wifi.cli import CLI_wifi@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "from mininet.log import setLogLevel@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "from mininet.wifi.node import OVSKernelAP@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "def topology():@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "    print \"*** Create a network.\" @@";
	objeto_mininet=sh;
	/*temp_mininet.addItem(objeto_mininet);
	sh = "    net = Mininet_wifi(controller=RemoteController, accessPoint=OVSKernelAP)@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);*/
	
	for(p=0;p<dropCanvas.numChildren;p++){			
		UIob = dropCanvas.getChildAt(p);
		if(UIob.className =='objects'){
			ob=UIob as objects;	
			if(ob.id=="Station"||ob.id=="Access Point"){
				isWireless=true;
				nRadios=nRadios+1;
			}			
		}
	}
	
	if(isWireless){		
		for(j=0;j<dropCanvas.numChildren;j++){	
			UIob = dropCanvas.getChildAt(j);
			if(UIob.className=='Link'){
				var obLink:Link=UIob as Link;
				if(obLink.can.lineName=="wireless"||obLink.can.lineName=="fiber"||obLink.can.lineName=="ethernet"){		
					if(j==0){
						for(p=0;p<dropCanvas.numChildren;p++){	
							intnew=1;
							
							UIob = dropCanvas.getChildAt(p);
							if(UIob.className =='objects'){
								ob=UIob as objects;	
								if(ob.id=="Controller"){
									for(i=0;i<(ob.objparaArrayCol.length);i++){
										obj=ob.objparaArrayCol[i] as objParameter;
									}		
									for(ir=0;ir<(ob.objparaArrayCol.length);ir++){
										obj=ob.objparaArrayCol[ir] as objParameter;
										
										if(obj.name=="remoteLocal"){												
											isRemote = obj.isRemote;	
										}	
									}
								}
							}
						}
						if(isRemote){
							cont_mininet++;
							sh = "    net = Mininet_wifi( controller=RemoteController, accessPoint=OVSKernelAP )@@";
							objeto_mininet=sh;
							temp_mininet.addItem(objeto_mininet);
						}
						else{
							cont_mininet++;
							sh = "    net = Mininet_wifi( controller=RemoteController,accessPoint=OVSKernelAP )@@";
							objeto_mininet=sh;
							temp_mininet.addItem(objeto_mininet);
						}
					}
				}
			}
		}
		
	}
	else{
		for(p=0;p<dropCanvas.numChildren;p++){	
			intnew=1;
			if(p==0){
				cont_mininet++;
				sh = "@@";
				objeto_mininet=sh;
				cont_mininet++;
			}
			UIob = dropCanvas.getChildAt(p);
			if(UIob.className =='objects'){
				ob=UIob as objects;	
				if(ob.id=="Controller"){		
					for(i=0;i<(ob.objparaArrayCol.length);i++){
						obj=ob.objparaArrayCol[i] as objParameter;
					}		
					for(ir=0;ir<(ob.objparaArrayCol.length);ir++){
						obj=ob.objparaArrayCol[ir] as objParameter;
						
						if(obj.name=="remoteLocal"){												
							isRemote = obj.isRemote;	
						}	
					}
				}
			}
		}
		if(isRemote){
			cont_mininet++;
			sh = "    net = Mininet_wifi( controller=Controller )@@";
			objeto_mininet=sh;
			temp_mininet.addItem(objeto_mininet);
		}
		else{
			cont_mininet++;
			sh = "    net = Mininet_wifi( controller=RemoteController )@@";
			objeto_mininet=sh;
			temp_mininet.addItem(objeto_mininet);
		}
	}
	
	//----------------------------------------------------------------------
	//----------------------------------------------------------------------
	for(p=0;p<dropCanvas.numChildren;p++){	
		intnew=1;
		if(p==0){
			cont_mininet++;
			sh = "@@";
			objeto_mininet=sh;
			cont_mininet++;
			temp_mininet.addItem(objeto_mininet);
			sh = "    print \"*** Creating nodes\"@@";
			objeto_mininet=sh;
			temp_mininet.addItem(objeto_mininet);
		}
		UIob = dropCanvas.getChildAt(p);
		if(UIob.className =='objects'){
			ob=UIob as objects;	
			if(ob.id=="Station" || ob.id=="Car"){												
				for(i=0;i<(ob.objparaArrayCol.length);i++){
					var obj:objParameter=ob.objparaArrayCol[i] as objParameter;
				}		
				for(ir=0;ir<(ob.objparaArrayCol.length);ir++){
					obj=ob.objparaArrayCol[ir] as objParameter;									
					if(obj.name=="IPAddress"){												
						stationIPAddress = obj.IPAddress;
					}	
					else if(obj.name=="MacAddress"){												
						stationMacAddress = obj.MacAddress;
					}
					else if(obj.name=="signalRange"){												
						arraySignalRange = obj.range;
					}
					else if(obj.name=="numberofradios"){												
						arrayNumberOfRadios = obj.numberofRadios;
					}
					else if(obj.name=="mask"){												
						stationMask = obj.MaskAddress;
						if(stationMask=="255.0.0.0")
							stationMask="8";
						else if(stationMask=="255.128.0.0")
							stationMask="9";
						else if(stationMask=="255.192.0.0")
							stationMask="10";
						else if(stationMask=="255.224.0.0")
							stationMask="11";
						else if(stationMask=="255.240.0.0")
							stationMask="12";
						else if(stationMask=="255.248.0.0")
							stationMask="13";
						else if(stationMask=="255.252.0.0")
							stationMask="14";
						else if(stationMask=="255.254.0.0")
							stationMask="15";
						else if(stationMask=="255.255.0.0")
							stationMask="16";
						else if(stationMask=="255.255.128.0")
							stationMask="17";
						else if(stationMask=="255.255.192.0")
							stationMask="18";
						else if(stationMask=="255.255.224.0")
							stationMask="19";
						else if(stationMask=="255.255.240.0")
							stationMask="20";
						else if(stationMask=="255.255.248.0")
							stationMask="21";
						else if(stationMask=="255.255.252.0")
							stationMask="22";
						else if(stationMask=="255.255.254.0")
							stationMask="23";
						else if(stationMask=="255.255.255.0")
							stationMask="24";
						else if(stationMask=="255.255.255.128")
							stationMask="25";
						else if(stationMask=="255.255.255.192")
							stationMask="26";
						else if(stationMask=="255.255.255.224")
							stationMask="27";
						else if(stationMask=="255.255.255.240")
							stationMask="28";
						else if(stationMask=="255.255.255.248")
							stationMask="29";
						else if(stationMask=="255.255.255.252")
							stationMask="30";
					}
					
				}
				cont_mininet++;
				if(ob.id=="Car"){
					sh = "    car"+ob.nid+" = net.addCar( 'car"+ob.nid+"', wlans="+arrayNumberOfRadios+", " +
						"mac='"+stationMacAddress+"', ip='"+stationIPAddress+"/"+stationMask+"', position='"+ob.x+","+(1000-ob.y)+",0')@@";
				}
				else{
					sh = "    sta"+ob.nid+" = net.addStation( 'sta"+ob.nid+"', wlans="+arrayNumberOfRadios+", " +
						"mac='"+stationMacAddress+"', ip='"+stationIPAddress+"/"+stationMask+"', position='"+ob.x+","+(1000-ob.y)+",0' )@@";					
				}
				objeto_mininet=sh;
				temp_mininet.addItem(objeto_mininet);
			}
			if(ob.id=="Computer"){										
				for(i=0;i<(ob.objparaArrayCol.length);i++){
					obj=ob.objparaArrayCol[i] as objParameter;
				}		
				for(ir=0;ir<(ob.objparaArrayCol.length);ir++){
					obj=ob.objparaArrayCol[ir] as objParameter;									
					if(obj.name=="IPAddress"){												
						computerIPAddress = obj.IPAddress;
					}	
					else if(obj.name=="MacAddress"){												
						computerMacAddress = obj.MacAddress;
					}	
					else if(obj.name=="mask"){												
						computerMask = obj.MaskAddress;
						if(computerMask=="255.0.0.0")
							computerMask="8";
						else if(computerMask=="255.128.0.0")
							computerMask="9";
						else if(computerMask=="255.192.0.0")
							computerMask="10";
						else if(computerMask=="255.224.0.0")
							computerMask="11";
						else if(computerMask=="255.240.0.0")
							computerMask="12";
						else if(computerMask=="255.248.0.0")
							computerMask="13";
						else if(computerMask=="255.252.0.0")
							computerMask="14";
						else if(computerMask=="255.254.0.0")
							computerMask="15";
						else if(computerMask=="255.255.0.0")
							computerMask="16";
						else if(computerMask=="255.255.128.0")
							computerMask="17";
						else if(computerMask=="255.255.192.0")
							computerMask="18";
						else if(computerMask=="255.255.224.0")
							computerMask="19";
						else if(computerMask=="255.255.240.0")
							computerMask="20";
						else if(computerMask=="255.255.248.0")
							computerMask="21";
						else if(computerMask=="255.255.252.0")
							computerMask="22";
						else if(computerMask=="255.255.254.0")
							computerMask="23";
						else if(computerMask=="255.255.255.0")
							computerMask="24";
						else if(computerMask=="255.255.255.128")
							computerMask="25";
						else if(computerMask=="255.255.255.192")
							computerMask="26";
						else if(computerMask=="255.255.255.224")
							computerMask="27";
						else if(computerMask=="255.255.255.240")
							computerMask="28";
						else if(computerMask=="255.255.255.248")
							computerMask="29";
						else if(computerMask=="255.255.255.252")
							computerMask="30";
					}										
				}
				cont_mininet++;
				sh = "    h"+ob.nid+" = net.addHost( 'h"+ob.nid+"', mac='"+computerMacAddress+"', ip='"+computerIPAddress+"/"+computerMask+"')@@";
				objeto_mininet=sh;
				temp_mininet.addItem(objeto_mininet);
			}
			else if(ob.id=="Switch"){
				for(i=0;i<(ob.objparaArrayCol.length);i++){
					obj=ob.objparaArrayCol[i] as objParameter;
				}		
				for(ir=0;ir<(ob.objparaArrayCol.length);ir++){
					obj=ob.objparaArrayCol[ir] as objParameter;									
					if(obj.name=="MacAddress"){	
						macSwitch = obj.MacAddress;
					}	
					else if(obj.name=="listeningPort"){	
						listenPortSwitch = obj.listenPortSwitch;
					}
					else if(obj.name=="ofp_version"){	
						openFlowVersion = obj.openFlowVersion;
					}
				}
				cont_mininet++;
				if(openFlowVersion=="1")
					sh = "    s"+ob.nid+" = net.addSwitch( 's"+ob.nid+"', protocols='OpenFlow10', listenPort="+listenPortSwitch+", mac='"+macSwitch+"' )@@";
				else if(openFlowVersion=="1.1")
					sh = "    s"+ob.nid+" = net.addSwitch( 's"+ob.nid+"', protocols='OpenFlow11', listenPort="+listenPortSwitch+", mac='"+macSwitch+"' )@@";
				else if(openFlowVersion=="1.2")
					sh = "    s"+ob.nid+" = net.addSwitch( 's"+ob.nid+"', protocols='OpenFlow12', listenPort="+listenPortSwitch+", mac='"+macSwitch+"' )@@";
				else if(openFlowVersion=="1.3")
					sh = "    s"+ob.nid+" = net.addSwitch( 's"+ob.nid+"', protocols='OpenFlow13', listenPort="+listenPortSwitch+", mac='"+macSwitch+"' )@@";
				else if(openFlowVersion=="1.4")
					sh = "    s"+ob.nid+" = net.addSwitch( 's"+ob.nid+"', protocols='OpenFlow14', listenPort="+listenPortSwitch+", mac='"+macSwitch+"' )@@";
				else
					sh = "    s"+ob.nid+" = net.addSwitch( 's"+ob.nid+"', listenPort="+listenPortSwitch+", mac='"+macSwitch+"' )@@";
				objeto_mininet=sh;
				temp_mininet.addItem(objeto_mininet);
			}		
			else if(ob.id=="Access Point"){		
				for(i=0;i<(ob.objparaArrayCol.length);i++){
					obj=ob.objparaArrayCol[i] as objParameter;
				}		
				for(ir=0;ir<(ob.objparaArrayCol.length);ir++){
					obj=ob.objparaArrayCol[ir] as objParameter;									
					if(obj.name=="MacAddress"){	
						macSwitch = obj.MacAddress;
					}	
					else if(obj.name=="listeningPort"){	
						listenPortSwitch = obj.listenPortSwitch;
					}
					else if(obj.name=="ofp_version"){	
						openFlowVersion = obj.openFlowVersion;
					}
					else if(obj.name=="signalRange"){	
						arraySignalRange = obj.range;
					}
					else if(obj.name=="ssid"){	
						ssid = obj.ssid;
					}
					else if(obj.name=="mode"){	
						mode = obj.mode;
					}
					else if(obj.name=="channel"){	
						channel = obj.channel;
					}
				}
				cont_mininet++;
				if(openFlowVersion=="1")
					sh = "    ap"+ob.nid+" = net.addAccessPoint( 'ap"+ob.nid+"', ssid='"+ssid+"', mode= '"+mode+"', channel= '"+channel+"', position='"+ob.x+","+(1000-ob.y)+",0' )@@";
				else if(openFlowVersion=="1.1")
					sh = "    ap"+ob.nid+" = net.addAccessPoint( 'ap"+ob.nid+"', ssid='"+ssid+"', mode= '"+mode+"', channel= '"+channel+"', position='"+ob.x+","+(1000-ob.y)+",0' )@@";
				else if(openFlowVersion=="1.2")
					sh = "    ap"+ob.nid+" = net.addAccessPoint( 'ap"+ob.nid+"', ssid='"+ssid+"', mode= '"+mode+"', channel= '"+channel+"', position='"+ob.x+","+(1000-ob.y)+",0' )@@";
				else if(openFlowVersion=="1.3")
					sh = "    ap"+ob.nid+" = net.addAccessPoint( 'ap"+ob.nid+"', ssid='"+ssid+"', mode= '"+mode+"', channel= '"+channel+"', position='"+ob.x+","+(1000-ob.y)+",0' )@@";
				else if(openFlowVersion=="1.4")
					sh = "    ap"+ob.nid+" = net.addAccessPoint( 'ap"+ob.nid+"', ssid='"+ssid+"', mode= '"+mode+"', channel= '"+channel+"', position='"+ob.x+","+(1000-ob.y)+",0' )@@";
				else
					sh = "    ap"+ob.nid+" = net.addAccessPoint( 'ap"+ob.nid+"', ssid='"+ssid+"', mode= '"+mode+"', channel= '"+channel+"', position='"+ob.x+","+(1000-ob.y)+",0' )@@";
				objeto_mininet=sh;
				temp_mininet.addItem(objeto_mininet);
			}
			else if(ob.id=="Controller"){		
				for(i=0;i<(ob.objparaArrayCol.length);i++){
					obj=ob.objparaArrayCol[i] as objParameter;
				}		
				for(ir=0;ir<(ob.objparaArrayCol.length);ir++){
					obj=ob.objparaArrayCol[ir] as objParameter;
					
					if(obj.name=="controllerIPAddress"){												
						controllerIPAddress = obj.controllerIPAddress;	
					}											
					else if(obj.name=="controllerPort"){
						controllerPort = obj.controllerPort;	
					}	
					else if(obj.name=="remoteLocal"){												
						isRemote = obj.isRemote;	
					}	
				}			
				if(isRemote){
					cont_mininet++;
					sh = "    c"+ob.nid+" = net.addController( 'c"+ob.nid+"' )@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);	
				}					
				else{
					cont_mininet++;
					sh = "    c"+ob.nid+" = net.addController( 'c"+ob.nid+"', ip='"+controllerIPAddress+"', port="+controllerPort+" )@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}
			}
		} 
	}
	cont_mininet++;
	sh = "@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "    print \"*** Configuring wifi nodes\"@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "    net.configureWifiNodes()@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	
	//----------------------------------------------------------------------
	for(p=0;p<dropCanvas.numChildren;p++){
		
		UIob = dropCanvas.getChildAt(p);
		if(UIob.className =='objects'){
			ob=UIob as objects;					
			if(ob.id=="Computer"){	
				cont_mininet++;
				sh = "    h"+ob.nid+".plot(position='"+ob.x+","+(1000-ob.y)+",0')@@";
				objeto_mininet=sh;
				temp_mininet.addItem(objeto_mininet);
			}
		}
	}
	for(j=0;j<dropCanvas.numChildren;j++){	
		if(j==0){
			cont_mininet++;
			sh = "@@";
			objeto_mininet=sh;
			temp_mininet.addItem(objeto_mininet);
			cont_mininet++;
			sh = "    print \"*** Creating links\"@@";
			objeto_mininet=sh;
			temp_mininet.addItem(objeto_mininet);
		}
		
		UIob = dropCanvas.getChildAt((dropCanvas.numChildren-1)-j);
		if(UIob.className=='Link'){
			obLink=UIob as Link;
			if(obLink.can.lineName=="wireless"||obLink.can.lineName=="fiber"||obLink.can.lineName=="ethernet"){		
				if((obLink.can.source.id=="Switch"||obLink.can.source.id=="Access Point")&&(obLink.can.destination.id=="Switch"||obLink.can.destination.id=="Access Point")){
					if (obLink.can.source.id=="Access Point" && obLink.can.destination.id=="Access Point"){
						cont_mininet++;
						sh = "    net.addLink(ap"+obLink.can.source.nid+", ap"+obLink.can.destination.nid+",";
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}
					else if (obLink.can.source.id=="Access Point" && obLink.can.destination.id=="Switch"){
						cont_mininet++;
						sh = "    net.addLink(ap"+obLink.can.source.nid+", s"+obLink.can.destination.nid+",";
						
						if(obLink.can.bw!=null&&obLink.can.bw!="default")
							sh=sh.concat(" bw="+obLink.can.bw+",");	
						if(obLink.can.delay!=""&&obLink.can.delay!=null)
							sh=sh.concat(" delay='"+obLink.can.delay+"ms',");	
						if(obLink.can.maxqueuesize!=""&&obLink.can.maxqueuesize!=null)
							sh=sh.concat(" max_queue_size="+obLink.can.maxqueuesize+",");
						if(obLink.can.loss!=""&&obLink.can.loss!=null)
							sh=sh.concat(" loss="+obLink.can.loss+",");
						if(obLink.can.htb=="True")
							sh=sh.concat(" use_htb="+obLink.can.htb+",");
						
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);						
					}
					else if (obLink.can.source.id=="Switch" && obLink.can.destination.id=="Access Point"){
						cont_mininet++;
						sh = "    net.addLink(s"+obLink.can.source.nid+", ap"+obLink.can.destination.nid+",";
						
						if(obLink.can.bw!=null&&obLink.can.bw!="default")
							sh=sh.concat(" bw="+obLink.can.bw+",");	
						if(obLink.can.delay!=""&&obLink.can.delay!=null)
							sh=sh.concat(" delay='"+obLink.can.delay+"ms',");	
						if(obLink.can.maxqueuesize!=""&&obLink.can.maxqueuesize!=null)
							sh=sh.concat(" max_queue_size="+obLink.can.maxqueuesize+",");
						if(obLink.can.loss!=""&&obLink.can.loss!=null)
							sh=sh.concat(" loss="+obLink.can.loss+",");
						if(obLink.can.htb=="True")
							sh=sh.concat(" use_htb="+obLink.can.htb+",");
						
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}
					else if (obLink.can.source.id=="Switch" && obLink.can.destination.id=="Switch"){
						cont_mininet++;
						sh = "    net.addLink(s"+obLink.can.source.nid+", s"+obLink.can.destination.nid+",";
						
						if(obLink.can.bw!=null&&obLink.can.bw!="default")
							sh=sh.concat(" bw="+obLink.can.bw+",");	
						if(obLink.can.delay!=""&&obLink.can.delay!=null)
							sh=sh.concat(" delay='"+obLink.can.delay+"ms',");	
						if(obLink.can.maxqueuesize!=""&&obLink.can.maxqueuesize!=null)
							sh=sh.concat(" max_queue_size="+obLink.can.maxqueuesize+",");
						if(obLink.can.loss!=""&&obLink.can.loss!=null)
							sh=sh.concat(" loss="+obLink.can.loss+",");
						if(obLink.can.htb=="True")
							sh=sh.concat(" use_htb="+obLink.can.htb+",");
						
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}				
				}
				else if((obLink.can.source.id=="Computer" || obLink.can.source.id=="Station")&&(obLink.can.destination.id=="Switch"||obLink.can.destination.id=="Access Point")){
					if(obLink.can.source.id=="Computer"){
						if(obLink.can.destination.id=="Switch"){
							cont_mininet++;
							sh = "    net.addLink(h"+obLink.can.source.nid+", s"+obLink.can.destination.nid+",";
						}
						else if(obLink.can.destination.id=="Access Point"){
							cont_mininet++;
							sh = "    net.addLink(h"+obLink.can.source.nid+", ap"+obLink.can.destination.nid+",";
						}
						
						
						if(obLink.can.bw!=null&&obLink.can.bw!="default")
							sh=sh.concat(" bw="+obLink.can.bw+",");	
						if(obLink.can.delay!=""&&obLink.can.delay!=null)
							sh=sh.concat(" delay='"+obLink.can.delay+"ms',");	
						if(obLink.can.maxqueuesize!=""&&obLink.can.maxqueuesize!=null)
							sh=sh.concat(" max_queue_size="+obLink.can.maxqueuesize+",");
						if(obLink.can.loss!=""&&obLink.can.loss!=null)
							sh=sh.concat(" loss="+obLink.can.loss+",");
						if(obLink.can.htb=="True")
							sh=sh.concat(" use_htb="+obLink.can.htb+",");
						
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}
					else if(obLink.can.source.id=="Station" ) {
						if(obLink.can.destination.id=="Access Point"){
							cont_mininet++;
							if(obLink.can.lineName=="ethernet"){
								sh = "    net.addLink(sta"+obLink.can.source.nid+", ap"+obLink.can.destination.nid+",";
							}
							else{
								sh = "    net.addLink(sta"+obLink.can.source.nid+", ap"+obLink.can.destination.nid+",";
							}
							sh=sh.substring(0, sh.length-1);
							sh=sh.concat(")@@");
							
							objeto_mininet=sh;
							temp_mininet.addItem(objeto_mininet);
						}
						else if(obLink.can.destination.id=="Switch"){
							cont_mininet++;
							sh = "    net.addLink(sta"+obLink.can.source.nid+", s"+obLink.can.destination.nid+",";
							sh=sh.substring(0, sh.length-1);
							sh=sh.concat(")@@");
							
							objeto_mininet=sh;
							temp_mininet.addItem(objeto_mininet);						
						}
					}
				}
				else if((obLink.can.source.id=="Switch"|| obLink.can.source.id=="Access Point")&&(obLink.can.destination.id=="Computer"||obLink.can.destination.id=="Station")){
					if (obLink.can.destination.id=="Computer"){						
						if(obLink.can.source.id=="Switch"){
							cont_mininet++;
							sh = "    net.addLink(s"+obLink.can.source.nid+", h"+obLink.can.destination.nid+",";
						}
						else if(obLink.can.source.id=="Access Point"){
							cont_mininet++;
							sh = "    net.addLink(ap"+obLink.can.source.nid+", h"+obLink.can.destination.nid+",";
						}
						
						if(obLink.can.bw!=null&&obLink.can.bw!="default")
							sh=sh.concat(" bw="+obLink.can.bw+",");	
						if(obLink.can.delay!=""&&obLink.can.delay!=null)
							sh=sh.concat(" delay='"+obLink.can.delay+"ms',");	
						if(obLink.can.maxqueuesize!=""&&obLink.can.maxqueuesize!=null)
							sh=sh.concat(" max_queue_size="+obLink.can.maxqueuesize+",");
						if(obLink.can.loss!=""&&obLink.can.loss!=null)
							sh=sh.concat(" loss="+obLink.can.loss+",");
						if(obLink.can.htb=="True")
							sh=sh.concat(" use_htb="+obLink.can.htb+",");
						
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}
					else if (obLink.can.destination.id=="Station"){
						if(obLink.can.source.id=="Switch"){
							cont_mininet++;
							sh = "    net.addLink(s"+obLink.can.source.nid+", sta"+obLink.can.destination.nid+",";
							sh=sh.substring(0, sh.length-1);
							sh=sh.concat(")@@");
							
							objeto_mininet=sh;
							temp_mininet.addItem(objeto_mininet);
						}
						else if(obLink.can.source.id=="Access Point"){
							cont_mininet++;
							if(obLink.can.lineName=="ethernet"){
								sh = "    net.addLink(ap"+obLink.can.source.nid+", sta"+obLink.can.destination.nid+",";
							}
							else{
								sh = "    net.addLink(ap"+obLink.can.source.nid+", sta"+obLink.can.destination.nid+",";
							}
							sh=sh.substring(0, sh.length-1);
							sh=sh.concat(")@@");
							
							objeto_mininet=sh;
							temp_mininet.addItem(objeto_mininet);
						}
					}
				}
				else if((obLink.can.source.id=="Computer"&&(obLink.can.destination.id=="Computer"))){
					cont_mininet++;
					sh = "    net.addLink(h"+obLink.can.source.nid+", h"+obLink.can.destination.nid+",";
					if(obLink.can.bw!=null&&obLink.can.bw!="default")
						sh=sh.concat(" bw="+obLink.can.bw+",");	
					if(obLink.can.delay!=""&&obLink.can.delay!=null)
						sh=sh.concat(" delay='"+obLink.can.delay+"ms',");	
					if(obLink.can.maxqueuesize!=""&&obLink.can.maxqueuesize!=null)
						sh=sh.concat(" max_queue_size="+obLink.can.maxqueuesize+",");
					if(obLink.can.loss!=""&&obLink.can.loss!=null)
						sh=sh.concat(" loss="+obLink.can.loss+",");
					if(obLink.can.htb=="True")
						sh=sh.concat(" use_htb="+obLink.can.htb+",");
					
					sh=sh.substring(0, sh.length-1);
					sh=sh.concat(")@@");
					
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);				
				}
				else if(obLink.can.lineName=="wireless" && obLink.can.source.id=="Station" && obLink.can.destination.id=="Station"){
					if(stations.indexOf("sta"+obLink.can.source.nid)==-1){
						cont_mininet++;
						sh = "    net.addMesh(sta"+obLink.can.source.nid+", ssid='meshNet', mode='g') #node, ssid, mode";
						sh=sh.concat("@@");
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);	
						stations.push("sta"+obLink.can.source.nid)
					}
					if(stations.indexOf("sta"+obLink.can.destination.nid)==-1){	
						cont_mininet++;
						sh = "    net.addMesh(sta"+obLink.can.destination.nid+", ssid='meshNet', mode='g') #node, ssid, mode";
						sh=sh.concat("@@");
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
						stations.push("sta"+obLink.can.destination.nid)
					}
				}
				else if((obLink.can.lineName=="fiber" || obLink.can.lineName=="ethernet") && obLink.can.source.id=="Station" && obLink.can.destination.id=="Station"){
					cont_mininet++;
					sh = "    net.addLink(sta"+obLink.can.destination.nid+", sta"+obLink.can.source.nid+",";
					sh=sh.substring(0, sh.length-1);
					sh=sh.concat(")@@");						
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}
				else if((obLink.can.source.id=="Station" && obLink.can.destination.id=="Computer") || (obLink.can.source.id=="Computer" && obLink.can.destination.id=="Station")){
					if(obLink.can.source.id=="Computer"){
						cont_mininet++;
						sh = "    net.addLink(h"+obLink.can.source.nid+", sta"+obLink.can.destination.nid+",";
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}
					if(obLink.can.source.name.slice(0,7)=="Station"){	
						cont_mininet++;
						sh = "    net.addLink(sta"+obLink.can.source.nid+", h"+obLink.can.destination.nid+",";
						sh=sh.substring(0, sh.length-1);	
						sh=sh.concat(")@@");						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}
				}
			}
		}
	}
	//----------------------------------------------------------------------
	var x = 0;
	var y = 0;
	var xmin = 0;
	var ymin = 0;
	for(p=0;p<dropCanvas.numChildren;p++){
		if(ob.x>x){
			x = ob.x;
		}
		if(ob.y>y){
			y = ob.y;
		}
		if(ob.x<xmin){
			xmin = ob.x;
		}
		if(ob.y<ymin){
			ymin = ob.y; 
		}}
	if(isWireless){
		cont_mininet++;
		sh = "@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		cont_mininet++;
		
		sh = "    print \"*** Plotting Graph\"@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		cont_mininet++;
		sh = "    net.plotGraph(min_x = "+(xmin-1000)+",min_y = "+(ymin-1000)+", max_x="+(x+1000)+", max_y="+(y+1000)+")@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		
		for(p=0;p<dropCanvas.numChildren;p++){	
			if(p==0){
				cont_mininet++;
				sh = "@@";
				objeto_mininet=sh;
				temp_mininet.addItem(objeto_mininet);
				cont_mininet++;
				sh = "    print \"*** Starting network\"@@";
				objeto_mininet=sh;
				temp_mininet.addItem(objeto_mininet);
				cont_mininet++;
				sh = "    net.build()@@";
				objeto_mininet=sh;
				temp_mininet.addItem(objeto_mininet);
			}
			UIob = dropCanvas.getChildAt(p);
			if(UIob.className =='objects'){
				ob=UIob as objects;					
				if(ob.id=="Controller"){	
					cont_mininet++;
					sh = "    c"+ob.nid+".start()@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}
			}
		}
		for(p=0;p<dropCanvas.numChildren;p++){
			UIob = dropCanvas.getChildAt(p);
			if(UIob.className=='Link'){
				obLink=UIob as Link;	
				if(exists==false && storeConnectivity.indexOf(obLink.can.source.nid)==-1 && (obLink.can.source.id=="Switch"||obLink.can.source.id=="Access Point")&&obLink.can.destination.id=="Controller"){
					if (obLink.can.source.id=="Access Point"){
						storeConnectivity.push(obLink.can.source.nid);	
						cont_mininet++;
						sh = "    ap"+obLink.can.source.nid+".start( [c"+obLink.can.destination.nid;
						countControllerDestination=obLink.can.destination.nid.toString();	
						countSwitchSource=obLink.can.source.nid.toString();
						exists=true;	
					}
					else{
						storeConnectivity.push(obLink.can.source.nid);	
						cont_mininet++;
						sh = "    s"+obLink.can.source.nid+".start( [c"+obLink.can.destination.nid;
						countControllerDestination=obLink.can.destination.nid.toString();	
						countSwitchSource=obLink.can.source.nid.toString();
						exists=true;
					}
					sh = sh+"] )@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}
				else if(exists==false && storeConnectivity.indexOf(obLink.can.destination.nid)==-1 && (obLink.can.destination.id=="Switch"||obLink.can.destination.id=="Access Point")&&obLink.can.source.id=="Controller"){
					if(obLink.can.destination.id=="Access Point"){
						storeConnectivity.push(obLink.can.destination.nid);	
						cont_mininet++;
						sh = "    ap"+obLink.can.destination.nid+".start( [c"+obLink.can.source.nid;
						countControllerSource=obLink.can.source.nid.toString();	
						countSwitchDestination=obLink.can.destination.nid.toString();	
						exists=true;
					}
					else{
						storeConnectivity.push(obLink.can.destination.nid);	
						cont_mininet++;
						sh = "    s"+obLink.can.destination.nid+".start( [c"+obLink.can.source.nid;
						countControllerSource=obLink.can.source.nid.toString();	
						countSwitchDestination=obLink.can.destination.nid.toString();	
						exists=true;
					}
					sh = sh+"] )@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}
			} 
			countSwitchDestination="";
			countSwitchSource="";
			countControllerDestination="";
			countControllerSource="";
			exists=false;
		}	
		//----------------------------------------------------------------------
		cont_mininet++;
		sh = "@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		
		var x:int = 0;
		var y:int = 0;
		for(p=0;p<dropCanvas.numChildren;p++){	
			UIob = dropCanvas.getChildAt(p);		
			if(UIob.className =='objects'){
				ob=UIob as objects;					
				if(ob.id=="Station" || ob.id=="Access Point"){	
					if (ob.x > x){
						x = ob.x;
					}
					if (1000-ob.y > y){
						y = 1000-ob.y;
					}
				}			
			}
		}
		
		if (x > y){
			y = x;
		}
		else{
			x = y;		
		}
		
		
		cont_mininet++;
		sh = "@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		cont_mininet++;
		sh = "    print \"*** Running CLI\"@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		cont_mininet++;
		sh = "    CLI_wifi( net )@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		cont_mininet++;
		sh = "@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		cont_mininet++;
		sh = "    print \"*** Stopping network\"@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		cont_mininet++;
		sh = "    net.stop()@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		cont_mininet++;
		sh = "@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		cont_mininet++;
		sh = "if __name__ == '__main__':@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		cont_mininet++;
		sh = "    setLogLevel( 'info' )@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		cont_mininet++;
		sh = "    topology()@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		cont_mininet++;
		sh = "";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
		
		if(expo==true){
			//alertpy2();
			var rand:Number = Math.random();
			var numeroRan:Number = Math.round(rand * 99999);
			chave = "mininetCode"+String(numeroRan);
			objSend.chave=chave;
			objSend.count2=cont_mininet;
			objSend.gtemp_mininet=temp_mininet;		
			createscript_mininet.send(objSend);
			fileRefScript_mininet = new FileReference();	
			fileRefScript_mininet.addEventListener(Event.COMPLETE, SaveToLocalMachineResultScript);
			fileRefScript_mininet.addEventListener(ProgressEvent.PROGRESS, downloading_progress);				
			downloadScript();
		}		
	}}