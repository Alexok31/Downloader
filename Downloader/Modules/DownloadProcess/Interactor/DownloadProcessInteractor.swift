//
//  DownloadProcessInteractor.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import RxSwift

protocol DownloadProcessInteractorType {
    var downloadingFiles: [DownloadProcessEntity]? { get }
    var updateDownloadingFiles: PublishSubject<()> { get }
    var downloadingFilesCounts: Int { get }
    func pauseDownload()
    func resumeDownload()
}

class DownloadProcessInteractor: DownloadProcessInteractorType {
    
    var updateDownloadingFiles = PublishSubject<()>.init()
    
    var downloadingFiles: [DownloadProcessEntity]? {
        return downloadControll?.downloadingVideos
    }
    
    var downloadingFilesCounts: Int {
        return downloadingFiles?.count ?? 0
    }
    
    private var downloadControll: DownloadControll?
    private var disposeBag = DisposeBag()
    
    init() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.downloadControll = appDelegate?.downloadControll
        observeDownloadingVideos()
    }
    
    func observeDownloadingVideos() {
        downloadControll?.updateDownloadingVideos.subscribe(updateDownloadingFiles)
            .disposed(by: disposeBag)
    }
    
    func startDownloadVideo(by urlVideo: String, previewImage: String) {
        downloadControll?.startDownloadVideo(by: urlVideo, previewImage: previewImage)
    }
    
    func pauseDownload() {
        downloadControll?.stop()
    }
    
    func resumeDownload() {
        downloadControll?.resume()
    }
}
