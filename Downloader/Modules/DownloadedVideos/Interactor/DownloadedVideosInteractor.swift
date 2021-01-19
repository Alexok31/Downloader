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
    func videoUrl(by name: String) -> URL
    func downloadedVideo(for indexPath: IndexPath) -> DownloadedVideosEntity? 
    var downloadedVideosCount: Int { get }
    func observeDownloadedVideos(complition: @escaping([DownloadedVideosEntity])->(), update: (([Int], [Int]) -> ())?)
    func removeObserveDownloadedVideos()
    func videoPlayer(nameVideo: String) -> PlayerViewController
    func saveVideoToGallery(nameVideo: String, success: @escaping ()->(), failure: @escaping (Error)->())
    @discardableResult func deleteVideo(for indexPath: IndexPath) -> Bool
}
 
class DownloadedVideosInteractor: DownloadedVideosInteractorType {
    
    private var dataBaseService: DataBaseServise
    
    init(dataBaseService: DataBaseServise) {
        self.dataBaseService = dataBaseService
    }
    
    var downloadedVideos: [DownloadedVideosEntity]? {
        if let resultDownloadedVideos = dataBaseService
            .fetch(object: DownloadedVideosEntity.self)?.sorted(byKeyPath: "date", ascending: false) {
            return Array(resultDownloadedVideos)
        }
        return nil
    }
    
    func downloadedVideo(for indexPath: IndexPath) -> DownloadedVideosEntity? {
        return downloadedVideos?[indexPath.row]
    }
    
    var downloadedVideosCount: Int {
        return downloadedVideos?.count ?? 0
    }
    
    func observeDownloadedVideos(complition: @escaping([DownloadedVideosEntity])->(), update: (([Int], [Int]) -> ())?) {
        guard let resultDownloadedVideos = dataBaseService
                .fetch(object: DownloadedVideosEntity.self)?.sorted(byKeyPath: "date", ascending: false) else { return }
        
        dataBaseService.addObserve(object: resultDownloadedVideos, initial: { (downloadedVideos) in
            if let downloadedVideos = downloadedVideos {
                complition(downloadedVideos)
            }
        }, update: update)
    }
    
    func removeObserveDownloadedVideos() {
        dataBaseService.removeRealmNotificationToken()
    }
    
    func videoPlayer(nameVideo: String) -> PlayerViewController {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let videoURL = documentsURL.appendingPathComponent(nameVideo)
        let player = AVPlayer(url: videoURL)
        let videoPlayer = PlayerViewController()
        videoPlayer.player = player
        return videoPlayer
    }
    
    func videoUrl(by name: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsURL.appendingPathComponent(name)
    }
    
    func saveVideoToGallery(nameVideo: String, success: @escaping ()->(), failure: @escaping (Error)->()) {
        DispatchQueue.main.async {
            let videoURL = self.videoUrl(by: nameVideo)
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
    
    @discardableResult func deleteVideo(for indexPath: IndexPath) -> Bool {
        guard let video = downloadedVideo(for: indexPath) else { return false }
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let videoURL = documentsURL.appendingPathComponent(video.name)
        do {
            try FileManager.default.removeItem(at: videoURL)
            dataBaseService.delete(object: video)
            return true
        } catch let error as NSError {
            print("Error: \(error.domain)")
            return false
        }
    }
}
