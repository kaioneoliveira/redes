#!/usr/bin/python

'This example creates a simple network topology with 1 AP and 2 stations'

import sys
from mininet.wifi.link import wmediumd, _4address
from mininet.node import Controller
from mininet.log import setLogLevel, info
from mininet.wifi.node import OVSKernelAP
from mininet.wifi.cli import CLI_wifi
from mininet.wifi.net import Mininet_wifi
from mininet.wifi.wmediumdConnector import interference

def topology():
    "Create a network."
    net = Mininet_wifi(controller=Controller, accessPoint=OVSKernelAP,link=wmediumd, wmediumd_mode=interference,
                        configure4addr=True, autoAssociation=False )

    info("*** Creating nodes\n")
    sta1 = net.addStation('sta1', mac='00:00:00:00:00:02', ip='10.0.0.1/8', position='30,60,0')
    sta2 = net.addStation('sta2', mac='00:00:00:00:00:03', ip='10.0.0.2/8', position='40,40,0')
    sta3 = net.addStation('sta3', mac='00:00:00:00:00:04', ip='10.0.0.3/8', position='50,50,0')
    sta4 = net.addStation('sta4', mac='00:00:00:00:00:05', ip='10.0.0.4/8', position='70,70,0')
  
    ap1 = net.addAccessPoint('ap1', ssid="ponto1", mode="g", channel="5", position='75,50,0', _4addr="ap")
    ap2 = net.addAccessPoint('ap2', ssid="ponto2", mode="g", channel="5", position='60,60,0', _4addr="client")
 
    c0 = net.addController('c0', controller=Controller, ip='127.0.0.1',
                           port=6633)
    h1 = net.addHost('h1', ip='10.0.0.5/8', position='30,30,0')
    h2 = net.addHost('h2', ip='10.0.0.6/8', position='25,25,0')
    net.propagationModel(model="logDistance", exp=4.5)
    info("*** Configuring wifi nodes\n")
    net.configureWifiNodes()

    info("*** Associating Stations\n")
    net.addLink(ap1, ap2, cls=_4address)
    net.addLink(sta1, ap1)
    net.addLink(sta2, ap1)
    net.addLink(sta3, ap2)
    net.addLink(sta4, ap2)
    net.addLink(h1, ap1)
    net.addLink(h2, ap2)

    net.plotGraph(max_x=100, max_y=100)

    info("*** Starting network\n")
    net.build()
    c0.start()
    ap1.start([c0])
    ap2.start([c0])

    info("*** Running CLI\n")
    CLI_wifi(net)

    info("*** Stopping network\n")
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    topology()
