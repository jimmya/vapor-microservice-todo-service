import Vapor

public func middlewares(config: inout MiddlewareConfig) throws {
    config.use(CORSMiddleware())
    config.use(ErrorMiddleware.self)
}
