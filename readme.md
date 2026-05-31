# Drago docker

Basic configuration of a php server on docker.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/drago-ex/project-docker/blob/main/license)
[![PHP version](https://badge.fury.io/ph/drago-ex%2Fproject-docker.svg)](https://badge.fury.io/ph/drago-ex%2Fproject-docker)
[![Coding Style](https://github.com/drago-ex/project-docker/actions/workflows/coding-style.yml/badge.svg)](https://github.com/drago-ex/project-docker/actions/workflows/coding-style.yml)

## Installation
```bash
composer require drago-ex/project-docker
```

## Project files
File copying is handled automatically by [drago-ex/project-installer](https://github.com/drago-ex/project-installer),
which must be installed in your project. Without it, copy the files manually according to the `copy` section
in this package's `composer.json`. To skip this package, set `"skip": true` under
`extra.drago-project.packages.<package-name>` in your root `composer.json`.

## Docker commands
All docker commands are located in this file:
- https://github.com/drago-ex/project-docker/blob/main/package.json
