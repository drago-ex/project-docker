# Drago Project Docker

Basic Docker configuration for a PHP server.

[![PHP version](https://badge.fury.io/ph/drago-ex%2Fproject-docker.svg)](https://badge.fury.io/ph/drago-ex%2Fproject-docker)
[![Coding Style](https://github.com/drago-ex/project-docker/actions/workflows/coding-style.yml/badge.svg)](https://github.com/drago-ex/project-docker/actions/workflows/coding-style.yml)

## Requirements

- PHP >= 8.3, < 9
- Docker

## Installation

```bash
composer require drago-ex/project-docker
```

## Files copied into the project

The files are copied into the project by [drago-ex/project-tools](https://github.com/drago-ex/project-tools),
as set in `extra.drago-tools` of this package's `composer.json`.

## PHP extensions

The image has GD (JPEG, PNG, WebP) for resizing uploaded images and intl for slugs made from names;
`docker/conf/php.ini` sets the upload limits (64 MB) and `memory_limit` (256 MB, enough to resize photos).

## Docker commands

The available Docker scripts are listed in [`package.json`](https://github.com/drago-ex/project-docker/blob/main/package.json).
It is not copied into the project; add the scripts you want to the `scripts` of your own `package.json`.
