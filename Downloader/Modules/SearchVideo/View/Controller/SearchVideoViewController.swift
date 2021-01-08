//
//  ViewController.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import UIKit

final class SearchVideoViewController: UIViewController {

    @IBOutlet weak var scrollView: CustomScrollView!
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
    
    override func viewWillLayoutSubviews() {
        updateTopPagesHeigth()
    }
   
    func configurUI() {
        title = "Search"
        topPageCollectioView.registerWithNib(cellClass: TopPageCell.self)
        setDidTapCpmplition()
    }
    
    func setDidTapCpmplition() {
        scrollView.didTap = { [weak self] in
            self?.view.endEditing(true)
        }
    }
    
    @IBAction func howToDownloadAction(_ sender: Any) {
        presenter?.howToDownloadAction()
    }
    
}

extension SearchVideoViewController: SearchVideoViewType {
    
    func updateTopPagesHeigth() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else {return}
            self.topPageHeigth.constant = self.topPageCollectioView.contentSize.height
        }
        
    }
    
    func reloadTopPages() {
        DispatchQueue.main.async {
            self.topPageCollectioView.reloadData()
        }
    }
}

