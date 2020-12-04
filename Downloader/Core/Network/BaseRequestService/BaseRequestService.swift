//
//  BaseRequestService.swift
//  Dota2Api
//
//  Created by EVA RUSH on 10/28/19.
//

import Foundation
import Alamofire

protocol BaseRequestService {
    func callWebServiceAlamofire(_ alamoReq: AlamofireRequestModel, success: @escaping ((_ responseData: Data) -> Void), failureCode: @escaping ((_ code: StatusServerResponse) -> Void))
}

protocol BaseParameterPatch {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any] { get }
}


extension Data {

    func getDataModel<DataModel>(model: DataModel.Type) -> DataModel? where DataModel : Decodable {
        do {
            return try JSONDecoder().decode(model, from: self)
        } catch {
            return nil
        }
    }
    
}
