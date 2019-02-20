import FluentPostgreSQL
import Vapor

struct Todo {
    
    var id: UUID?
    var userId: User.ID
    var title: String
    var description: String?
    
    init(id: UUID? = nil, userId: User.ID, title: String, description: String?) {
        self.id = id
        self.userId = userId
        self.title = title
        self.description = description
    }
}

extension Todo: PostgreSQLUUIDModel { }
extension Todo: Migration { }
