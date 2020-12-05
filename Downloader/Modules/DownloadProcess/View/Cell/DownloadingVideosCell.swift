//
//  DownloadingVideosCell.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import UIKit

class DownloadingVideosCell: UITableViewCell {

    @IBOutlet weak var previewVideo: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var sizeVideo: UILabel!
    @IBOutlet weak var speedDownload: UILabel!
    
    var model: DownloadProcessEntity? {
        willSet(model) {
            nameView.text = model?.nameFile
            progressView.setProgress(Float(model?.percent ?? 0.0), animated: false)
            sizeVideo.text = "\(model?.size ?? 0)"
            speedDownload.text = model?.speedDownload
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
