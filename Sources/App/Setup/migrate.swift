import Vapor
import FluentPostgreSQL

public func migrate(migrations: inout MigrationConfig) throws {
    migrations.add(model: Todo.self, database: .psql)
}
