//
//  DownloadService.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import Alamofire
import RxSwift
import AVFoundation

protocol DownloadControll {
    var updateDownloadingVideos: PublishSubject<()> { get }
    var fileDownloadComplete: PublishSubject<DownloadProcessEntity> { get }
    var downloadingVideos: [DownloadProcessEntity] { get }
    func startDownloadVideo(by urlVideo: String, previewImage: String?, name: String)
    func stop()
    func resume()
}

class DownloadService: DownloadControll {
    
    var updateDownloadingVideos = PublishSubject<()>.init()
    var fileDownloadComplete = PublishSubject<DownloadProcessEntity>.init()
    
    var downloadingVideos = [DownloadProcessEntity]()
    
    private var request: Alamofire.Request?
    
    func startDownloadVideo(by urlVideo: String, previewImage: String?, name: String) {
        guard !self.downloadingVideos.contains(where: {$0.nameFile == name}) else { return }
        downloadVideo(by: urlVideo, name: name) {
            let video = DownloadProcessEntity(nameFile: name, urlLink: urlVideo, size: "", percent: 0, speedDownload: "", urlFile: "", previewImage: previewImage)
            self.downloadingVideos.append(video)
        } progress: { (value) in
            if let video = self.downloadingVideos.filter({$0.nameFile == name}).first {
                video.percent = value
                self.updateDownloadingVideos.onNext(())
            }
        } complition: { (videoFileUrl, sizeVideo)   in
            if let video = self.downloadingVideos.filter({$0.nameFile == name}).first {
                video.urlFile = videoFileUrl
                video.size = sizeVideo
                self.fileDownloadComplete.onNext(video)
            }
        }
    }
    
    func stop() {
        request?.suspend()
    }
    
    func resume() {
        request?.resume()
    }
    
    private func downloadVideo(by videoUrl: String, name: String,
                       start: @escaping()->(),
                       progress: @escaping(Double)->(),
                       complition: @escaping(String, String)->()) {
        
        start()
        request = AF.request(videoUrl).downloadProgress(closure: { (progressDownload) in
            progress(progressDownload.fractionCompleted)
        }).responseData{ (response) in
            if let data = try? response.result.get(),
               let urlVideoFile = self.seveAndGetVideoUrl(name: name, data: data) {

                let size = data.getSizeInMB()
                complition(urlVideoFile, size)
            }
        }
    }
    
    func seveAndGetVideoUrl(name: String, data: Data) -> String? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let videoURL = documentsURL.appendingPathComponent(name)
        do {
            try data.write(to: videoURL)
            return videoURL.absoluteString
        } catch {
            return nil
        }
    }
}
