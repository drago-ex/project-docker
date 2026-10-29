# Drago Project Docker

Basic Docker configuration for a PHP server.

[![PHP version](https://badge.fury.io/ph/drago-ex%2Fproject-docker.svg)](https://badge.fury.io/ph/drago-ex%2Fproject-docker)
[![Coding Style](https://github.com/drago-ex/project-docker/actions/workflows/coding-style.yml/badge.svg)](https://github.com/drago-ex/project-docker/actions/workflows/coding-style.yml)

## Requirements

- PHP >= 8.3, < 9
- [Drago Project](https://github.com/drago-ex/project)
- Docker

## Installation

```bash
composer require drago-ex/project-docker
```

## Files copied into the project

The files are copied into the project by [drago-ex/project-tools](https://github.com/drago-ex/project-tools),
as set in `extra.drago-tools` of this package's `composer.json`.

## Project in the image

The project is copied into the image (`docker/Dockerfile-app`) instead of being mounted from your disk, which is
slow on Windows. Run `docker compose watch` (or `npm run docker:dev`) while you work: it copies every change of
`app/` and `www/` into the running container and builds a new image when `composer.lock` changes. Only `log/`
and `www/upload/` are mounted, so logs are visible and uploaded files outlast a new image; what `.dockerignore`
lists is not copied. After changing `vendor/` without `composer.lock`, build the image again with
`docker compose up -d --build`.

## PHP extensions

The image has GD (JPEG, PNG, WebP) for resizing uploaded images and intl for slugs made from names;
`docker/php.ini` sets the upload limits (64 MB) and `memory_limit` (256 MB, enough to resize photos).

## Security

- Debug mode (Tracy) is off unless asked for: `npm run docker:dev` loads `docker/.env.development` (`NETTE_DEBUG=1`,
  and `PHP_EXCEPTION_IGNORE_ARGS=0` keeps function arguments in stack traces), a plain `docker compose up` and
  `npm run docker:production` run without it.
- The server listens only on `127.0.0.1:8080`. To publish it on every interface, set `SERVER_PORT=8080`; Docker
  bypasses firewalls such as `ufw`, so in production prefer an HTTPS reverse proxy in front of it.
- PHP never runs in `www/upload/`, and an uploaded `.htaccess` is ignored.
- `docker/php.ini` hides the PHP version, logs errors instead of showing them, leaves function arguments out
  of stack traces outside development, limits `max_execution_time` to 60 s and makes session cookies strict, HttpOnly and SameSite.
  Behind HTTPS, uncomment `session.cookie_secure`; `disable_functions` is ready to uncomment when nothing in the
  container runs shell commands (the PHP CLI, e.g. Composer, reads the same file).
- Apache hides its version (`docker/conf/security.conf`) and sends `X-Content-Type-Options` and `Referrer-Policy`.
- Rebuild the image regularly with `docker compose build --pull` to get security fixes of PHP and Debian.

## Docker commands

The available Docker scripts are listed in [`package.json`](https://github.com/drago-ex/project-docker/blob/main/package.json).
It is not copied into the project; add the scripts you want to the `scripts` of your own `package.json`.
