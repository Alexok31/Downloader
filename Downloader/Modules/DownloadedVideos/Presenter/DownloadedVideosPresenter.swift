//
//  DownloadedVideosPresenter.swift
//  Downloader
//
//  Created by Alex Kharchenko on 13.12.2020.
//

import UIKit

protocol DownloadedVideosPresenterType {
    func viewDidLoad()
    
}

class DownloadedVideosPresenter: NSObject, DownloadedVideosPresenterType {
    
    weak var view: DownloadedVideosViewType?
    private var interactor: DownloadedVideosInteractorType
    
    init(interactor: DownloadedVideosInteractorType) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.reloadeDownloadedVideos()
        observeDownloadedVideos()
    }
    
    func observeDownloadedVideos() {
        interactor.observeDownloadedVideos { [weak self] (_) in
            self?.view?.reloadeDownloadedVideos()
        }
    }
    
    private func saveVideoToGallery(nameVideo: String) {
        interactor.saveVideoToGallery(nameVideo: nameVideo) { [weak self] in
            self?.view?.showVideoSavedAlert()
        } failure: { [weak self] (error) in
            self?.view?.showVideoSavingErrorAlert(message: error.localizedDescription)
        }
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
    
    func tableViewCell(_ cell: UITableViewCell, buttonTapped: UIButton) {
        guard let indexPath = view?.downloadedVideosTableView.indexPath(for: cell),
              let name = interactor.downloadedVideo(for: indexPath)?.name else {return}
        saveVideoToGallery(nameVideo: name)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
