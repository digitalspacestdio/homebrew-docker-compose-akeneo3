# Magento 2 Docker Compose Environment

## Pre-requirements (MacOs/Linux/Windows)

Install Homebrew by following guide https://docs.brew.sh/Installation

## Optional Pre-requirements (MacOs only)
Configure and start nfs
```bash
echo "$HOME -alldirs -mapall=$UID:20 localhost" | sudo tee -a /etc/exports
echo "nfs.server.mount.require_resv_port = 0" | sudo tee -a /etc/nfs.conf
```

Start the NFS server
```bash
sudo nfsd restart
```

## Optional Mutagen Integration (MacOs/Windows only)
To use mutagen integration just define environment variable
```bash
export COMPOSE_PROJECT_MODE=mutagen
```

## Usage
Export your composer auth tokens
If you use github only
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
````

To use specific php version just export environment variable:
```bash
export COMPOSE_PROJECT_PHP_VERSION=7.4
```
> following versions are supported: 7.2, 7.3, 7.4, 8.0

Clone this repo
```bash
brew install digitalspacestdio/docker-compose-magento/docker-compose-magento
```

Create the working dir
```bash
mkdir ~/magento2
cd ~/magento2
```

Clone your code to the `www` folder or create the new project:
```bash
docker-compose-magento run --rm cli composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=^2 /var/www
```

Install dependencies (if needed)
```bash
docker-compose-magento run --rm cli composer install -o --no-interaction
```

Deploy sample data (if needed)
```bash
docker-compose-magento run --rm cli bin/magento sampledata:deploy
```

Install the application
```bash
docker-compose-magento run --rm cli bin/magento setup:install --backend-frontname="admin" --key="admin" --session-save="files" --db-host="database:3306" --db-name="magento2" --db-user="magento2" --db-password="magento2" --base-url="http://localhost:30280/" --base-url-secure="https://localhost:30280/" --admin-user="admin" --admin-password='$ecretPassw0rd' --admin-email="johndoe@example.com" --admin-firstname="John" --admin-lastname="Doe" --key="26765209cb05b93729898c892d18a8dd" --search-engine=elasticsearch7  --elasticsearch-host=elasticsearch --elasticsearch-port=9200
```

Disable 2FA module (if needed)
```bash
docker-compose-magento run --rm cli bin/magento module:disable Magento_TwoFactorAuth
```

Disable FPC
```bash
docker-compose-magento run --rm cli bin/magento cache:disable full_page
```

Start the stack
```bash
docker-compose-magento up
```

Also you can start the stack in the background mode
```bash
docker-compose-magento up -d
```

> Application should be available by following link: http://localhost:30280/

Stop the stack
```bash
docker-compose-magento down
```

Destroy the whole data
```bash
docker-compose-magento down -v
```
