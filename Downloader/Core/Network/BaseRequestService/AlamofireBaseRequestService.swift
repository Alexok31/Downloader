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
    var parameters: [String: Any]? = nil
}

typealias complitionResult<DataModel: Decodable> = (_ result: StatusServerResponse, _ dataModel: DataModel?) -> ()

class AlamofireBaseRequestService: BaseRequestService {
   
    func callWebServiceAlamofire(_ alamoReq: AlamofireRequestModel, success: @escaping ((_ responseData: Data) -> Void), failureCode: @escaping ((_ code: StatusServerResponse) -> Void)) {
        
        let request = AF.request(alamoReq.path, method: alamoReq.method, parameters: alamoReq.parameters)

        // Call response handler method of alamofire
        request.validate(statusCode: 200..<600).responseData(completionHandler: { response in
            let statusCode = response.response?.statusCode
            switch response.result {
            case .success(let data):
                switch statusCode {
                case 200:
                    success(data)
                default:
                    failureCode(.notResponding)
                }
            case .failure(_):
                NetworkHelper.shared.checkInternet(completion: { (result) in
                    failureCode(result)
                })
            }
            
        })
    }
}
