//
//  PagesService.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import Foundation
import RxSwift

protocol PagesServiceType {
    func getTopPages(complition: @escaping (StatusServerResponse, TopPagesEntity?)->())
}

class PagesService: PagesServiceType {

    private let requestService: BaseRequestService
    
    init(requestService: BaseRequestService) {
        self.requestService = requestService
    }

    func getTopPages(complition: @escaping (StatusServerResponse, TopPagesEntity?)->()) {
        let requestModel = ApiManager.topPages.requestModel
        requestService.callWebServiceAlamofire(requestModel) { (data) in
            if let topPages = data.getDataModel(model: TopPagesEntity.self) {
                complition(.successful, topPages)
            } else {
                complition(.notResponding, nil)
            }
        } failureCode: { (response) in
            complition(response, nil)
        }

    }
    
}
