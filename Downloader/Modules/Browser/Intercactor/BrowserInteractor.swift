//
//  BrowserInteractor.swift
//  Downloader
//
//  Created by Alex Kharchenko on 01.12.2020.
//

import RxSwift

protocol BrowserInteractorType {
    var downloadingVideos: PublishSubject<[DownloadProcessEntity]> { get }
    func startDownloadVideo(by urlVideo: String)
    func pauseDownload()
    func resumeDownload()
}

class BrowserInteractor: BrowserInteractorType {
    
    var downloadingVideos = PublishSubject<[DownloadProcessEntity]>.init()
    
    private var _downloadingVideos = [DownloadProcessEntity]() {
        willSet(videos) {
            downloadingVideos.onNext(videos)
        }
    }
    
    private var downloadService: DownloadControll
    
    init(downloadService: DownloadControll) {
        self.downloadService = downloadService
    }
    
    func startDownloadVideo(by urlVideo: String) {
        downloadService.downloadVideo(by: urlVideo) {
            let video = DownloadProcessEntity(nameFile: "Video", url: urlVideo, size: 0, percent: 0, urlFile: nil)
            self._downloadingVideos.append(video)
        } progress: { (value) in
            print(value)
            var video = self._downloadingVideos.filter({$0.url == urlVideo}).first
            video?.percent = value
        } complition: { (fileUrl) in
            var video = self._downloadingVideos.filter({$0.url == urlVideo}).first
            video?.urlFile = fileUrl
        }
    }
    
    func pauseDownload() {
        downloadService.stop()
    }
    
    func resumeDownload() {
        downloadService.resume()
    }
    
}
