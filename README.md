# ezXSS-Docker-Nginx

This repository provides a Dockerized environment for running [ezXSS](https://github.com/ssl/ezXSS) 4.2 with Nginx, MariaDB, and PHP 8.2. The setup omits the certbot auto-generation and installation process. This setup is tested with `duckdns.org` but should work with other DNS providers as well.

## Features

- **Nginx**
- **MariaDB**
- **PHP 8.2**
- **Docker**: Containerization for easy deployment and consistency.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Getting Started
1. **Manual certbot generation for duckdns**
  
   First, you need to register a domain with [Duckdns](https://www.duckdns.org/), which is free. After registering your domain, you can generate a certificate using [certbot-dns-duckdns](https://pypi.org/project/certbot-dns-duckdns/).The installation process is straightforward and well-documented [here](https://pypi.org/project/certbot-dns-duckdns/#installation)
     ```bash
      certbot certonly \
        --non-interactive \
        --agree-tos \
        --email <your-email> \
        --preferred-challenges dns \
        --authenticator dns-duckdns \
        --dns-duckdns-token <your-duckdns-token> \
        --dns-duckdns-propagation-seconds 60 \
      -d "example.duckdns.org"
     ```
     Now make sure that the folder /etc/letsencrypt/ exists!.This directory will be mounted as a volume in your Docker container.
     
3. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/ezXSS-Docker-Nginx.git
   cd ezXSS-Docker-Nginx
   ```
4. **Create.env Files**
  These files will be used to store environment variables required by Docker Compose.
   ```bash
     touch .env ./Nginx/ezXSS/.env
   ```
  Add the following environment variables to your .env file, adjusting the values as needed:
   - .env
     ```bash
      DOMAIN=example.duckdns.org
      dbHost="ezxssdb"
      dbUser=ezxss
      dbPassword=changeme
      dbName=database
     ```
   - ./Nginx/ezXSS/.env
     ```bash
      dbHost="ezxssdb"
      dbUser=ezxss
      dbPassword="changeme"
      dbName=database
      dbPort=3306
      # ezXSS app settings
      debug=false
      httpmode=false
      signupEnabled=false
     ```
     **Note:** It's easier to use a single .env file and adjust the references in `Nginx/ezXSS/app/config/app.php` to not create two `.env`. I'll do it later :).

5. **Run docker-compose**
  ```bash
   docker-compose up --build -d  
  ```

