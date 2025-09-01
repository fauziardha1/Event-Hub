//
//  NetworkRequest.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//

import Foundation

/// Struct that consist all data that needed due to network request action
struct NetworkRequest {
    let url: URL
    var method: NetworkRequestMethod = .GET
    var headers: [String: String] = ["Content-Type":"application/json"]
    var body: Data?
    var requestTimeOut: TimeInterval = URLSessionConfiguration.default.timeoutIntervalForRequest
    
    init(url: URL, method: NetworkRequestMethod, body: Data? = nil) {
        self.url = url
        self.method = method
        self.body = body
    }
    
    func toDictionary() -> NSDictionary {
        return ["URL"           : url ,
                "Method"        : method.rawValue,
                "Headers"       : headers,
                "Body"          : String(data: body ?? Data(), encoding: .utf8) ?? "",
                "RequestTimeOut": requestTimeOut]
    }
}

enum NetworkRequestMethod: String {
    case GET    = "GET"
    case POST   = "POST"
    case PUT    = "PUT"
    case DELETE = "DELETE"
}
