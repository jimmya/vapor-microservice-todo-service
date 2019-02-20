import FluentPostgreSQL

struct User: PostgreSQLUUIDModel {
    
    var id: UUID?
    var username: String
}
