# Development

## Building

```bash
./gradlew build
```

## Running Tests

```bash
./gradlew test
```

## Running the Server

```bash
./gradlew run --args='{"db_path":"/path/to/db.sqlite","passphrase":"secret"}'
```

Or use the installed binary:

```bash
./build/install/mcp-encrypted-sqlite/bin/mcp-encrypted-sqlite --args '{"db_path":"/path/to/db.sqlite","passphrase":"secret"}'
```

## Project Structure

```
mcp-encrypted-sqlite/
├── src/
│   ├── main/java/com/example/mcp/sqlite/
│   │   ├── McpServer.java          # Main MCP server implementation
│   │   ├── EncryptedSqliteClient.java  # SQLite client with encryption
│   │   ├── config/
│   │   │   ├── DatabaseConfig.java     # Database configuration
│   │   │   └── CipherProfile.java      # Cipher profile configuration
│   │   └── util/
│   │       └── SqliteUtil.java         # SQLite utilities
│   └── test/                           # Unit tests
├── libs/
│   └── sqlite-jdbc-3.50.1.0.jar        # SQLite JDBC driver with encryption
├── build.gradle                         # Gradle build configuration
└── README.md                            # This file
```

