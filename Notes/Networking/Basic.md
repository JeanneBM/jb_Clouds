# Important Areas in Networking

## 1. Networking Basics

### OSI & TCP/IP Models
- **OSI (Open Systems Interconnection)**: A conceptual framework with 7 layers:
  - Physical, Data Link, Network, Transport, Session, Presentation, and Application.
- **TCP/IP**: A 4-layer model:
  - Link, Internet, Transport, and Application.
- **Encapsulation**: Data is wrapped in headers at each layer to provide necessary information for correct processing.

### IP Addressing
- **IPv4**: 32-bit addressing format (e.g., 192.168.1.1), expressed as 4 octets.
- **IPv6**: 128-bit addressing format (e.g., 2001:0db8:85a3:0000:0000:8a2e:0370:7334).
- **Subnetting**: Division of IP address space into smaller segments for efficient use of IPs, including CIDR notation and subnet masks.
- **CIDR Notation**: Method for defining IP addresses with subnet masks (e.g., 192.168.1.0/24).

### MAC Addressing
- **MAC (Media Access Control)**: Unique identifiers assigned to network interfaces at Layer 2.
- **ARP (Address Resolution Protocol)**: Resolves IP addresses to MAC addresses for local network communication.

## 2. Network Protocols

### TCP vs. UDP
- **TCP (Transmission Control Protocol)**: Connection-oriented protocol ensuring reliable data delivery.
- **UDP (User Datagram Protocol)**: Connectionless protocol for faster, less reliable communication.

### DNS (Domain Name System)
- Translates human-readable domain names (e.g., www.example.com) into IP addresses for website connection.
- Involves recursive queries, authoritative servers, and caching mechanisms.

### DHCP (Dynamic Host Configuration Protocol)
- Automatically assigns IP addresses and other network configuration parameters to devices.
- Reduces the need for manual IP configuration.

### HTTP(S)
- **HTTP**: Hypertext Transfer Protocol, the foundation for web data exchange.
- **HTTPS**: Secure version of HTTP using SSL/TLS encryption.

### ICMP (Internet Control Message Protocol)
- Used for diagnostic functions like **ping** (checking connectivity) and **traceroute** (mapping network paths).
- Handles error reporting for unreachable destinations.

## 3. Subnetting & Routing

### Subnetting
- Divides larger networks into smaller sub-networks (subnets) for improved performance and security.
- **VLSM (Variable Length Subnet Mask)** allows different subnet sizes within the same network.

### Routing Protocols
- **Static Routing**: Manually configured routes in a router, suitable for small networks.
- **Dynamic Routing**: Uses algorithms to adjust routes based on network changes, including:
  - **OSPF (Open Shortest Path First)**: Link-state protocol for large networks.
  - **BGP (Border Gateway Protocol)**: Exterior gateway protocol for routing between different networks.
  - **EIGRP (Enhanced Interior Gateway Routing Protocol)**: Cisco proprietary protocol, more efficient than RIP.
  - **RIP (Routing Information Protocol)**: Older, distance-vector routing protocol.

### NAT & PAT
- **NAT (Network Address Translation)**: Allows multiple devices to share a single public IP address.
- **PAT (Port Address Translation)**: A form of NAT that uses port numbers to differentiate between devices using a single public IP.

## 4. Network Security

### Firewalls
- **Packet Filtering**: Inspects packet headers and applies security rules.
- **Stateful Inspection**: Tracks the state of connections and makes decisions based on traffic context.

### VPNs (Virtual Private Networks)
- Provides secure, encrypted communication over the internet.
- **IPSec**: Suite of protocols for encrypting and authenticating IP packets.
- **SSL/TLS**: Encryption protocols used for securing web traffic (HTTPS).

### Zero Trust Security
- Assumes no trust, even from inside the network, and requires authentication and authorization for all users and devices.
- **Microsegmentation**: Divides the network into smaller segments to limit the impact of security breaches.

### DDoS Protection
- **DDoS (Distributed Denial of Service)**: Attacks that overwhelm a target with traffic.
- Protection strategies include rate limiting, traffic filtering, and cloud-based DDoS mitigation.

## 5. Network Devices

### Switches & Hubs
- **Switches**: Operate at Layer 2 (Data Link), forwarding data frames based on MAC addresses. They create separate collision domains.
- **Hubs**: Basic devices that broadcast all incoming traffic to all connected devices, less efficient than switches.

### Routers
- Operate at Layer 3 (Network Layer) and forward packets between different networks based on IP addresses.
- Make routing decisions using routing tables and protocols.

### Load Balancers
- Distribute traffic across multiple servers to ensure high availability and optimal performance.
- Can be hardware or software-based.

### Access Points
- Provide wireless network connectivity for devices like laptops and phones.

## 6. Cloud & Virtual Networking

### SDN (Software-Defined Networking)
- A network architecture that separates the control plane from the data plane for centralized network management and programmability.

### Cloud Networking
- **AWS VPC (Virtual Private Cloud)**: A logically isolated section of the AWS cloud where virtual networks can be defined and controlled.
- **Azure VNets (Virtual Networks)**: The Microsoft Azure equivalent of VPC.
- **Hybrid Cloud**: Combines on-premises infrastructure with cloud services for cohesive networking.

### Container Networking
- **CNI (Container Network Interface)**: A specification for configuring networking in containerized environments like Kubernetes.
- **Service Mesh**: Manages microservices communication, providing features like load balancing, security, and traffic routing (e.g., Istio, Linkerd).

## 7. Wireless & Mobile Networking

### Wi-Fi Standards
- **802.11a/b/g/n/ac/ax**: Different Wi-Fi standards offering various speeds and ranges. Wi-Fi 6 (802.11ax) is the latest standard, providing higher capacity and better performance in crowded areas.
- **WPA2/WPA3**: Security protocols to protect wireless networks, with WPA3 being the latest and most secure.

### Cellular Networks
- **4G/LTE**: Fourth-generation mobile networks offering high-speed internet.
- **5G**: Fifth-generation mobile networks providing even faster speeds and lower latency.
- **Roaming**: Allows mobile devices to connect to foreign networks when out of their home network area.

## 8. Monitoring & Troubleshooting

### Network Performance Tools
- **Ping**: Checks connectivity between devices.
- **Traceroute**: Identifies the path data takes through the network.
- **Wireshark**: A packet analyzer used for network troubleshooting and protocol analysis.
- **NetFlow**: A protocol for collecting and monitoring network traffic data.

### Log Analysis
- **Syslog**: A standard for transmitting log data from network devices and systems to a central log server.
- **SNMP**: Simple Network Management Protocol, used for gathering and managing data from network devices.
- **SIEM (Security Information and Event Management)**: Platforms used to analyze logs and detect security incidents.

### Latency & Jitter
- **Latency**: The delay in data transmission, typically measured in milliseconds.
- **Jitter**: The variation in latency over time, which can affect real-time applications like video and voice.

