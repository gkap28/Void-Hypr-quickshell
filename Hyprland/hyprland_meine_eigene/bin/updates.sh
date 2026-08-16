#!/usr/bin/bash

updates=$(xbps-install --memory-sync --dry-run --update | grep -Fe update -e install | wc -l)

echo "$updates"