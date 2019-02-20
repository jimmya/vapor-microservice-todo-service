import Vapor
import JWT

struct UserIdMiddleware: Middleware {
    
    func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        guard let token = request.http.headers.bearerAuthorization?.token.data(using: .utf8) else { throw Abort(.unauthorized) }
        let authorizationPayload = try JWT<JWTAuthorizationPayload>(unverifiedFrom: token)
        let userId = authorizationPayload.payload.sub.value
        guard let uuid = UUID(userId) else { throw Abort(.unauthorized) }
        try request.setUserId(uuid: uuid)
        return try next.respond(to: request)
    }
}
