//
//  NetworkHelper.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import Foundation
import Alamofire

class NetworkHelper {
    
    static let shared = NetworkHelper()
    private init() {}
    
    var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func checkInternet(completion: @escaping (_ result: StatusServerResponse) -> ()) {
        if isConnectedToInternet {
            completion(.notResponding)
        } else {
            completion(.noInternetConnection)
        }
    }
    
    func openURl(_ url: String) {
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
