import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // app.http.server.configuration.hostname = "127.0.0.1"
    // app.http.server.configuration.port = 8081

    // Session
    app.middleware.use(app.sessions.middleware)
    app.sessions.use(.memory)

    // register routes
    try routes(app)
    // Nuestro WebSocket
    try webSockets(app)
}
