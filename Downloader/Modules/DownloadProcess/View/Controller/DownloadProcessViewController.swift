//
//  DownloadProcessViewController.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import UIKit

protocol DownloadProcessViewType {
    func reloadTableView()
    func reloadCell()
}

class DownloadProcessViewController: UIViewController {
    
    @IBOutlet weak var downloadingVideosTableView: UITableView!
    
    private var configurator: DownloadProcessConfiguratorType = DownloadProcessConfigurator()
    var presenter: DownloadProcessPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        configUI()
    }
    
    func configUI() {
        downloadingVideosTableView.registerWithNib(cellClass: DownloadingVideosCell.self)
    }
}

extension DownloadProcessViewController: DownloadProcessViewType {
    
    func reloadTableView() {
        downloadingVideosTableView.reloadData()
    }
    
    func reloadCell() {
        //downloadingVideosTableView.reloadRows(at: T##[IndexPath], with: T##UITableView.RowAnimation)
    }
    
    
}
