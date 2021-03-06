// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "todo-service",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/fluent-postgresql.git", from: "1.0.0"),
        .package(url: "https://github.com/vapor-community/vapor-ext.git", from: "0.3.0"),
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentPostgreSQL", "JWT", "Vapor", "ServiceExt"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
