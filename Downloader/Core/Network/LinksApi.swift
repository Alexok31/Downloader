//
//  LinksApi.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import Alamofire

public enum LinksApi: URLRequestBuilder {
    case getVideoUrl(String)
    case topPages
}

extension LinksApi {
    var mathod: HTTPMethod {
        switch self {
        case .getVideoUrl:
            return .post
        case .topPages:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        baseHeader
    }
    
    var encoding: JSONEncoding? {
        switch self {
        case .getVideoUrl:
            return JSONEncoding.default
        default:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .getVideoUrl:
            return  "/link"
        case .topPages:
            return "/default_websites"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getVideoUrl(let url):
            return ["url": url]
        case .topPages:
            return nil
        }
    }
    
}

