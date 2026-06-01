#!/bin/sh
set -e

PROJECT_DIR=/var/www/html
VAR_DIR="$PROJECT_DIR/var"

mkdir -p \
	"$VAR_DIR/cache" \
	"$VAR_DIR/log" \
	"$VAR_DIR/sessions"

chown -R www-data:www-data "$VAR_DIR" 2>/dev/null || true
chmod -R ug+rwX "$VAR_DIR" 2>/dev/null || true

exec "$@"
