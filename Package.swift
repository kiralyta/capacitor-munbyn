// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorMunbyn",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CapacitorMunbyn",
            targets: ["CapacitorMunbynPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "CapacitorMunbynPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/CapacitorMunbynPlugin"),
        .testTarget(
            name: "CapacitorMunbynPluginTests",
            dependencies: ["CapacitorMunbynPlugin"],
            path: "ios/Tests/CapacitorMunbynPluginTests")
    ]
)