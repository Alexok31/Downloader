//
//  BrowserInteractor.swift
//  Downloader
//
//  Created by Alex Kharchenko on 01.12.2020.
//

import RxSwift

protocol BrowserInteractorType {
    var updateDownloadingVideos: PublishSubject<()>? { get }
    var downloadingVideos: [DownloadProcessEntity]? { get }
    func startDownloadVideo(by urlVideo: String)
    func pauseDownload()
    func resumeDownload()
}

class BrowserInteractor: BrowserInteractorType {
    
    var updateDownloadingVideos: PublishSubject<()>?
    
    var downloadingVideos: [DownloadProcessEntity]? {
        return downloadControll?.downloadingVideos
    }
    
    private var downloadControll: DownloadControll?
    private var dispouseBag = DisposeBag()
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let downloadControll = appDelegate.downloadControll else { return }
        self.downloadControll = downloadControll
        
        updateDownloadingVideos?.subscribe(downloadControll.updateDownloadingVideos)
            .disposed(by: dispouseBag)
    }
    
    func startDownloadVideo(by urlVideo: String) {
        downloadControll?.startDownloadVideo(by: urlVideo)
    }
    
    func pauseDownload() {
        downloadControll?.stop()
    }
    
    func resumeDownload() {
        downloadControll?.resume()
    }
    
}
