# Agent Guide

`drago-ex/project-docker` (type drago-tools-resource, PHP >=8.3 <9): the Docker setup of every Drago project
(required by drago-ex/project). The workspace rules are in `../AGENTS.md`.

## Layout
- `docker/Dockerfile` (the PHP runtime with GD and intl), `Dockerfile-app` (the project in the image), `php.ini`,
  `conf/` (Apache), `.env.development`, `.env.production`.
- `docker-compose.yaml`, `.dockerignore`: copied into the project.
- `www/index.php`: `phpinfo()` for trying the image alone; it is not copied into projects.
- The rules of `www/upload/` are in `docker/conf/000-default.conf`.
- `package.json`: the npm scripts, kept equal to those of drago-ex/project (not copied).

## Image and watch
- The project is copied into the image (`Dockerfile-app`) instead of a bind mount, which is very slow on
  Windows/WSL2. `docker compose watch` (`develop.watch`) syncs `app/` and `www/` and rebuilds on `composer.lock`.
  Only `log/` and `www/upload/` are bind mounts. `local/` is copied like the rest; project-docker-db adds a watch
  rule for it.
- Writable for www-data in the image are only `temp`, `log`, `www/upload` and `.drago-project`; the project root is
  chowned back to root with 755, because the php image gives www-data `/var/www/html` with 1777.
  `bin/project-setup` of drago-ex/project runs in the container as www-data and drago-ex/migration writes its
  report to `.drago-project/`; files the project keeps (`assets.md`, copied configs) are written on the host.
- `docker/Dockerfile` is the profiled service `php` (never started), passed to the server build as
  `additional_contexts: php: service:php`, so `docker compose build` builds the whole chain. project-docker-db
  inserts its `php-db` service by overriding that context.

## Security
- `zend.exception_ignore_args` reads `${PHP_EXCEPTION_IGNORE_ARGS:-1}`, so arguments stay out of stack traces
  when the variable is missing; only `.env.development` sets 0 (and `NETTE_DEBUG=1`).
- The server port is `${SERVER_PORT:-127.0.0.1:8080}`, because Docker bypasses ufw.
- `www/upload/` runs no PHP (`engine off`, `.php`/`.phtml`/`.phar` denied, `AllowOverride None`) and sends a
  sandboxing `Content-Security-Policy`, so an uploaded SVG/HTML runs no script.
- Behind a reverse proxy the project needs `http: proxy:` (README): project-auth limits sign-ins by
  `getRemoteAddress()`, and Nette marks the session cookie secure only when it sees HTTPS.

## Commands
No tests or PHPStan; CI runs only the Nette Code Checker. Check a compose change with `docker compose config`.
