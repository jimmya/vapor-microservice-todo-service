import Vapor

struct TodoController: RouteCollection {
    
    func boot(router: Router) throws {
        let todosRouter = router.grouped("todos").grouped(UserIdMiddleware())
    
        todosRouter.post(CreateTodoRequest.self, at: "", use: createTodo)
        todosRouter.get("", use: getTodos)
    }
}

private extension TodoController {
    
    func createTodo(_ req: Request, createRequest: CreateTodoRequest) throws -> Future<HTTPStatus> {
        let userId = try req.requireUserId()
        let todo = Todo(userId: userId, title: createRequest.title, description: createRequest.description)
        let repository = try req.make(TodoRepository.self)
        return repository.store(todo: todo, on: req).transform(to: .created)
    }
    
    func getTodos(_ req: Request) throws -> Future<[TodoResponse]> {
        let userId = try req.requireUserId()
        let repository = try req.make(TodoRepository.self)
        return repository.findAll(userId: userId, on: req).map { todos in
            return todos.compactMap { TodoResponse(todo: $0.0, user: $0.1) }
        }
    }
}
