# Akeneo PIM v6 Docker Compose Environment
> The easy environment for Dummies
**Supported Systems**
* MacOs (Intel, Apple M1)
* Linux (AMD64, ARM64)
* Windows via WSL2 (AMD64)

## Pre-requirements
### Docker
**MacOs**  
Install Docker for Mac: https://docs.docker.com/desktop/mac/install/  

**Linux**  
Install Docker Engine: https://docs.docker.com/engine/install/ubuntu/  
Install Docker Compose https://docs.docker.com/compose/install/  

**Windows**  
Follow this guide: https://docs.docker.com/desktop/windows/wsl/  

### Homebrew (MacOs/Linux/Windows)
Install Homebrew by following guide https://docs.brew.sh/Installation

### Composer Credentials
You need to export `COMPOSE_PROJECT_COMPOSER_AUTH` variable s othat Composer can use credentials inside containers
```bash
export COMPOSE_PROJECT_COMPOSER_AUTH='{
    "http-basic": {
        "repo.example.com": {
            "username": "xxxxxxxxxxxx",
            "password": "yyyyyyyyyyyy"
        }
    },
    "github-oauth": {
        "github.com": "xxxxxxxxxxxx"
    }
}'
```
> Optionally you can add this row to your `~/.bashrc` or `~/.zshrc`


## Installation
Install the formula via homebrew
```bash
brew install digitalspacestdio/docker-compose-akeneo6/docker-compose-akeneo6
```

## Option.1 Creating new project from scratch

1. Create the new projet directory
```bash
mkdir ~/akeneo6
```

2. Navigate to the projet directory
```bash
cd ~/akeneo6
```

3. Create the new project
```bash
docker-compose-akeneo6 composer create-project akeneo/pim-community-standard /var/www "6.0.*@stable"
```

4. Deploy sample data
```bash
docker-compose-akeneo6 bin/console sampledata:deploy
```

5. Install the application
```bash
docker-compose-akeneo6 make dev
```

9. Start the stack in the background mode
```bash
docker-compose-akeneo6 up -d
```

> Application will be available by following link: http://localhost:30280/

## Option.2 Starting already exists project from git and local sql dump

1. Clone the project source code

```bash
git clone https://github.com/youcompanyname/akeneo6.git ~/akeneo6
```

2. navigate to the project dir
```bash
cd  ~/akeneo6
```

3. Install dependencies
```bash
docker-compose-akeneo6 composer install -o --no-interaction
```

7. Import database dump (supports `*.sql` and `*.sql.gz` files)
```bash
docker-compose-akeneo6 database-import /path/to/dump.sql.gz
```


11. Start the stack in the background mode
```bash
docker-compose-akeneo6 up -d
```

> Application will be available by following link: http://localhost:30280/

## Shutdown the project stack

Stop containers
```bash
docker-compose-akeneo6 down
```

Destroy containers and persistent data
```bash
docker-compose-akeneo6 down -v
```

## Extra tools

Connecting to the mysql container
```bash
docker-compose-akeneo6 mysql
```

Connecting to the cli container
```bash
docker-compose-akeneo6 bash
```

Generate compose config and run directly without this tool
```bash
docker-compose-akeneo6 config > docker-compose.yml
```
```bash
docker compose up
```

## Environment Variables
> Can be stored in the `.dockenv`, `.dockerenv` or `.env` file in the project root
* `COMPOSE_PROJECT_MODE` - (`mutagen`|`default`)
* `COMPOSE_PROJECT_COMPOSER_VERSION` - (`1|2` )
* `COMPOSE_PROJECT_PHP_VERSION` - (`7.4`|`8.0`|`8.1`|`8.2`), the image will be built from a corresponding `fpm-alpine` image, see https://hub.docker.com/_/php/?tab=tags&page=1&name=fpm-alpine&ordering=name for more versions
* `COMPOSE_PROJECT_NODE_VERSION` - (`12.22.12`|`14.19.3`|`16.16.0`) the image will be built from a corresponding `alpine` image, see https://hub.docker.com/_/node/tags?page=1&name=alpine3.16 for more versions
* `COMPOSE_PROJECT_MYSQL_IMAGE` - `mysql:8.0-oracle` see https://hub.docker.com/_/mysql/?tab=tags for more versions
* `COMPOSE_PROJECT_ELASTICSEARCH_VERSION` - `7.17.5` see https://www.docker.elastic.co/r/elasticsearch/elasticsearch-oss for more versions
* `COMPOSE_PROJECT_NAME` - by default the working directory name will be used
* `COMPOSE_PROJECT_PORT_PREFIX` - `302` by default
* `COMPOSE_PROJECT_PORT_HTTP` - `$COMPOSE_PROJECT_PORT_PREFIX` + `80` by default
* `COMPOSE_PROJECT_PORT_XHGUI` - `$COMPOSE_PROJECT_PORT_PREFIX` + `81` by default
* `COMPOSE_PROJECT_PORT_MYSQL` - `$COMPOSE_PROJECT_PORT_PREFIX` + `06` by default
* `COMPOSE_PROJECT_PORT_ELASTICSEARCH` - `$COMPOSE_PROJECT_PORT_PREFIX` + `92` by default
* `COMPOSE_PROJECT_PORT_MAIL_WEBGUI` - `$COMPOSE_PROJECT_PORT_PREFIX` + `25` by default

## Enable xdebug
In first you need to define the environment variable `XDEBUG_MODE`
```bash
export XDEBUG_MODE=debug
```
or container specific 
```bash
export XDEBUG_MODE_FPM=debug
export XDEBUG_MODE_CLI=debug
export XDEBUG_MODE_CRON=debug
```

Visual Studio Code launch.json
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "hostname": "0.0.0.0",
            "port": 9003,
            "pathMappings": {
                "/var/www": "${fileWorkspaceFolder}"
            }
        }
    ]
}
```