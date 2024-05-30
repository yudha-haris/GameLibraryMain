// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Favorite",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Favorite",
            targets: ["Favorite"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", .upToNextMajor(from: "10.50.1")),
        .package(url: "https://github.com/yudha-haris/GameLibraryCore", .upToNextMajor(from: "1.0.0")),
        .package(path: "../Detail"),
        .package(path: "../Home")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Favorite",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift"),
                "GameLibraryCore",
                "Detail",
                "Home"
            ]),
        .testTarget(
            name: "FavoriteTests",
            dependencies: ["Favorite"]),
    ]
)
