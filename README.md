# Magento 2 Docker Compose Environment
> The easy magento environment for Dummies
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
        "repo.magento.com": {
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
brew install digitalspacestdio/docker-compose-magento/docker-compose-magento
```

## Option.1 Starting new magento project with sample data from scratch

1. Create the new projet directory
```bash
mkdir ~/magento2
```

2. Navigate to the projet directory
```bash
cd ~/magento2
```

3. Create the new magento project
```bash
docker-compose-magento composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=^2 /var/www
```

4. Deploy sample data
```bash
docker-compose-magento bin/magento sampledata:deploy
```

5. Install the application
```bash
docker-compose-magento bin/magento setup:install --backend-frontname="admin" --key="admin" --session-save="files" --db-host="database:3306" --db-name="magento2" --db-user="magento2" --db-password="magento2" --base-url="http://localhost:30280/" --base-url-secure="https://localhost:30280/" --admin-user="admin" --admin-password='$ecretPassw0rd' --admin-email="johndoe@example.com" --admin-firstname="John" --admin-lastname="Doe" --key="26765209cb05b93729898c892d18a8dd" --search-engine=elasticsearch7  --elasticsearch-host=elasticsearch --elasticsearch-port=9200
```

6. Optionally: Disable 2FA module (if needed)
```bash
docker-compose-magento bin/magento module:disable Magento_TwoFactorAuth
```

7. Optionally: Disable FPC
```bash
docker-compose-magento bin/magento cache:disable full_page
```

8. Optionally: Disable Secure URLs
```bash
docker-compose-magento bin/magento config:set web/secure/use_in_adminhtml 0
docker-compose-magento bin/magento config:set web/secure/use_in_frontend 1
```

9. Start the stack in the background mode
```bash
docker-compose-magento up -d
```

## Option.2 Starting already exists project from git and local sql dump

1. Clone the project source code

```bash
git clone https://github.com/magento/magento2.git ~/magento2
```

2. navigate to the project dir
```bash
cd  ~/magento2
```

3. Install dependencies
```bash
docker-compose-magento composer install -o --no-interaction
```

4. Configure the application database credentials
```bash
docker-compose-magento database-config
```

5. Configure the application redis settings
```bash
docker-compose-magento redis-config
```

6. Configure the application elasticsearch settings
```bash
docker-compose-magento elasticsearch-config
```

7. Import database dump (supports `*.sql` and `*.sql.gz` files)
```bash
docker-compose-magento database-import /path/to/dump.sql.gz
```

8. Optionally: Disable 2FA module (if needed)
```bash
docker-compose-magento bin/magento module:disable Magento_TwoFactorAuth
```

9. Optionally: Disable FPC
```bash
docker-compose-magento bin/magento cache:disable full_page
```

10. Optionally: Disable Secure URLs
```bash
docker-compose-magento bin/magento config:set  web/secure/use_in_adminhtml 0
docker-compose-magento bin/magento config:set  web/secure/use_in_frontend 1
```

11. Start the stack in the background mode
```bash
docker-compose-magento up -d
```

> Application will be available by following link: http://localhost:30280/

## Shutdown the project stack

Stop containers
```bash
docker-compose-magento down
```

Destroy containers and persistent data
```bash
docker-compose-magento down -v
```

## Extra tools

Connecting to the mysql container
```bash
docker-compose-magento mysql
```

Connecting to the cli container
```bash
docker-compose-magento bash
```

Generate compose config and run directly without this tool
```bash
docker-compose-magento config > docker-compose.yml
```
```bash
docker compose up
```


## Environment Variables
> Can be stored in the `.dockenv` or `.env` file in the project root
* `COMPOSE_PROJECT_MODE` - (`mutagen`|`default`)
* `COMPOSE_PROJECT_PHP_VERSION` - (`7.1`|`7.2`|`7.3`|`7.4`|`8.0`|`8.1`|`8.2`), the image will be built from a corresponding `fpm-alpine` image, see https://hub.docker.com/_/php/?tab=tags&page=1&name=fpm-alpine&ordering=name for more versions
* `COMPOSE_PROJECT_NODE_VERSION` - (`12.22.12`|`14.19.3`|`16.16.0`) see https://nodejs.org/dist/ for more versions
* `COMPOSE_PROJECT_MYSQL_IMAGE` - `mysql:8.0-oracle` see https://hub.docker.com/_/mysql/?tab=tags for more versions
* `COMPOSE_PROJECT_ELASTICSEARCH_VERSION` - `7.17.5` see https://www.docker.elastic.co/r/elasticsearch/elasticsearch-oss for more versions
* `COMPOSE_PROJECT_NAME` - by default the working directory name will be used
* `COMPOSE_PROJECT_PORT_PREFIX` - `302` by default
* `COMPOSE_PROJECT_PORT_HTTP` - `$COMPOSE_PROJECT_PORT_PREFIX` + `80` by default
* `COMPOSE_PROJECT_PORT_XHGUI` - `$COMPOSE_PROJECT_PORT_PREFIX` + `81` by default
* `COMPOSE_PROJECT_PORT_MYSQL` - `$COMPOSE_PROJECT_PORT_PREFIX` + `06` by default
* `COMPOSE_PROJECT_PORT_ELASTICSEARCH` - `$COMPOSE_PROJECT_PORT_PREFIX` + `92` by default
* `COMPOSE_PROJECT_PORT_MAIL_WEBGUI` - `$COMPOSE_PROJECT_PORT_PREFIX` + `25` by default

## Configure the XhProf in the project

Add required packages 
```bash
docker-compose-magento composer require perftools/php-profiler 
docker-compose-magento composer require perftools/xhgui-collector
docker-compose-magento composer require alcaeus/mongo-php-adapter
```

Apply the patch

```bash
docker-compose-magento xhprof-patch
```

To revert the patch run:
```bash
docker-compose-magento xhprof-revert
```

