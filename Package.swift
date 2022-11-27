// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Shimmers",
    platforms: [.iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8)],
    products: [
        .library(
            name: "Shimmers",
            targets: ["Shimmers"]),
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "Shimmers",
            dependencies: []),
    ]
)
