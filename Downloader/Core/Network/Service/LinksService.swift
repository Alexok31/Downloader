//
//  LinksService.swift
//  Downloader
//
//  Created by Alex Kharchenko on 08.02.2021.
//

import Foundation

class LinksService {
    
    let apiManager = APIManager<LinksApi>()
    
    func topPages(complition: @escaping(Result<TopPagesEntity?>) -> Void) {
        let service: LinksApi = .topPages
        apiManager.perform(service: service, decodeType: TopPagesEntity.self) { (result) in
            switch result {
            case .succsess(let topPages):
                complition(.succsess(topPages))
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    func getUrlVideo(pageLink: String, complition: @escaping(Result<VideoUrlEntity?>) -> Void) {
        let service: LinksApi = .getVideoUrl(pageLink)
        apiManager.perform(service: service, decodeType: VideoUrlEntity.self) { (result) in
            switch result {
            case .succsess(let videoInfo):
                complition(.succsess(videoInfo))
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    func stopAllDataTasks() {
        apiManager.stopLastDataTasks()
    }
    
}
