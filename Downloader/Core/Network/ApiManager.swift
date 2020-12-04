//
//  File.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import Alamofire

public enum ApiManager {
    case topPages
}

extension ApiManager {
    
    public var method: HTTPMethod {
        switch self {
        case .topPages:
            return .get
        }
    }
    
    public var path: String {
        
        switch self {
        case .topPages:
            return Constants.baseUrl + "/youtube-dl/top_pages.json"
        }
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .topPages:
            return nil
        }
    }
    
    var requestModel: AlamofireRequestModel {
        switch self {
        case .topPages:
            return AlamofireRequestModel(method: method, path: path, parameters: parameters)
        }
    }
}

