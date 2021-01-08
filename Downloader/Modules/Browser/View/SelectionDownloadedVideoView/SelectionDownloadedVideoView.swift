//
//  SelectionDownloadedVideoView.swift
//  Downloader
//
//  Created by Alex Kharchenko on 12.12.2020.
//

import UIKit

class SelectionDownloadedVideoView: UIView {

    @IBOutlet weak var previewImageView: CustomImageView!
    @IBOutlet weak var nameVideoLabel: UILabel!
    @IBOutlet weak var sizeVideoLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    var tapToDownloadButton: (()->())?
    
    var model: VideoUrlEntity? {
        willSet(model) {
            nameVideoLabel.text = ""
            previewImageView.downloadImege(from: model?.poster)
        }
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        tapToDownloadButton?()
    }
}
