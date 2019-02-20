import Vapor
import FluentPostgreSQL

protocol TodoRepository: ServiceType {
    func store(todo: Todo, on connectable: DatabaseConnectable) -> Future<Todo>
    func findAll(userId: User.ID, on connectable: DatabaseConnectable) -> Future<[(Todo, User)]>
    func find(id: UUID, on connectable: DatabaseConnectable) -> Future<Todo?>
}

final class PostgreTodoRepository: TodoRepository {
    
    let database: PostgreSQLDatabase.ConnectionPool
    
    init(_ database: PostgreSQLDatabase.ConnectionPool) {
        self.database = database
    }
    
    func store(todo: Todo, on connectable: DatabaseConnectable) -> EventLoopFuture<Todo> {
        return todo.save(on: connectable)
    }
    
    func findAll(userId: User.ID, on connectable: DatabaseConnectable) -> EventLoopFuture<[(Todo, User)]> {
        return Todo.query(on: connectable).filter(\.userId == userId).join(\User.id, to: \Todo.userId).alsoDecode(User.self).all()
    }
    
    func find(id: UUID, on connectable: DatabaseConnectable) -> Future<Todo?> {
        fatalError()
    }
}

//MARK: - ServiceType conformance
extension PostgreTodoRepository {
    static let serviceSupports: [Any.Type] = [TodoRepository.self]
    
    static func makeService(for worker: Container) throws -> Self {
        return .init(try worker.connectionPool(to: .psql))
    }
}

extension Database {
    public typealias ConnectionPool = DatabaseConnectionPool<ConfiguredDatabase<Self>>
}
