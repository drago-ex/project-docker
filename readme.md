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

## Project files

File copying is handled automatically by [drago-ex/project-tools](https://github.com/drago-ex/project-tools),
which must be installed in your project. Without it, copy the files manually according to the `copy` section
in this package's `composer.json`. To skip this package, set `"skip": true` under
`extra.drago-tools.packages.<package-name>` in your root `composer.json`.

## PHP extensions

The image has GD (JPEG, PNG, WebP) for resizing uploaded images and intl for slugs made from names;
`docker/conf/php.ini` sets the upload limits (64 MB) and `memory_limit` (256 MB, enough to resize photos).

## Docker commands

The available Docker scripts are listed in [`package.json`](https://github.com/drago-ex/project-docker/blob/main/package.json).
It is not copied into the project; add the scripts you want to the `scripts` of your own `package.json`.
