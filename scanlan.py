import socket
import ipaddress
import subprocess

# get the IP address of the local machine
hostname = socket.gethostname()
local_ip = socket.gethostbyname(hostname)

# get the network address from the local IP address
network = ipaddress.ip_network(f'{local_ip}/24', strict=False)

# function to ping an IP address and check if it's active
def ping(host):
    result = subprocess.run(['ping', '-c', '1', '-W', '1', str(host)], capture_output=True)
    return result.returncode == 0

# create a list of active devices on the network
devices = [str(ip) for ip in network.hosts() if ping(ip)]

# print out the list of active devices
print("Active devices on the network:")
print("-----------------------------")
for device in devices:
    print(device)