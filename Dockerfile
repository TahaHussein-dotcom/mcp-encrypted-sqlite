# Multi-stage build for MCP Encrypted SQLite Server
FROM eclipse-temurin:21-jdk-alpine AS builder

WORKDIR /build

# Copy Gradle wrapper and build files
COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./
COPY libs libs

# Copy source code
COPY src src

# Download dependencies and build
RUN chmod +x gradlew && \
    ./gradlew downloadSqliteJdbc && \
    ./gradlew build -x test && \
    ./gradlew installDist

# Runtime image
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Copy the built application
COPY --from=builder /build/build/install/mcp-encrypted-sqlite /app/mcp-encrypted-sqlite

# Create a non-root user
RUN addgroup -S mcp && adduser -S mcp -G mcp && \
    chown -R mcp:mcp /app

# Add MCP server label
LABEL io.modelcontextprotocol.server.name="io.github.rosch100/mcp-encrypted-sqlite"

USER mcp

# Set the entrypoint
ENTRYPOINT ["/app/mcp-encrypted-sqlite/bin/mcp-encrypted-sqlite"]

