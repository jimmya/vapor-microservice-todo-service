import Vapor

struct CreateTodoRequest: Content {
    
    let title: String
    let description: String?
}
