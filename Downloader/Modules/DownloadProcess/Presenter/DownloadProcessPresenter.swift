//
//  DownloadProcessPresenter.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import UIKit
import RxSwift

protocol DownloadProcessPresenterType: UITableViewDelegate, UITableViewDataSource {
    
    
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
    }
    
    func observeUpdateDownloadingFiles() {
        interactor.updateDownloadingFiles.subscribe { (_) in
            self.view?.reloadTableView()
        }.disposed(by: disposeBag)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.downloadingFilesCounts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(DownloadingVideosCell.self, for: indexPath)
        cell.model = interactor.downloadingFiles?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
