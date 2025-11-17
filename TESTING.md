# Testing the OCI/Docker Version

## Prerequisites

1. **Docker Desktop** must be running
2. The Docker image must be built and pushed to GHCR (check GitHub Actions)

## Quick Test

Run the automated test script:

```bash
./test-docker.sh
```

## Manual Testing Steps

### 1. Pull the Docker Image

```bash
docker pull ghcr.io/rosch100/mcp-sqlite:0.2.1
```

### 2. Verify MCP Label

```bash
docker inspect ghcr.io/rosch100/mcp-sqlite:0.2.1 \
  --format='{{index .Config.Labels "io.modelcontextprotocol.server.name"}}'
```

Expected output: `io.github.rosch100/mcp-sqlite`

### 3. Test Container Execution

```bash
# Basic test
docker run --rm ghcr.io/rosch100/mcp-sqlite:0.2.1 --args '{"db_path":"/tmp/test.db","passphrase":"test"}'
```

### 4. Test MCP Protocol

```bash
# Send initialize request
echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"test","version":"1.0"}}}' | \
  docker run --rm -i ghcr.io/rosch100/mcp-sqlite:0.2.1 \
  --args '{"db_path":"/tmp/test.db","passphrase":"test"}'
```

### 5. Test with Real Database

```bash
# Mount your database file
docker run --rm -i \
  -v /path/to/your/database.sqlite:/data/database.sqlite:ro \
  ghcr.io/rosch100/mcp-sqlite:0.2.1 \
  --args '{"db_path":"/data/database.sqlite","passphrase":"your-passphrase"}'
```

## Testing with MCP Client

### Cursor Configuration

Create or update `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "encrypted-sqlite": {
      "command": "docker",
      "args": [
        "run",
        "--rm",
        "-i",
        "-v",
        "/path/to/your/database.sqlite:/data/database.sqlite:ro",
        "ghcr.io/rosch100/mcp-sqlite:0.2.1",
        "--args",
        "{\"db_path\":\"/data/database.sqlite\",\"passphrase\":\"your-passphrase\"}"
      ]
    }
  }
}
```

### Claude Desktop Configuration

Create or update `~/Library/Application Support/Claude/claude_desktop_config.json` (macOS) or `%APPDATA%\Claude\claude_desktop_config.json` (Windows):

```json
{
  "mcpServers": {
    "encrypted-sqlite": {
      "command": "docker",
      "args": [
        "run",
        "--rm",
        "-i",
        "-v",
        "/path/to/your/database.sqlite:/data/database.sqlite:ro",
        "ghcr.io/rosch100/mcp-sqlite:0.2.1",
        "--args",
        "{\"db_path\":\"/data/database.sqlite\",\"passphrase\":\"your-passphrase\"}"
      ]
    }
  }
}
```

## Troubleshooting

### Docker not running
- Start Docker Desktop
- Verify with: `docker ps`

### Image not found
- Check GitHub Actions: https://github.com/rosch100/mcp-sqlite/actions
- Verify image exists: https://github.com/rosch100/mcp-sqlite/pkgs/container/mcp-sqlite

### MCP label missing
- Ensure the Dockerfile contains: `LABEL io.modelcontextprotocol.server.name="io.github.rosch100/mcp-sqlite"`
- Rebuild and push the image

### Permission denied
- Ensure database file is readable
- Check Docker volume mount permissions

## Expected Behavior

1. ✅ Container starts without errors
2. ✅ MCP label is present in image metadata
3. ✅ Initialize request returns valid JSON-RPC response
4. ✅ Tools are listed correctly
5. ✅ Database operations work correctly

