//
//  BaseNetworkService.swift
//  Dota2Api
//
//  Created by EVA RUSH on 10/28/19.
//

import Foundation
import Alamofire

struct AlamofireRequestModel {
    var method: HTTPMethod
    var path: String
    var header: HTTPHeaders? = nil
    var parameters: [String: Any]? = nil
    var encoding: JSONEncoding? = nil
}

typealias complitionResult<DataModel: Decodable> = (_ result: StatusServerResponse, _ dataModel: DataModel?) -> ()

class AlamofireBaseRequestService: BaseRequestService {
    
    private var request: DataRequest?
   
    func callWebServiceAlamofire(_ alamoReq: AlamofireRequestModel, success: @escaping ((_ responseData: Data) -> Void), failureCode: @escaping ((_ code: StatusServerResponse) -> Void)) {
        
        if let encoding = alamoReq.encoding {
            request = AF.request(alamoReq.path, method: alamoReq.method, parameters: alamoReq.parameters, encoding: encoding, headers: alamoReq.header)
        } else {
            request = AF.request(alamoReq.path, method: alamoReq.method, parameters: alamoReq.parameters, headers: alamoReq.header)
        }
       
        // Call response handler method of alamofire
        request?.validate(statusCode: 200..<600).responseData(completionHandler: { response in
            let statusCode = response.response?.statusCode
            switch response.result {
            case .success(let data):
                switch statusCode {
                case 200, 415:
                    success(data)
                default:
                    failureCode(.notResponding)
                }
            case .failure(let error):
                print(error.localizedDescription)
                if error.isExplicitlyCancelledError {
                    failureCode(.reqerstCancelled)
                } else {
                    NetworkHelper.shared.checkInternet(completion: { (result) in
                        failureCode(result)
                    })
                }
            }
        })
    }
    
    func stopLastDataTasks() {
        request?.cancel()
    }
}
