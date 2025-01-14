// swift-tools-version:5.6
import PackageDescription

let package = Package(
  name: "favicon-middleware",
  platforms: [
    .macOS(.v12),
  ],
  products: [
    .library(name: "FaviconMiddleware", targets: ["FaviconMiddleware"])
  ],
  dependencies: [
    // 💧 A server-side Swift web framework.
    .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
  ],
  targets: [
    .target(name: "FaviconMiddleware", dependencies: [
        .product(name: "Vapor", package: "vapor"),
    ])
  ]
)
