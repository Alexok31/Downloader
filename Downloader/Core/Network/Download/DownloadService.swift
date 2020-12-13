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
    func startDownloadVideo(by videoUrl: String, previewImage: String?)
    func stop()
    func resume()
}

class DownloadService: DownloadControll {
    
    var updateDownloadingVideos = PublishSubject<()>.init()
    var fileDownloadComplete = PublishSubject<DownloadProcessEntity>.init()
    
    var downloadingVideos = [DownloadProcessEntity]()
    
    private var request: Alamofire.Request?
    
    func startDownloadVideo(by urlVideo: String, previewImage: String?) {
        guard !self.downloadingVideos.contains(where: {$0.urlLink == urlVideo}) else { return }
        downloadVideo(by: urlVideo) {
            let video = DownloadProcessEntity(nameFile: "Video", urlLink: urlVideo, size: "", percent: 0, speedDownload: "", urlFile: "", previewImage: previewImage)
            self.downloadingVideos.append(video)
        } progress: { (value) in
            if let video = self.downloadingVideos.filter({$0.urlLink == urlVideo}).first {
                video.percent = value
                self.updateDownloadingVideos.onNext(())
            }
        } complition: { (videoFileUrl, sizeVideo)   in
            if let video = self.downloadingVideos.filter({$0.urlLink == urlVideo}).first {
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
    
    private func downloadVideo(by videoUrl: String,
                       start: @escaping()->(),
                       progress: @escaping(Double)->(),
                       complition: @escaping(String, String)->()) {
        
        start()
        request = AF.request(videoUrl).downloadProgress(closure: { (progressDownload) in
            progress(progressDownload.fractionCompleted)
        }).responseData{ (response) in
            if let data = try? response.result.get(),
               let urlVideoFile = self.seveAndGetVideoUrl(data: data) {

                let size = data.getSizeInMB()
                complition(urlVideoFile, size)
            }
        }
    }
    
    func seveAndGetVideoUrl(data: Data) -> String? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let videoURL = documentsURL.appendingPathComponent("video.mp4")
        do {
            try data.write(to: videoURL)
            return videoURL.absoluteString
        } catch {
            return nil
        }
    }
}
