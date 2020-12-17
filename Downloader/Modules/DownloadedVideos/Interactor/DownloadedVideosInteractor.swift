//
//  DownloadedVideosInteractor.swift
//  Downloader
//
//  Created by Alex Kharchenko on 13.12.2020.
//

import Foundation
import Photos

protocol DownloadedVideosInteractorType {
    var downloadedVideos: [DownloadedVideosEntity]? { get }
    func downloadedVideo(for indexPath: IndexPath) -> DownloadedVideosEntity? 
    var downloadedVideosCount: Int { get }
    func observeDownloadedVideos(complition: @escaping([DownloadedVideosEntity])->())
    func removeObserveDownloadedVideos()
    func saveVideoToGallery(nameVideo: String, success: @escaping ()->(), failure: @escaping (Error)->())
}
 
class DownloadedVideosInteractor: DownloadedVideosInteractorType {
    
    private var dataBaseService: DataBaseServise
    
    init(dataBaseService: DataBaseServise) {
        self.dataBaseService = dataBaseService
    }
    
    var downloadedVideos: [DownloadedVideosEntity]? {
        return dataBaseService.fetch(object: DownloadedVideosEntity.self)
    }
    
    func downloadedVideo(for indexPath: IndexPath) -> DownloadedVideosEntity? {
        return downloadedVideos?[indexPath.row]
    }
    
    var downloadedVideosCount: Int {
        return downloadedVideos?.count ?? 0
    }
    
    func observeDownloadedVideos(complition: @escaping([DownloadedVideosEntity])->()) {
        dataBaseService.addObserve(object: DownloadedVideosEntity.self) { (downloadedVideos) in
            if let downloadedVideos = downloadedVideos {
                complition(downloadedVideos)
            }
        }
    }
    
    func removeObserveDownloadedVideos() {
        dataBaseService.removeRealmNotificationToken()
    }
    
    func saveVideoToGallery(nameVideo: String, success: @escaping ()->(), failure: @escaping (Error)->()) {
        
        DispatchQueue.main.async {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let videoURL = documentsURL.appendingPathComponent(nameVideo)
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
            }) { saved, error in
                if let error = error {
                    failure(error)
                } else if saved {
                    success()
                }
            }
        }
    }
    
}
