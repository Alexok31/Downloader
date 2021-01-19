//
//  DownloadingVideosCell.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import UIKit

class DownloadingVideosCell: UITableViewCell {

    @IBOutlet weak var previewVideo: LoadingImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var sizeVideo: UILabel!
    @IBOutlet weak var speedDownload: UILabel!
    
    var model: DownloadProcessEntity? {
        willSet(model) {
            nameLabel.text = model?.nameFile
            progressView.setProgress(Float(model?.percent ?? 0.0), animated: false)
            sizeVideo.text = model?.size
            speedDownload.text = model?.speedDownload
            if let imageLink = model?.previewImage {
                previewVideo.loadImage(by: imageLink)
            }
        }
    }
    
    override func prepareForReuse() {
        previewVideo.image = nil
        previewVideo.canceled()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        previewVideo.layer.cornerRadius = 5
    }
}
