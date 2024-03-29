//
//  DownloadProcessPresenter.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import UIKit
import RxSwift

protocol DownloadProcessPresenterType: UITableViewDelegate, UITableViewDataSource {
    func viewDidLoad()
    
}

class DownloadProcessPresenter: NSObject, DownloadProcessPresenterType {
    
    weak var view: DownloadProcessViewType?
    var interactor: DownloadProcessInteractorType
    
    private var disposeBag = DisposeBag()
    
    init(interactor: DownloadProcessInteractorType, view: DownloadProcessViewType) {
        self.interactor = interactor
        self.view = view
        super.init()
        observeUpdateDownloadingFiles()
        observeFileDownloadComplete()
    }
    
    func viewDidLoad() {
        resetBadge()
    }
    
    private func resetBadge() {
        let viewController = view as? UIViewController
        viewController?.tabBarController?.viewControllers?[1].tabBarItem.badgeValue = nil
    }
    
    private func observeUpdateDownloadingFiles() {
        interactor.updateDownloadingFiles.subscribe { [weak self] (_) in
            self?.view?.reloadTableView()
        }.disposed(by: disposeBag)
    }
    
    private func observeFileDownloadComplete() {
        interactor.fileDownloadComplete.subscribe { [weak self] (_) in
            self?.view?.reloadTableView()
            self?.resetBadge()
        }.disposed(by: disposeBag)
    }
}

extension DownloadProcessPresenter {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.downloadingFilesCounts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(DownloadingVideosCell.self, for: indexPath)
        cell.model = interactor.downloadingFiles?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
