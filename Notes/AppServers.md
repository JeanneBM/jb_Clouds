# Application Servers and Web Servers

## 1. JBoss/WildFly

### WildFly
- An open-source Java EE/Jakarta EE application server developed by Red Hat.

### JBoss EAP
- A commercial version of WildFly with extended support and stability.

### Features
- Supports **EJB, JPA, JSF, CDI, JMS, JTA** transactions, microservices (**Thorntail, Quarkus**).
- **CLI & Web Console** – server management.
- **Operating modes**: Standalone (single server) and Domain (clustered environment).

## 2. Tomcat
- A **lightweight servlet and JSP container** (not a full application server).
- Supports **Java Servlet API and JavaServer Pages (JSP)**.
- Configuration via **server.xml** and **web.xml**.
- Popular for **Spring and Struts-based applications**.
- Does not support **EJB or JTA** (can be extended with **TomEE**).

## 3. Apache HTTP Server
- A **widely used, open-source, cross-platform web server**.
- Handles **static and dynamic content** (modules like **mod_php, mod_python**).
- **Reverse proxy** (**mod_proxy**), **SSL** (**mod_ssl**).
- Configuration in **httpd.conf** or **.htaccess**.
- Can work with **Tomcat via mod_jk or mod_proxy_ajp**.

## 4. IIS (Internet Information Services)
- A web server from **Microsoft**, integrated with **Windows Server**.
- Supports **ASP.NET, PHP, CGI, FastCGI**.
- **GUI-based management**, configurable via **PowerShell**.
- Supports **Windows authentication, load balancing, HTTP compression**.
- Extendable with modules (e.g., **ARR for reverse proxy**).

## 5. Reverse Proxy

### What is it?
A **reverse proxy** is an intermediary server that receives client requests and forwards them to an application server or another backend service.

### Why Use a Reverse Proxy?
✅ **Hides backend servers** – Users only see the proxy.  
✅ **Load Balancing** – Distributes traffic across multiple backend servers.  
✅ **SSL Termination** – Handles HTTPS traffic.  
✅ **Caching** – Improves application performance.  
✅ **Security** – Protects backend services from DDoS attacks.  

### Reverse Proxy Examples

#### Apache + mod_proxy
```apache
ProxyPass /app http://localhost:8080/
ProxyPassReverse /app http://localhost:8080/
```

#### Nginx as Reverse Proxy for Node.js
```nginx
server {
    listen 80;
    server_name example.com;
    location / {
        proxy_pass http://localhost:3000;
    }
}
```

## 6. How Do These Work Together?
Application servers and web servers work together to host applications:

- **Backend applications** run in **Docker** (Tomcat, Node.js, JBoss).
- **Reverse Proxy** (Apache, Nginx, IIS) receives traffic and forwards it to the backend.
- **Users see only the reverse proxy**, while the backend remains hidden.

## Summary

| Tool | Main Purpose |
|------|-------------|
| **JBoss/WildFly** | Full Java EE server (**EJB, JPA, JMS**) |
| **Tomcat** | Lightweight server for **Java Servlets and JSP** |
| **Apache HTTP Server** | Web server, reverse proxy |
| **IIS** | Web server for **Windows applications** |
| **Reverse Proxy** | **Load balancing, SSL, caching, backend protection** |

All these components form **middleware and web infrastructure**, facilitating application hosting. 
