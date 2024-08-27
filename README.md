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

Conclusion

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






## Grade: 125/100