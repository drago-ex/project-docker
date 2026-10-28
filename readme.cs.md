# Drago Project Docker

Základní konfigurace Dockeru pro PHP server.

[![PHP version](https://badge.fury.io/ph/drago-ex%2Fproject-docker.svg)](https://badge.fury.io/ph/drago-ex%2Fproject-docker)
[![Coding Style](https://github.com/drago-ex/project-docker/actions/workflows/coding-style.yml/badge.svg)](https://github.com/drago-ex/project-docker/actions/workflows/coding-style.yml)

## Požadavky

- PHP >= 8.3, < 9
- [Drago Project](https://github.com/drago-ex/project)
- Docker

## Instalace

```bash
composer require drago-ex/project-docker
```

## Soubory kopírované do projektu

Soubory do projektu kopíruje [drago-ex/project-tools](https://github.com/drago-ex/project-tools)
podle nastavení v `extra.drago-tools` v `composer.json` tohoto balíčku.

## Projekt v obrazu

Projekt se kopíruje do obrazu (`docker/Dockerfile-app`), místo aby se připojoval z vašeho disku, což je na
Windows pomalé. Během práce spusťte `docker compose watch` (nebo `npm run docker:dev`): každou změnu v `app/`
a `www/` zkopíruje do běžícího kontejneru a při změně `composer.lock` sestaví nový obraz. Připojené jsou jen
`log/` a `www/upload/`, takže logy jsou vidět a nahrané soubory přežijí nový obraz; co uvádí `.dockerignore`,
se nekopíruje. Po změně `vendor/` bez změny `composer.lock` sestavte obraz znovu pomocí
`docker compose up -d --build`.

## Rozšíření PHP

Obraz má GD (JPEG, PNG, WebP) pro zmenšování nahraných obrázků a intl pro slugy vytvořené z názvů;
`docker/conf/php.ini` nastavuje limity nahrávání (64 MB) a `memory_limit` (256 MB, stačí na zmenšení fotek).

## Příkazy pro Docker

Dostupné skripty pro Docker jsou v [`package.json`](https://github.com/drago-ex/project-docker/blob/main/package.json).
Do projektu se nekopíruje; skripty, které chcete používat, přidejte do `scripts` vlastního `package.json`.
