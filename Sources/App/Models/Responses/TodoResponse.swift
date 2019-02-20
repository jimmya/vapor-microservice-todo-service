import Vapor

struct TodoResponse: Content {
    
    let id: UUID
    let title: String
    let description: String?
    let user: UserResponse
    
    init?(todo: Todo, user: User) {
        guard let todoId = todo.id, let userId = user.id else { return nil }
        self.id = todoId
        self.title = todo.title
        self.description = todo.description
        self.user = UserResponse(id: userId, username: user.username)
    }
}
