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
    var request: URLRequest? { get }
    func getUrlVideo(from linkUrl: String?)
    func stopAllDataTasks()
    func startDownloadVideo(name: String?)
    func pauseDownload()
    func resumeDownload()
}

class BrowserInteractor: BrowserInteractorType {
    
    var videoUrl = PublishSubject<VideoUrlEntity>.init()
    var statusServer = PublishSubject<StatusServerResponse>.init()
    var urlVideoBody: VideoUrlEntity?
    var urlString = String()
    
    private var downloadControll: DownloadControll?
    private var browseService: BrowseService
    private var dispouseBag = DisposeBag()
    
    init(browseService: BrowseService) {
        self.browseService = browseService
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let downloadControll = appDelegate.downloadControll else { return }
        self.downloadControll = downloadControll
    }
    
    var request: URLRequest? {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            return URLRequest(url: url)
        } else {
            return searchInGoogleRequest(text: urlString)
        }
    }
    
    func startDownloadVideo(name: String?) {
        guard let url = urlVideoBody?.download_link, let fileExtension = urlVideoBody?.ext else {return}
        let previewImage = urlVideoBody?.poster
        let videoName = setVideoName(name: name, fileExtension: fileExtension)
        downloadControll?.startDownloadVideo(by: url, previewImage: previewImage, name: videoName)
    }
    
    func pauseDownload() {
        downloadControll?.stop()
    }
    
    func resumeDownload() {
        downloadControll?.resume()
    }
    
    func getUrlVideo(from linkUrl: String?) {
        guard let linkUrl = linkUrl else {return}
        browseService.getUrlVideo(from: linkUrl) { (statusServer, videoUrlBody) in
            guard statusServer != .reqerstCancelled else { return }
            if let videoUrlBody = videoUrlBody,
               let _ = URL(string: videoUrlBody.download_link ?? "") {
                self.urlVideoBody = videoUrlBody
                self.videoUrl.onNext(videoUrlBody)
                self.statusServer.onNext(.successful)
            } else {
                self.statusServer.onNext(.videoNotAvailable)
            }
        }
    }
    
    func stopAllDataTasks() {
        browseService.stopAllDataTasks()
    }
    
    private func setVideoName(name: String?, fileExtension: String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy_MM_dd-HHmmssSS"
        let dateString = dateFormater.string(from: Date())
        if let name = name {
            return "\(name)_\(dateString).mp4"
        }
        return "DownloaderVideo_\(dateString).\(fileExtension)"
    }
    
    private func searchInGoogleRequest(text: String) -> URLRequest? {
        guard let link = (Constants.googleSearch + text).encodeUrl,
              let url = URL(string: link), UIApplication.shared.canOpenURL(url) else { return nil }
        return URLRequest(url: url)
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
