//
//  APIManager.swift
//  Dota2Api
//
//  Created by Alex on 10/28/19.
//

import Alamofire

class APIManager<T: URLRequestBuilder> {
    
    private var request: DataRequest?
    
    func perform<U: Decodable>(service: T, decodeType: U.Type, completion: @escaping(Result<U>) -> Void) {
        request = AF.request(service).responseDecodable(of: U.self) { (response) in
            switch response.result {
            case .success(let result):
                completion(.succsess(result))
            case .failure(let error):
                completion(.failure(self.errorHandling(error: error)))
            }
        }
    }
    
    func stopLastDataTasks() {
        request?.cancel()
    }
}

// MARK: - Private Methods
extension APIManager {
    var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func errorHandling(error: AFError) -> ResponseError {
        if error.isExplicitlyCancelledError {
            return .reqerstCancelled
        }
        return isConnectedToInternet ? .notResponding : .noInternetConnection
    }
}


import Foundation

enum Result<T: Decodable> {
    case succsess(T)
    case failure(ResponseError)
}

enum ResponseError: Error {
    case videoNotAvailable
    case reqerstCancelled
    case notResponding
    case noInternetConnection
    case empty
}
