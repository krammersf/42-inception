# Inception

## 🌟 Overview

This project aims to provide a robust and scalable environment using Docker Compose. 
Each service is encapsulated within its own container, ensuring modularity and ease of management. 
The setup includes:

- **NGINX**: Configured with TLSv1.2 or TLSv1.3 for secure connections.
- **WordPress**: Running with PHP-FPM, excluding NGINX.
- **MariaDB**: As the database service for WordPress.
- **Volumes**: Persistent storage for WordPress files and database.
- **Custom Network**: For seamless inter-container communication.

## ⚙️ Prerequisites

- Docker
- Docker Compose
- Make

## ⚙️ Execution

- To run, open a terminal and navigate to the folder where the Makefile is located, then do the following: 
```shell
make
```

## ⚙️ BONUS

- adminer
- ftp
- prometheus
- redis
- static website

## ⚙️ Execution BONUS

- Go to the docker-compose.yml file and uncomment the bonus part.
- To run, open a terminal and navigate to the folder where the Makefile is located, then do the following:
```shell
make
```

## Grade: 125/100
