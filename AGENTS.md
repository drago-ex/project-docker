# Agent Guide

Use this file as package-specific guidance when working in this repository. Keep changes aligned with the existing public API, project conventions, and supported PHP range.

## Package Overview
- **Package**: `drago-ex/project-docker`
- **Type**: drago-tools-resource
- **Purpose**: Basic configuration of a php server on docker.
- **PHP**: >=8.3 <9
- **License**: MIT

## Repository Layout
- `docker/`: Docker configuration.
- `www/`: web root files.
- `.github/`: CI workflows; keep their PHP versions and commands consistent with Composer and the package scripts.
- `composer.json`: package metadata, dependency constraints, autoloading, and available Composer scripts.

## Essential Commands

```bash
# No test or static-analysis Composer script is defined in this package.
```

## Tests

This repository does not currently define a test script in `composer.json` or contain a `tests/` directory.
Do not claim behavior is covered by tests unless you find and run a relevant suite. When adding a test suite, follow the package’s existing Nette Tester setup if one is present and add an explicit Composer script.

## Conventions & Rules

- Preserve backward compatibility unless the task explicitly permits a breaking change. Check callers and public signatures before changing behavior.
- Follow the existing PHP style: strict types, explicit parameter and return types, tabs for indentation, and single-quoted strings where practical. Match nearby code when a convention is unclear.
- Keep package-specific configuration, resources, and migrations in their established directories. Do not edit generated or consuming-project files without confirming they are part of this repository’s intended output.
- Add or update focused tests for behavioral changes when this package has a runnable test setup. Do not invent test commands; use only the scripts and configuration present here.
- Update README examples and Composer metadata when a public API or supported requirement changes.

## Image and watch
- The project is copied into the image (`docker/Dockerfile-app`) instead of a bind mount of the project, which is very slow on Windows/WSL2 (2026-10-28, measured ~4 s → ~0.07 s per request); `docker compose watch` (`develop.watch`) syncs `app/` and `www/` and rebuilds on `composer.lock`. Only `log/` and `www/upload/` are bind mounts. `.dockerignore` is copied into the project.
- The runtime `docker/Dockerfile` is the profiled service `php` (never started), passed to the server build as `additional_contexts: php: service:php`, so `docker compose build` builds the whole chain without `docker build -t php-server`. project-docker-db inserts its `php-db` service by overriding that context.
