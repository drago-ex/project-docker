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
`docker/conf/php.ini` sets the upload limits (64 MB) and `memory_limit` (256 MB, enough to resize photos).

## Docker commands

The available Docker scripts are listed in [`package.json`](https://github.com/drago-ex/project-docker/blob/main/package.json).
It is not copied into the project; add the scripts you want to the `scripts` of your own `package.json`.
