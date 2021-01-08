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
    var fileDownloadComplete: PublishSubject<()> { get }
    var downloadingFilesCounts: Int { get }
    func pauseDownload()
    func resumeDownload()
}

class DownloadProcessInteractor: DownloadProcessInteractorType {
    
    var updateDownloadingFiles = PublishSubject<()>.init()
    var fileDownloadComplete = PublishSubject<()>.init()
    
    var downloadingFiles: [DownloadProcessEntity]? {
        return downloadControll?.downloadingVideos
    }
    
    var downloadingFilesCounts: Int {
        return downloadingFiles?.count ?? 0
    }
    
    private var downloadControll: DownloadControll?
    private var dataBaseService: DataBaseServise
    private var disposeBag = DisposeBag()
    
    init(dataBaseService: DataBaseServise) {
        self.dataBaseService = dataBaseService
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.downloadControll = appDelegate?.downloadControll
        observeDownloadingVideos()
        obseveFileDownloadComplete()
    }
    
    func observeDownloadingVideos() {
        downloadControll?.updateDownloadingVideos.subscribe(updateDownloadingFiles)
            .disposed(by: disposeBag)
    }
    
    func startDownloadVideo(by urlVideo: String, previewImage: String, name: String) {
        downloadControll?.startDownloadVideo(by: urlVideo, previewImage: previewImage, name: name)
    }
    
    func pauseDownload() {
        downloadControll?.stop()
    }
    
    func resumeDownload() {
        downloadControll?.resume()
    }
    
    private func obseveFileDownloadComplete() {
        downloadControll?.fileDownloadComplete.subscribe(fileDownloadComplete)
            .disposed(by: disposeBag)
    }
}
