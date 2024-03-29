//
//  DownloadedVideosVC.swift
//  Downloader
//
//  Created by Alex Kharchenko on 13.12.2020.
//

import UIKit

protocol DownloadedVideosViewType: class {
    var downloadedVideosTableView: UITableView! {get}
    func reloadeDownloadedVideos()
    func removeTableCell(for indexPaths: [IndexPath])
    func insertTableCell(for indexPaths: [IndexPath])
    func showVideoSavedAlert()
    func showVideoSavingErrorAlert(message: String)
}

class DownloadedVideosViewController: UIViewController, DownloadedVideosViewType {
    
    @IBOutlet weak var downloadedVideosTableView: UITableView!
    
    var configurator: DownloadedVideosConfiguratorType = DownloadedVideosConfigurator()
    var presenter: DownloadedVideosPresenterType?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        configUI()
        presenter?.viewDidLoad()
    }
    
    func configUI() {
        title = "Download"
        downloadedVideosTableView.registerWithNib(cellClass: DownloadedVideosCell.self)
    }
    
    func reloadeDownloadedVideos() {
        downloadedVideosTableView.reloadData()
    }
    
    func insertTableCell(for indexPaths: [IndexPath]) {
        downloadedVideosTableView.insertRows(at: indexPaths, with: .middle)
    }
    
    func removeTableCell(for indexPaths: [IndexPath]) {
        downloadedVideosTableView.deleteRows(at: indexPaths, with: .left)
    }
    
    func showVideoSavedAlert() {
        DispatchQueue.main.async { [weak self] in
            self?.present(.alertMessage(title: "Done!", message: "Your video was successfully saved"), animated: true)
        }
    }
    
    func showVideoSavingErrorAlert(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.present(.alertMessage(title: "Failure", message: message), animated: true)
        }
    }
}
