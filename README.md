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

## ⚙️ Test BONUS

### REDIS

Configuring Redis as a cache for your WordPress site helps to improve the site's performance and speed by storing frequently accessed data in memory. This reduces the load on the database and speeds up the site's response time.
Benefits of Using Redis as a Cache

Performance Improvement: Redis is an extremely fast in-memory data store, which means it can provide data much faster than a traditional disk-based database.
Reduced Database Load: By storing frequently accessed data in Redis, you reduce the number of database queries, which can improve the scalability and stability of your site.
Faster Response Time: With data stored in memory, the response time for end users is significantly reduced.
Efficient Session Management: Redis can be used to store user sessions, which is more efficient than storing sessions in the database or file system.

#### Conclusion

Configuring Redis as a cache for your WordPress site can significantly improve site performance, reduce database load, and provide a faster and more efficient user experience.

#### How to Test?

```shell
docker logs redis

docker exec -it redis bash

redis-cli

PING
```
```shell
SET my_key "my_value"
# response: OK

GET my_key
# response: "my_value"

KEYS *
# response: 1 "my_key"
```

### FTP (File Transfer Protocol)

Setting up an FTP server container pointing to your WordPress site's volume helps facilitate the transfer of files between your local computer and the server where the WordPress site is hosted. This is useful for managing WordPress files, such as themes, plugins, media uploads, and other configuration files.
Benefits of Using an FTP Server

    Ease of File Transfer: It allows you to easily send and receive files between your local computer and the server.
    File Management: It makes it easy to edit, delete, and organize files on the server.
    Backup and Restore: It allows you to back up your site files and restore them when necessary.
    Remote Access: You can access your site files from anywhere, as long as you have an internet connection.

#### Conclusion

Setting up an FTP server container pointing to your WordPress site's volume facilitates the transfer and management of WordPress files. This is especially useful for developers and site administrators who need to access and modify site files efficiently and securely.

#### How to Test?

```shell
echo HELLO > aaa.txt
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ftp
ftp ftp <ftp value>
```

```shell
NAME: <see in .env>
PASS: <see in .env>
```

```shell
ls -la
cd files
put test.txt
get aaa.txt bbb.txt
exit
```

```shell
diff aaa.txt bbb.txt
cat test.txt
cat test2.txt
```

### STATIC WEBSITE

http://localhost:3000/


### ADMINER

Adminer is a web-based database management tool that allows users to interact with databases easily and intuitively. Here are some key points about Adminer:

    Web Interface: Adminer provides a simple and user-friendly web interface for managing databases.
    Support for Multiple Databases: It supports multiple database management systems, including MySQL, PostgreSQL, SQLite, MS SQL, Oracle, and others.
    Features: Allows you to execute SQL queries, manage tables, view and edit data, create and delete databases, and much more.
    Simple Installation: It is easy to install and configure, usually requiring just a single PHP file.
    Security: Offers various security options, including user authentication and support for secure connections.

#### How to Test?

http://localhost:8080/adminer.php

#### How to use the credentials:

System:    MySQL
Server:    [MDB_HOST]
Username:  [MDB_USER]
Password:  [MDB_PASSWORD]
Database:  [MDB_NAME]

### PROMETHEUS

Prometheus is an open-source monitoring and alerting tool initially developed by SoundCloud. It is widely used to monitor systems and services, collecting metrics in real time and allowing the creation of alerts based on these metrics. Here are some key points about Prometheus:

    Metric Collection: Prometheus collects metrics from services and systems, storing them in a time-series database.
    Data Querying: Uses a query language called PromQL to enable powerful and flexible queries on the collected data.
    Alerting: Integrates with Alertmanager to send alerts based on user-defined rules.
    Exporters: Uses exporters to collect metrics from different systems and services. There are exporters for a wide range of services, such as databases, operating systems, and much more.
    Visualization: Can be integrated with visualization tools like Grafana to create interactive dashboards and data visualizations.

#### How to Test?

http://localhost:9090

#### How to get the metrics?

```shell
curl http://localhost:9090/metrics
```

## Grade: 125/100