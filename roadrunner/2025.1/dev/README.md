## How extend base image?

1. Create Symfony app. Required: spiral/roadrunner-cli, runtime/roadrunner-symfony-nyholm
2. Put files from current directory into - {symfony-app}/docker/dev.
3. cp {symfony-app}/docker/dev/.env.dist {symfony-app}/docker/dev/.env
3. Run `make up`
