# Laravel base Docker image
Small Docker image for Laravel with RoadRunner and some needed extensions

Example docker-compose.yml:

```yaml
version: '3.8'

services:
    laravel:
        build:
            context: .
            dockerfile: Dockerfile
            args:
                WWWGROUP: '${WWWGROUP}'
        extra_hosts:
            - 'host.docker.internal:host-gateway'
        environment:
            LARAVEL_SAIL: 1
            PHP_IDE_CONFIG: serverName=Docker
            NODE_PATH: /usr/local/lib/node_modules
        volumes:
            - .:/var/www/app
        networks:
            - project
        depends_on:
            - database
            - redis
        container_name: laravel_${APP_NAME}
        entrypoint:
            - php
            - -d
            - variables_order=EGPCS
            - artisan
            - octane:start
            - --server=roadrunner
            - --watch
            - --host=0.0.0.0
            - --port=8000
            - --workers=1
            - --task-workers=1
            - --max-requests=500
            - --rr-config=.rr.dev.yaml
        ports:
            - '${HOST_APP_PORT:-80}:8000'
```