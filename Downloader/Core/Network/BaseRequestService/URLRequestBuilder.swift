//
//  URLRequestBuilder.swift
//  Downloader
//
//  Created by Alex Kharchenko on 08.02.2021.
//

import Alamofire

protocol URLRequestBuilder: URLRequestConvertible {
    var baseUrl: String { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var mathod: HTTPMethod { get }
}

// MARK: - Default realisation
extension URLRequestBuilder {
    var baseUrl: String {
        return "https://gethisvideo.com/api/v1"
    }
    
    var baseHeader: HTTPHeaders {
        var headers = HTTPHeaders.init()
        headers.add(.contentType("application/json; charset=utf-8"))
        return headers
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = mathod.rawValue
        request.headers = baseHeader
        switch mathod {
        case .get:
            request = try URLEncoding.default.encode(request, with: parameters)
        default:
            request = try JSONEncoding.default.encode(request, with: parameters)
        }
        return request
    }
}

