# GHCR Package Prüfung

## Web-Interface

1. **GitHub Packages Seite:**
   https://github.com/rosch100/mcp-sqlite/pkgs/container/mcp-sqlite

2. **GitHub Actions:**
   https://github.com/rosch100/mcp-sqlite/actions

## Was zu prüfen ist:

### 1. Image verfügbar?
- ✅ Tag `0.2.1` sollte vorhanden sein
- ✅ Tag `main` sollte vorhanden sein
- ✅ Tag `latest` sollte vorhanden sein (wenn auf main gepusht wurde)

### 2. MCP Label vorhanden?
- Öffnen Sie das Image mit Tag `0.2.1`
- Prüfen Sie die "Image details" oder "Manifest"
- Suchen Sie nach: `io.modelcontextprotocol.server.name`
- Wert sollte sein: `io.github.rosch100/mcp-sqlite`

### 3. Image öffentlich?
- Prüfen Sie, ob das Paket auf "Public" gesetzt ist
- Falls nicht: Repository Settings → Packages → Package visibility → Public

## Mit Docker prüfen (wenn Docker Desktop installiert):

```bash
# Image pullen
docker pull ghcr.io/rosch100/mcp-sqlite:0.2.1

# Label prüfen
docker inspect ghcr.io/rosch100/mcp-sqlite:0.2.1 \
  --format='{{index .Config.Labels "io.modelcontextprotocol.server.name"}}'

# Sollte ausgeben: io.github.rosch100/mcp-sqlite
```

## Veröffentlichung testen:

```bash
# 1. Authentifizieren
mcp-publisher login github

# 2. Veröffentlichen
mcp-publisher publish
```

Wenn das Image das Label hat und öffentlich ist, sollte die Veröffentlichung erfolgreich sein.


