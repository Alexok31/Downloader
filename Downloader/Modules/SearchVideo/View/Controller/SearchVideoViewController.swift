//
//  ViewController.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import UIKit

protocol SearchVideoViewType: class {
    func reloadTopPages()
    func updateTopPagesHeigth()
}

final class SearchVideoViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topPageCollectioView: UICollectionView!
    @IBOutlet weak var topPageHeigth: NSLayoutConstraint!
    
    private var configurator: SearchVideoConfiguratorType = SearchVideoConfigurator()
    var presenter: SearchVideoPresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurUI()
        configurator.configure(viewController: self)
        presenter?.viewDidLoad()
    }
   
    func configurUI() {
        topPageCollectioView.registerWithNib(cellClass: TopPageCell.self)
    }
    
    @IBAction func howToDownloadAction(_ sender: Any) {
        presenter?.howToDownloadAction()
    }
    
}

extension SearchVideoViewController: SearchVideoViewType {
    
    func updateTopPagesHeigth() {
        topPageHeigth.constant = topPageCollectioView.contentSize.height
    }
    
    func reloadTopPages() {
        topPageCollectioView.reloadData()
    }
}

