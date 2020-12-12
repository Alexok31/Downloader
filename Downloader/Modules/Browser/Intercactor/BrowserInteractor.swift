//
//  BrowserInteractor.swift
//  Downloader
//
//  Created by Alex Kharchenko on 01.12.2020.
//

import RxSwift

protocol BrowserInteractorType {
    var videoUrl: PublishSubject<VideoUrlEntity> { get }
    var statusServer: PublishSubject<StatusServerResponse> { get }
    var urlVideoBody: VideoUrlEntity? { get set }
    func getUrlVideo(from request: URLRequest?)
    func startDownloadVideo()
    func pauseDownload()
    func resumeDownload()
}

class BrowserInteractor: BrowserInteractorType {
    
    var videoUrl = PublishSubject<VideoUrlEntity>.init()
    var statusServer = PublishSubject<StatusServerResponse>.init()
    var urlVideoBody: VideoUrlEntity?
    
    private var downloadControll: DownloadControll?
    private var browseService: BrowseService
    private var dispouseBag = DisposeBag()
    
    init(browseService: BrowseService) {
        self.browseService = browseService
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let downloadControll = appDelegate.downloadControll else { return }
        self.downloadControll = downloadControll
    }
    
    func startDownloadVideo() {
        guard let url = urlVideoBody?.download_link else {return}
        let previewImage = urlVideoBody?.poster
        downloadControll?.startDownloadVideo(by: url, previewImage: previewImage)
    }
    
    func pauseDownload() {
        downloadControll?.stop()
    }
    
    func resumeDownload() {
        downloadControll?.resume()
    }
    
    func getUrlVideo(from request: URLRequest?) {
        guard let url = request?.url?.absoluteString else {return}
        browseService.getUrlVideo(from: url) { (statusServer, videoUrl) in
            self.statusServer.onNext(statusServer)
            if let videoUrl = videoUrl {
                self.urlVideoBody = videoUrl
                self.videoUrl.onNext(videoUrl)
            }
        }
    }
    
}
