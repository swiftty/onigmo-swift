// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "onigmo-swift",
    products: [
        .library(
            name: "COnigmo",
            targets: ["COnigmo"]
        )
    ],
    targets: [
        .target(
            name: "COnigmo",
            cSettings: [
                .headerSearchPath("src"),
                .headerSearchPath("src/enc/jis"),
                .headerSearchPath("src/enc/unicode"),
            ]
        ),
        .testTarget(
            name: "COnigmoTests",
            dependencies: [
                "COnigmo"
            ]
        )
    ]
)
