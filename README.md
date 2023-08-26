# Vapor Favicon Middleware

![Swift](http://img.shields.io/badge/swift-3.0-brightgreen.svg)
![Platforms](https://img.shields.io/badge/platforms-Linux%20%7C%20OS%20X-blue.svg)
![Package Managers](https://img.shields.io/badge/package%20managers-SwiftPM-yellow.svg)

> Favicon serving middleware for [Vapor](https://vapor.codes).

## Installation

Via Swift Package Manager:

```swift
.package(url: "https://github.com/jsubida/vapor-favicon-middleware.git", from: "1.0.0"),
```

## Why?

[Favicon](https://en.wikipedia.org/wiki/Favicon) is a visual cue that client software, like browsers, use to identify a site. So why to use this module?

- it caches the icon in memory to improve performance by skipping disk access
- it will serve with the most compatible `Content-Type`

## Usage

```swift
import Vapor
import VaporFaviconMiddleware

// configures your application
public func configure(_ app: Application) throws {
    // serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.http.server.configuration.port = 8081
    
    // favicon
    let path = app.directory.publicDirectory.appending("/Public/assets/favicon.ico")
    app.middleware.use(FaviconMiddleware(path))
    
    // register routes
    try routes(app)
}
```

---

**MIT Licensed**
