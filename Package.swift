// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Game",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Game",
            targets: ["Game"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
      .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", from: "10.5.1"),
      .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.1")),
      .package(name: "Core", url: "https://github.com/muhyidinamin/Core", from: "1.0.0"),
      .package(name: "Genre", url: "https://github.com/muhyidinamin/Genre", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Game",
            dependencies: [
              .product(name: "RealmSwift", package: "Realm"),
              "Core",
              "Genre",
              "Alamofire"
            ]),
        .testTarget(
            name: "GameTests",
            dependencies: ["Game"]),
    ]
)
