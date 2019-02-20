import Vapor

struct UserResponse: Content {
    
    let id: UUID
    let username: String
}
