//
//  File.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import Alamofire

public enum ApiManager {
    case getVideoUrl(String)
    case topPages
}

extension ApiManager {
    
    private var method: HTTPMethod {
        switch self {
        case .getVideoUrl:
            return .post
        case .topPages:
            return .get
        }
    }
    
    private var header: HTTPHeaders? {
        switch self {
        case .getVideoUrl:
            return ["Content-Type" : "application/json; charset=utf-8"]
        default:
            return nil
        }
    }
    
    private var encoding: JSONEncoding? {
        switch self {
        case .getVideoUrl:
            return JSONEncoding.default
        default:
            return nil
        }
    }
    
    private var path: String {
        switch self {
        case .getVideoUrl:
            return Constants.baseUrl + "/api/v1/link"
        case .topPages:
            return "https://generaldata-79d9b.firebaseapp.com/youtube-dl/top_pages.json"
        }
    }
    
    private var parameters: [String : Any]? {
        switch self {
        case .getVideoUrl(let url):
            return ["url": url]
        case .topPages:
            return nil
        }
    }
    
    var requestModel: AlamofireRequestModel {
        switch self {
        case .getVideoUrl(_):
            return AlamofireRequestModel(method: method, path: path, header: header, parameters: parameters, encoding: encoding)
        case .topPages:
            return AlamofireRequestModel(method: method, path: path, parameters: parameters)
        }
    }
}

