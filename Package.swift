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
                .headerSearchPath("include/enc"),
                .headerSearchPath("include/enc/jis"),
                .headerSearchPath("include/enc/unicode"),
                .headerSearchPath("include/win32"),
            ]
        )
    ]
)
