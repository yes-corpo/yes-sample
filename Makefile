install:
	composer install
	make asset-install
	
asset-install:
	yarn install
	yarn build

db-install:
	php bin/console doctrine:database:create
	php bin/console doctrine:migrations:migrate

fixtures:
	php bin/console doctrine:fixtures:load