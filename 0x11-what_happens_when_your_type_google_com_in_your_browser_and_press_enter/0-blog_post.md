# What Happens When You Type "https://www.google.com" in Your Browser and Press Enter

## DNS Request
- Browser checks cache for IP address of "www.google.com".
- If not found, sends a DNS request to translate the domain name into an IP address.

## TCP/IP
- Browser initiates a TCP connection to the server using the IP address.
- TCP/IP protocols ensure reliable data transmission.

## Firewall
- Data packets pass through a firewall, which acts as a security gate.

## HTTPS/SSL
- Browser and server establish a secure connection using HTTPS.
- SSL/TLS encryption protects data exchanged between browser and server.

## Load-Balancer
- Google’s load balancer distributes requests across multiple servers.

## Web Server
- Load balancer routes request to a web server.
- Web server processes request and serves static content.

## Application Server
- For dynamic content, request is forwarded to an application server.
- Application server runs server-side code to generate content dynamically.

## Database
- If needed, application server queries a database to retrieve or store data.
