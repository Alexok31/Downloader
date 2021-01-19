//
//  SelectionDownloadedVideoView.swift
//  Downloader
//
//  Created by Alex Kharchenko on 12.12.2020.
//

import UIKit

class SelectionDownloadedVideoView: UIView {

    @IBOutlet weak var previewImageView: LoadingImageView!
    @IBOutlet weak var nameVideoLabel: UILabel!
    @IBOutlet weak var sizeVideoLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    var tapToDownloadButton: (()->())?
    
    var model: VideoUrlEntity? {
        willSet(model) {
            nameVideoLabel.text = ""
            previewImageView.image = nil
            if let imageLink = model?.poster {
                previewImageView.loadImage(by: imageLink)
            }
        }
    }

    @IBAction func downloadAction(_ sender: Any) {
        tapToDownloadButton?()
    }
}
