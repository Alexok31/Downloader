//
//  SearchVideoPresenter.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import UIKit

class SearchVideoPresenter: NSObject, SearchVideoPresenterType {
    
    var interactor: SearchVideoInteractorType
    var router: SearchVideoRouterType
    weak var view: SearchVideoViewType?
    
    init(view: SearchVideoViewType, interactor: SearchVideoInteractorType, router: SearchVideoRouterType) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        observeTopPages()
        updateTopPages()
    }
    
    func updateTopPages() {
        interactor.updateTopPages()
    }
    
    func observeTopPages() {
        interactor.observeTopPages { [weak self] (topPages) in
            self?.view?.reloadTopPages()
        }
    }
    
    func howToDownloadAction() {
        
    }
    
    deinit {
        interactor.removeObserve()
    }
    
}

extension SearchVideoPresenter: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.topPagesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(TopPageCell.self, for: indexPath)
        cell.modelInfo = interactor.topPageInfo(for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let urlLink = interactor.tapToTopPageLink(for: indexPath) else {return}
        router.openBrowser(urlString: urlLink)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4 - 60 / 2
        let height = width + 50 - 18 - 18
        return CGSize(width: width, height: height)
    }
    
}

extension SearchVideoPresenter: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let urlLink = searchBar.text else {return}
        router.openBrowser(urlString: urlLink)
    }
}
