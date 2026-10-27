# Drago Project Docker

Základní konfigurace Dockeru pro PHP server.

[![PHP version](https://badge.fury.io/ph/drago-ex%2Fproject-docker.svg)](https://badge.fury.io/ph/drago-ex%2Fproject-docker)
[![Coding Style](https://github.com/drago-ex/project-docker/actions/workflows/coding-style.yml/badge.svg)](https://github.com/drago-ex/project-docker/actions/workflows/coding-style.yml)

## Požadavky

- PHP >= 8.3, < 9
- Docker

## Instalace

```bash
composer require drago-ex/project-docker
```

## Soubory projektu

Kopírování souborů obstarává automaticky [drago-ex/project-tools](https://github.com/drago-ex/project-tools),
který musí být v projektu nainstalovaný. Bez něj zkopírujte soubory ručně podle sekce `copy`
v `composer.json` tohoto balíčku. Pro přeskočení balíčku nastavte `"skip": true` v
`extra.drago-tools.packages.<package-name>` v kořenovém `composer.json`.

## Rozšíření PHP

Obraz má GD (JPEG, PNG, WebP) pro zmenšování nahraných obrázků a intl pro slugy vytvořené z názvů;
`docker/conf/php.ini` nastavuje limity nahrávání (64 MB) a `memory_limit` (256 MB, stačí na zmenšení fotek).

## Příkazy pro Docker

Dostupné skripty pro Docker jsou v [`package.json`](https://github.com/drago-ex/project-docker/blob/main/package.json).
Do projektu se nekopíruje; skripty, které chcete používat, přidejte do `scripts` vlastního `package.json`.
