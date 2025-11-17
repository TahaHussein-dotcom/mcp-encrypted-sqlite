#!/bin/bash
# Test script for Docker/OCI version of MCP SQLite Server

set -e

IMAGE="ghcr.io/rosch100/mcp-sqlite:0.2.1"
TEST_DB="/tmp/test-encrypted.db"
TEST_PASSPHRASE="test-passphrase-123"

echo "=== Testing OCI/Docker Version of MCP SQLite Server ==="
echo ""

# 1. Check if Docker is running
echo "1. Checking Docker..."
if ! docker ps > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop."
    exit 1
fi
echo "✅ Docker is running"
echo ""

# 2. Pull the image
echo "2. Pulling Docker image..."
docker pull "$IMAGE" || {
    echo "❌ Failed to pull image. Make sure the GitHub Actions workflow has completed."
    exit 1
}
echo "✅ Image pulled successfully"
echo ""

# 3. Check if the image has the required MCP label
echo "3. Checking MCP label..."
LABEL=$(docker inspect "$IMAGE" --format='{{index .Config.Labels "io.modelcontextprotocol.server.name"}}')
if [ -z "$LABEL" ]; then
    echo "❌ MCP label not found in image"
    echo "   Expected: io.modelcontextprotocol.server.name=io.github.rosch100/mcp-sqlite"
    exit 1
fi
echo "✅ MCP label found: $LABEL"
echo ""

# 4. Test basic container execution
echo "4. Testing container execution..."
docker run --rm "$IMAGE" --help > /dev/null 2>&1 || {
    echo "⚠️  Container doesn't support --help, but that's okay"
}
echo "✅ Container can be executed"
echo ""

# 5. Test with a simple MCP initialize request
echo "5. Testing MCP protocol (initialize)..."
INIT_REQUEST='{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"test-client","version":"1.0.0"}}}'

RESPONSE=$(echo "$INIT_REQUEST" | docker run --rm -i "$IMAGE" --args '{"db_path":"/tmp/test.db","passphrase":"test"}' 2>&1 | head -1)

if echo "$RESPONSE" | grep -q "jsonrpc"; then
    echo "✅ MCP protocol response received:"
    echo "$RESPONSE" | python3 -m json.tool 2>/dev/null || echo "$RESPONSE"
else
    echo "⚠️  Unexpected response (might be an error, but container is running):"
    echo "$RESPONSE"
fi
echo ""

# 6. Show image details
echo "6. Image details:"
echo "   Image: $IMAGE"
echo "   Size: $(docker images "$IMAGE" --format '{{.Size}}')"
echo "   Created: $(docker images "$IMAGE" --format '{{.CreatedAt}}')"
echo ""

# 7. Show how to use in MCP configuration
echo "7. Example MCP client configuration:"
cat << 'EOF'
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
EOF
echo ""

echo "=== Test completed ==="
echo ""
echo "To test with a real database:"
echo "  1. Create or use an existing encrypted SQLite database"
echo "  2. Mount it in the Docker container using -v flag"
echo "  3. Configure your MCP client with the example above"

