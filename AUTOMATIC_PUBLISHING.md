# Automatische Veröffentlichung - Übersicht

Welche MCP Server Verzeichnisse unterstützen automatische Veröffentlichung?

## ✅ Vollautomatisch (API/CLI verfügbar)

### 1. MCP Registry (Offiziell)
- **URL**: https://registry.modelcontextprotocol.io
- **Methode**: `mcp-publisher` CLI Tool
- **Authentifizierung**: GitHub OIDC
- **Status**: ✅ Vollständig automatisierbar
- **Workflow**: `.github/workflows/publish-mcp-registry.yml`
- **Beschreibung**: 
  - Offizielle Registry des Model Context Protocol
  - Standard für MCP Server Veröffentlichung
  - Automatische Veröffentlichung bei Releases
  - Keine manuelle Intervention nötig

**Setup:**
```bash
# Installation
brew install mcp-publisher  # oder Download von GitHub Releases

# Authentifizierung (einmalig)
mcp-publisher login github-oidc

# Veröffentlichung
mcp-publisher publish
```

**GitHub Actions:**
- Workflow bereits erstellt: `publish-mcp-registry.yml`
- Läuft automatisch bei Releases
- Verwendet GitHub OIDC (keine Secrets nötig)

---

### 2. GitHub Container Registry (ghcr.io)
- **URL**: https://github.com/orgs/USERNAME/packages/container/package-name
- **Methode**: Docker Build & Push via GitHub Actions
- **Authentifizierung**: GitHub Token (automatisch)
- **Status**: ✅ Bereits automatisiert
- **Workflow**: `.github/workflows/docker.yml`
- **Beschreibung**:
  - Integriert mit GitHub
  - Docker Images für MCP Server
  - Automatischer Build & Push bei Tags/Releases
  - Multi-Platform Support (amd64, arm64)

**GitHub Actions:**
- Workflow bereits aktiv: `docker.yml`
- Läuft automatisch bei:
  - Tags (v*)
  - Pushes zu main/master
  - Pull Requests (nur Build, kein Push)

**Docker Images:**
- `ghcr.io/rosch100/mcp-sqlite:latest`
- `ghcr.io/rosch100/mcp-sqlite:0.2.4`
- `ghcr.io/rosch100/mcp-sqlite:0.2`
- `ghcr.io/rosch100/mcp-sqlite:0`

---

## ⚠️ Teilweise automatisierbar (API möglicherweise verfügbar)

### 3. MCP Index
- **URL**: https://mcpindex.net/
- **Methode**: Unbekannt (möglicherweise API)
- **Status**: ⚠️ Prüfung erforderlich
- **Beschreibung**:
  - Community-Verzeichnis
  - Detaillierte Server-Informationen
  - API-Verfügbarkeit unklar

**Aktueller Status:**
- Keine bekannte API dokumentiert
- Submission-Template vorbereitet: `MCPINDEX_SUBMISSION.md`
- Manuelle Submission erforderlich (bis API gefunden)

**Nächste Schritte:**
- Prüfe GitHub Repository von MCP Index
- Suche nach API-Dokumentation
- Prüfe ob GitHub Webhook unterstützt wird

---

## ❌ Manuell (keine API verfügbar)

### 4. MCPList.ai
- **URL**: https://www.mcplist.ai/
- **Methode**: E-Mail Submission
- **Status**: ❌ Manuell
- **Submission**: `MCPLIST_SUBMISSION.md`
- **Beschreibung**:
  - Kein Submission-Formular auf Website
  - Submission per E-Mail erforderlich
  - E-Mail-Vorlage vorbereitet

### 5. MCPServ.club
- **URL**: https://www.mcpserv.club/
- **Methode**: Web-Formular (manuell)
- **Status**: ❌ Manuell
- **Submission**: `MCPSERV_SUBMISSION.md`

### 6. Directory MCP
- **URL**: https://directorymcp.com/
- **Methode**: Web-Formular (manuell)
- **Status**: ❌ Manuell
- **Submission**: `DIRECTORY_MCP_SUBMISSION.md`

