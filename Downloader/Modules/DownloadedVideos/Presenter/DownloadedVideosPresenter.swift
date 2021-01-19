//
//  DownloadedVideosPresenter.swift
//  Downloader
//
//  Created by Alex Kharchenko on 13.12.2020.
//

import UIKit
import AVKit

protocol DownloadedVideosPresenterType {
    func viewDidLoad()
    
}

class DownloadedVideosPresenter: NSObject, DownloadedVideosPresenterType {
    
    weak var view: DownloadedVideosViewType?
    private var interactor: DownloadedVideosInteractorType
    private var router: DownloadedVideosRouterType
    
    init(view: DownloadedVideosViewType, interactor: DownloadedVideosInteractorType, router: DownloadedVideosRouterType) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.reloadeDownloadedVideos()
        observeDownloadedVideos()
    }
    
    func observeDownloadedVideos() {
        interactor.observeDownloadedVideos { [weak self] (_) in
            self?.view?.reloadeDownloadedVideos()
        } update: { [weak self] (deletions, insertions) in
            if !deletions.isEmpty {
                self?.view?.removeTableCell(for: deletions.map({ IndexPath(row: $0, section: 0) }))
            }
            
            if !insertions.isEmpty {
                self?.view?.insertTableCell(for: insertions.map({ IndexPath(row: $0, section: 0) }))
            }
        }
    }
    
    func sharedVideo(for indexPath: IndexPath) {
        guard let nameVideo = interactor.downloadedVideo(for: indexPath)?.name else {return}
        let urlVideo = interactor.videoUrl(by: nameVideo)
        let activityItems: [Any] = [urlVideo]
        let activityController = ActivityViewController(activityItems: activityItems, applicationActivities: nil)
        router.showSharedView(activityController)
    }
    
    private func playVideo(for indexPath: IndexPath) {
        guard let nameVideo = interactor.downloadedVideo(for: indexPath)?.name else {return}
        let player = interactor.videoPlayer(nameVideo: nameVideo)
        router.showPayer(player: player)
    }
    
    private func saveVideoToGallery(for indexPath: IndexPath) {
        guard let nameVideo = interactor.downloadedVideo(for: indexPath)?.name else {return}
        interactor.saveVideoToGallery(nameVideo: nameVideo) { [weak self] in
            self?.view?.showVideoSavedAlert()
        } failure: { [weak self] (error) in
            self?.view?.showVideoSavingErrorAlert(message: error.localizedDescription)
        }
    }
    
    private func deleteVideo(for indexPath: IndexPath) {
        interactor.deleteVideo(for: indexPath)
    }
    
    deinit {
        interactor.removeObserveDownloadedVideos()
    }
    
}


extension DownloadedVideosPresenter: UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.downloadedVideosCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(DownloadedVideosCell.self, for: indexPath)
        cell.delegate = self
        cell.model = interactor.downloadedVideo(for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playVideo(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteVideo(for: indexPath)
        }
    }
    
    func tableViewCell(_ cell: UITableViewCell, buttonTapped: UIButton) {
        guard let indexPath = view?.downloadedVideosTableView.indexPath(for: cell) else { return }
        sharedVideo(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
