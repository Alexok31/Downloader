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
    func startDownloadVideo(name: String?)
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
    
    func startDownloadVideo(name: String?) {
        guard let url = urlVideoBody?.download_link else {return}
        let previewImage = urlVideoBody?.poster
        let videoName = setVideoName(name: name)
        downloadControll?.startDownloadVideo(by: url, previewImage: previewImage, name: videoName)
    }
    
    func pauseDownload() {
        downloadControll?.stop()
    }
    
    func resumeDownload() {
        downloadControll?.resume()
    }
    
    func getUrlVideo(from request: URLRequest?) {
        guard let url = request?.url?.absoluteString else {return}
        browseService.getUrlVideo(from: url) { (statusServer, videoUrlBody) in
            self.statusServer.onNext(statusServer)
            if let videoUrlBody = videoUrlBody, let url = URL(string: videoUrlBody.download_link) {
                self.urlVideoBody = videoUrlBody
                self.videoUrl.onNext(videoUrlBody)
            }
        }
    }
    
    private func setVideoName(name: String?) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy_MM_dd-HHmmssSS"
        let dateString = dateFormater.string(from: Date())
        if let name = name {
            return "\(name)_\(dateString).mp4"
        }
        return "DownloaderVideo_\(dateString).mp4"
    }
    
}

import AVFoundation

extension AVURLAsset {
    var fileSize: Int? {
        let keys: Set<URLResourceKey> = [.totalFileSizeKey, .fileSizeKey]
        let resourceValues = try? url.resourceValues(forKeys: keys)

        return resourceValues?.fileSize ?? resourceValues?.totalFileSize
    }
}
