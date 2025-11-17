#!/bin/bash
# Skript zum Abrufen oder Generieren des Verschlüsselungsschlüssels

set -e

echo "Prüfe Keychain..."
KEY=$(security find-generic-password -s "mcp-sqlite" -a "encryption-key" -w 2>/dev/null || echo "")

if [ -n "$KEY" ]; then
    echo "✅ Schlüssel im Keychain gefunden!"
    echo ""
    echo "Verwenden Sie diesen Schlüssel in Ihrer Cursor-Konfiguration:"
    echo ""
    echo "$KEY"
    echo ""
    echo "Oder fügen Sie ihn automatisch zur Konfiguration hinzu mit:"
    echo "./get-encryption-key.sh --update-config"
else
    echo "⚠️  Kein Schlüssel im Keychain gefunden."
    echo ""
    echo "Sie müssen einen neuen Schlüssel generieren:"
    echo "1. Führen Sie aus: ./store-key-in-keychain.sh --generate"
    echo "2. Dann führen Sie dieses Skript erneut aus"
fi

if [ "$1" = "--update-config" ] && [ -n "$KEY" ]; then
    echo ""
    echo "Aktualisiere Cursor-Konfiguration..."
    python3 << PYTHON
import json
import os

config_path = os.path.expanduser("~/.cursor/mcp.json")
key = "$KEY"

with open(config_path, 'r') as f:
    config = json.load(f)

if "encrypted-sqlite" in config["mcpServers"]:
    if "env" not in config["mcpServers"]["encrypted-sqlite"]:
        config["mcpServers"]["encrypted-sqlite"]["env"] = {}
    config["mcpServers"]["encrypted-sqlite"]["env"]["MCP_SQLITE_ENCRYPTION_KEY"] = key

with open(config_path, 'w') as f:
    json.dump(config, f, indent=2)

print("✅ Konfiguration aktualisiert!")
PYTHON
fi
