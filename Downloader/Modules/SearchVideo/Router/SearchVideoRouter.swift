//
//  SearchVideoRouter.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import Foundation

class SearchVideoRouter: SearchVideoRouterType {
    
    weak var view: SearchVideoViewType?
    
    init(view: SearchVideoViewType) {
        self.view = view
    }
    
    func openBrowser(urlString: String) {
        guard let viewController = view as? SearchVideoViewController,
              let browse = R.storyboard.main.browserViewController() else {return}
        browse.configurator = BrowserConfigurator(urlString: urlString)
        viewController.navigationController?.pushViewController(browse, animated: true)
    }
    
}
