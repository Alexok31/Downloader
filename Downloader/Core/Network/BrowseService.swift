//
//  BrowseService.swift
//  Downloader
//
//  Created by Alex Kharchenko on 07.12.2020.
//

import Foundation

protocol BrowseServiceType {
    func getUrlVideo(from pageurl: String, complition: @escaping (StatusServerResponse, VideoUrlEntity?)->())
    func stopAllDataTasks()
}

class BrowseService: BrowseServiceType {
    
    private let requestService: BaseRequestService
    
    init(requestService: BaseRequestService) {
        self.requestService = requestService
    }
    
    func getUrlVideo(from pageurl: String, complition: @escaping (StatusServerResponse, VideoUrlEntity?)->()) {
        let requestModel = ApiManager.getVideoUrl(pageurl).requestModel
        requestService.callWebServiceAlamofire(requestModel) { (data) in
            if let videoUrl = data.getDataModel(model: VideoUrlEntity.self) {
                complition(.successful, videoUrl)
            } else {
                complition(.notResponding, nil)
            }
        } failureCode: { (statusServer) in
            complition(statusServer, nil)
        }
    }
    
    func stopAllDataTasks() {
        requestService.stopLastDataTasks()
    }
    
}
