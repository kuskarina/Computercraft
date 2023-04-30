import socket
import struct

def get_local_ip():
    # get the local IP address and subnet mask using a UDP socket
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
        s.connect(("8.8.8.8", 80))  # connect to a public IP address
        return s.getsockname()[0]  # return the local IP address

def ping(host):
    # create a socket object for sending and receiving ICMP echo requests
    with socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_ICMP) as s:
        # set the timeout for receiving a response (in seconds)
        s.settimeout(1)

        # create the ICMP echo request packet
        packet = struct.pack("!BBHHH", 8, 0, 0, 0, 0)

        # send the ICMP echo request to the host
        s.sendto(packet, (host, 0))

        try:
            # wait for a response and return True if the host is up
            s.recvfrom(1024)
            return True
        except socket.timeout:
            # the host is not responding, so return False
            return False

# get the local IP address and subnet mask
local_ip = get_local_ip()
subnet_mask = local_ip.rsplit(".", 1)[0] + ".0/24"

# ping each device on the local Wi-Fi network
for addr in range(1, 255):
    host = subnet_mask.rsplit(".", 1)[0] + "." + str(addr)
    
    if host != local_ip and ping(host):
        print(f"Found device: {host}")