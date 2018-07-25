// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UniBar",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-Python.git",
                 from: "3.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "UniBar",
            dependencies: ["PerfectPython"]),
        .testTarget(
            name: "UniBarTests",
            dependencies: ["UniBar"]),
    ]
)