### 7. MCPHub
- **URL**: https://mcphub.com/
- **Methode**: Web-Formular (manuell)
- **Status**: ❌ Manuell
- **Submission**: `MCPHUB_SUBMISSION.md`

---

## 📊 Automatisierungs-Übersicht

| Verzeichnis | Automatisierung | Methode | Workflow | Status |
|-------------|----------------|---------|----------|--------|
| **MCP Registry** | ✅ Vollautomatisch | `mcp-publisher` CLI | `publish-mcp-registry.yml` | ✅ Aktiv |
| **ghcr.io** | ✅ Vollautomatisch | Docker Build & Push | `docker.yml` | ✅ Aktiv |
| **MCP Index** | ⚠️ Unbekannt | API (möglicherweise) | - | ⏳ Prüfung |
| **MCPList.ai** | ❌ Manuell | E-Mail | - | 📧 Template |
| **MCPServ.club** | ❌ Manuell | Web-Formular | - | 📋 Template |
| **Directory MCP** | ❌ Manuell | Web-Formular | - | 📋 Template |
| **MCPHub** | ❌ Manuell | Web-Formular | - | 📋 Template |

---

## 🚀 Aktuelle Automatisierung

### Bereits implementiert:

1. **MCP Registry Auto-Publish**
   - Workflow: `.github/workflows/publish-mcp-registry.yml`
   - Trigger: Bei Releases
   - Authentifizierung: GitHub OIDC
   - Status: ✅ Bereit

2. **Docker Image Build & Push**
   - Workflow: `.github/workflows/docker.yml`
   - Trigger: Bei Tags/Releases
   - Registry: ghcr.io
   - Status: ✅ Aktiv

3. **server.json Auto-Update**
   - Workflow: `.github/workflows/update-server-json.yml`
   - Trigger: Bei Version-Änderungen
   - Status: ✅ Aktiv

4. **Release Notification**
   - Workflow: `.github/workflows/release-notification.yml`
   - Erstellt: Checkliste für manuelle Submissions
   - Status: ✅ Aktiv

---

## 📋 Manuelle Submissions

Für Verzeichnisse ohne API werden automatisch erstellt:

- ✅ Submission-Templates für alle Verzeichnisse
- ✅ Checkliste bei jedem Release
- ✅ Links zu allen Templates
- ✅ Alle Informationen vorbereitet

**Workflow:**
1. Release wird erstellt
2. Automatische Workflows laufen (MCP Registry, Docker)
3. Release-Notification erstellt Checkliste
4. Manuelle Submissions mit Templates durchführen

---

## 🔍 Zukünftige Automatisierung

### Potenzielle Verbesserungen:

1. **MCP Index API**
   - Prüfe ob API verfügbar
   - Implementiere GitHub Actions Workflow falls möglich

2. **Webhook-basierte Updates**
   - Falls Community-Verzeichnisse Webhooks unterstützen
   - Automatische Benachrichtigung bei Releases

3. **Monitoring & Verifizierung**
   - Automatische Prüfung nach Submission
   - Status-Checks für alle Verzeichnisse
   - Benachrichtigungen bei Fehlern

---

## 📝 Zusammenfassung

**Automatisch veröffentlichen:**
- ✅ **MCP Registry** (offiziell) - via `mcp-publisher`
- ✅ **ghcr.io** (Docker) - via GitHub Actions

**Manuell veröffentlichen:**
- 📧 **MCPList.ai** - per E-Mail
- 📋 **MCP Index** - Web-Formular (falls keine API)
- 📋 **MCPServ.club** - Web-Formular
- 📋 **Directory MCP** - Web-Formular
- 📋 **MCPHub** - Web-Formular

**Empfehlung:**
- Fokussiere dich auf die automatischen Verzeichnisse (MCP Registry + ghcr.io)
- Nutze die Templates für manuelle Submissions bei wichtigen Releases
- Prüfe regelmäßig ob neue APIs verfügbar werden

