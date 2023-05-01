from scapy.all import ARP, Ether, srp

# create an ARP request packet to get MAC and IP address of devices on the local network
arp = ARP(pdst="192.168.1.0/24")
ether = Ether(dst="ff:ff:ff:ff:ff:ff")
packet = ether/arp

# send the packet and capture the response
result = srp(packet, timeout=3, verbose=0)[0]

# create a list of active devices
devices = []
for sent, received in result:
    devices.append({'ip': received.psrc, 'mac': received.hwsrc})

# print out the list of active devices
print("Active devices on the network:")
print("-----------------------------")
for device in devices:
    print(f"IP: {device['ip']}   MAC: {device['mac']}")