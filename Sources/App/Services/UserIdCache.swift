import Vapor

final class UserIdCache: Service {
    
    var userId: UUID?
}

extension Request {
    
    public func setUserId(uuid: UUID) throws {
        let cache = try privateContainer.make(UserIdCache.self)
        cache.userId = uuid
    }
    
    public func requireUserId() throws -> UUID {
        let cache = try privateContainer.make(UserIdCache.self)
        guard let userId = cache.userId else {
            throw Abort(.unauthorized)
        }
        return userId
    }
}
