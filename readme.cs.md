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
se nekopíruje (`local/`, soubory zapsané pro jedno prostředí, připojují balíčky, které ho potřebují).
Po změně `vendor/` bez změny `composer.lock` sestavte obraz znovu pomocí `docker compose up -d --build`.

## Rozšíření PHP

Obraz má GD (JPEG, PNG, WebP) pro zmenšování nahraných obrázků a intl pro slugy vytvořené z názvů;
`docker/php.ini` nastavuje limity nahrávání (64 MB) a `memory_limit` (256 MB, stačí na zmenšení fotek).

## Zabezpečení

- Režim ladění (Tracy) je vypnutý, pokud o něj nepožádáte: `npm run docker:dev` načte `docker/.env.development`
  (`NETTE_DEBUG=1` a `PHP_EXCEPTION_IGNORE_ARGS=0`, které ponechá argumenty funkcí ve stack trace), obyčejné
  `docker compose up` a `npm run docker:production` běží bez něj.
- Server poslouchá jen na `127.0.0.1:8080`. Pro zveřejnění na všech rozhraních nastavte `SERVER_PORT=8080`;
  Docker obchází firewally jako `ufw`, proto na produkci raději použijte před serverem reverzní proxy s HTTPS.
- V `www/upload/` se PHP nikdy nespustí a nahraný `.htaccess` se ignoruje. Soubory odtud se posílají
  s `Content-Security-Policy`, která nespustí žádný skript, takže nahraný SVG nebo HTML soubor otevřený přímo nemůže web napadnout.
- `docker/php.ini` skrývá verzi PHP, chyby loguje místo zobrazení, mimo vývoj vynechává argumenty
  funkcí ze stack trace (i když `PHP_EXCEPTION_IGNORE_ARGS` není nastavené), omezuje `max_execution_time`
  na 60 s a session cookies jsou striktní, HttpOnly a SameSite. `disable_functions` je připravené k odkomentování,
  pokud v kontejneru nic nespouští shellové příkazy (PHP CLI, např. Composer, čte stejný soubor).
- Za reverzní proxy nastavte v `app.neon`, aby jí Nette důvěřovalo, takže uvidí IP adresu návštěvníka a HTTPS:
  ```neon
  http:
  	proxy: 172.16.0.0/12  # the address or range of your proxy
  ```
  Bez toho přicházejí všechny požadavky z adresy proxy, takže limit přihlášení z project-auth by zablokoval všechny
  návštěvníky najednou a Nette by session cookie neoznačilo jako secure (na HTTPS to dělá samo).
- Apache skrývá svou verzi (`docker/conf/security.conf`) a posílá `X-Content-Type-Options` a `Referrer-Policy`.
- Obraz pravidelně sestavujte znovu pomocí `docker compose build --pull`, aby obsahoval bezpečnostní opravy PHP
  a Debianu.

## Příkazy pro Docker

Dostupné skripty pro Docker jsou v [`package.json`](https://github.com/drago-ex/project-docker/blob/main/package.json).
Do projektu se nekopíruje; skripty, které chcete používat, přidejte do `scripts` vlastního `package.json`.
