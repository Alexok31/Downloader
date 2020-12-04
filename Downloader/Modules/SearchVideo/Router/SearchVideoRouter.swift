//
//  SearchVideoRouter.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import Foundation

protocol SearchVideoRouterType {
    func openBrowser(urlString: String)
}

class SearchVideoRouter: SearchVideoRouterType {
    
    weak var view: SearchVideoViewType?
    
    func openBrowser(urlString: String) {
        guard let viewCcontroller = view as? SearchVideoViewController,
              let browse = R.storyboard.main.browserViewController() else {return}
        browse.configurator = BrowserConfigurator(urlString: urlString)
        viewCcontroller.navigationController?.pushViewController(browse, animated: true)
    }
    
}
