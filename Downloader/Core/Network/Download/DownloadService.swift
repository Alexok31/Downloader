//
//  DownloadService.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import Alamofire
import RxSwift

protocol DownloadControll {
    var updateDownloadingVideos: PublishSubject<()> { get }
    var downloadingVideos: [DownloadProcessEntity] { get }
    func startDownloadVideo(by videoUrl: String, previewImage: String?)
    func stop()
    func resume()
}

class DownloadService: DownloadControll {
    
    var updateDownloadingVideos = PublishSubject<()>.init()
    
    var downloadingVideos = [DownloadProcessEntity]()
    
    private var request: Alamofire.Request?
    
    func startDownloadVideo(by urlVideo: String, previewImage: String?) {
        guard !self.downloadingVideos.contains(where: {$0.url == urlVideo}) else { return }
        downloadVideo(by: urlVideo) {
            let video = DownloadProcessEntity(nameFile: "Video", url: urlVideo, size: "", percent: 0, speedDownload: "", urlFile: nil, previewImage: previewImage)
            self.downloadingVideos.append(video)
        } progress: { (value) in
            let video = self.downloadingVideos.filter({$0.url == urlVideo}).first
            video?.percent = value
            self.updateDownloadingVideos.onNext(())
        } complition: { (videoFileUrl, sizeVideo)   in
            let video = self.downloadingVideos.filter({$0.url == urlVideo}).first
            video?.urlFile = videoFileUrl
            video?.size = sizeVideo
            self.updateDownloadingVideos.onNext(())
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
                       complition: @escaping(URL, String)->()) {
        
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
    
    func seveAndGetVideoUrl(data: Data) -> URL? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let videoURL = documentsURL.appendingPathComponent("video.mp4")
        do {
            try data.write(to: videoURL)
            return videoURL
        } catch {
            return nil
        }
    }
}
