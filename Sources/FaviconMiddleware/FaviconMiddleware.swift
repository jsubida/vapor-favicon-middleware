import Foundation
import Vapor

public final class FaviconMiddleware: Middleware {
    var iconPath: String
    var headers: HTTPHeaders
    var body: Vapor.Response.Body!
    
    // default maxAge is 1 day
    public init(_ path: String, maxAge: Int = 86400000) {
        iconPath = path
        headers = [
            "Content-Type": "image/x-icon",
            "Cache-Control": "public, max-age=\(maxAge / 1000)"
        ]
    }
    
    public func respond(to request: Vapor.Request, chainingTo next: Vapor.Responder) -> NIOCore.EventLoopFuture<Vapor.Response> {
        if request.url.path != "/favicon.ico" {
            return next.respond(to: request)
        }
        
        // Favicon is only allowed on GET, HEAD, OPTIONS
        let allowed: [Vapor.HTTPMethod] = [.GET, .HEAD]
        
        if !allowed.contains(request.method) {
            var status = Vapor.HTTPStatus.methodNotAllowed
            
            if case .OPTIONS = request.method {
                status = .ok
            }
            
            let resp = Vapor.Response(status: status, headers: ["Allow": "GET, HEAD, OPTIONS"])
            return request.eventLoop.makeSucceededFuture(resp)
        }
        
        if let body {
            let resp = Vapor.Response(status: .notModified, headers: headers, body: body)
            return request.eventLoop.makeSucceededFuture(resp)
        }
        
        guard !FileManager.default.fileExists(atPath: iconPath) else {
            return next.respond(to: request)
        }
        
        let res = request.fileio.streamFile(at: iconPath)
        return request.eventLoop.makeSucceededFuture(res)
    }
}
