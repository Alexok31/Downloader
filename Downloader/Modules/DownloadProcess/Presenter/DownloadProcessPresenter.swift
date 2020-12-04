//
//  DownloadProcessPresenter.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import UIKit

protocol DownloadProcessPresenterType: UITableViewDelegate, UITableViewDataSource {
    
}

class DownloadProcessPresenter: NSObject, DownloadProcessPresenterType {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(DownloadingVideosCell.self, for: indexPath)
        return cell
    }
    
    
}
