# Nginx-to-Docker

## Description

Nginx-to-Docker is a Docker image acting as a reverse proxy, enabling routing of incoming HTTP traffic to specific Docker containers based on domain names.

## Features

- Facilitates easy redirection of HTTP traffic to different containers based on domain names.
- Configuration through environment variables for efficient routing.

## Usage

### Prerequisites

- Docker installed on your machine ([Docker Installation Guide](https://docs.docker.com/get-docker/))

### Pull the Docker Image

```
docker pull igormuba/nginx-to-docker:latest
```

### Run the Nginx-to-Docker Container

```
docker run -d \
    --name nginx-to-docker \
    -e TEST1=test1.com_nginx-to-docker-container-1:3000 \
    -e TEST2=test2.com_nginx-to-docker-ontainer-1:3000 \
    -p 80:80 \
    igormuba/nginx-to-docker:latest
```

In the example above connections received on the nginx docker container from the domain test1.com will be redirected to the container nginx-to-docker-container-1:3000 and test2.com to nginx-to-docker-ontainer-1:3000

### Docker Compose Usage

Utilize Docker Compose to manage your Nginx-to-Docker setup. Below is an example of a docker-compose.yml file:

```
version: "3"
services:
  container-1:
    image: user/image:latest
    container_name: nginx-to-docker-container-1
    ports:
      - "3000:3000"
    networks:
      - my_network
  container-2:
    image: user/image:latest
    container_name: nginx-to-docker-container-2
    ports:
      - "3000:3000"
    networks:
      - my_network
  nginx-to-docker:
    image: igormuba/nginx-to-docker:latest
    environment:
      - TEST1=test1.com_nginx-to-docker-container-1:3000
      - TEST2=test2.com_nginx-to-docker-container-2:3000
    ports:
      - "80:80"
networks:
  my_network:
    driver: bridge

```

Replace the image names, environment variables, and ports according to your specific configuration needs.

In the example above we are on the same docker-compose file setting the service containers and also setting the nginx-to-container to use nginx to redirect traffic from the domains to their respectinve dockers.

### Understanding Environment Variables

- Environment variables are used in pairs, with each pair representing a domain and its corresponding Docker container. These variables follow the pattern: `TESTX=DOMAIN_CONTAINER:PORT``, where:
- - TESTX refers to the placeholder for the domain and container pair, where X represents a unique identifier (e.g., TEST1, TEST2).
- - DOMAIN signifies the domain name that will be mapped to the specified container.
- - CONTAINER points to the Docker container and its port to which the traffic for the given domain will be directed.
- - Ensure each pair is separated by an underscore \_.

### Custom Configuration

To customize routing for your domains, update the environment variables with the required domain names and corresponding Docker containers following the specified format.
