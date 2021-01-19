//
//  DownloadedVideosCell.swift
//  Downloader
//
//  Created by Alex Kharchenko on 13.12.2020.
//

import UIKit

class DownloadedVideosCell: UITableViewCell {
    
    @IBOutlet weak var previewVideo: LoadingImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeVideo: UILabel!
    @IBOutlet weak var saveToPhotoButton: UIButton!
    
    weak var delegate: TableViewCellDelegate?
    
    var model: DownloadedVideosEntity? {
        willSet(model) {
            nameLabel.text = model?.name
            sizeVideo.text = model?.size
            if let imageLink = model?.previewImageLink {
                previewVideo.loadImage(by: imageLink)
            }
        }
    }
    
    override func prepareForReuse() {
        previewVideo.canceled()
        previewVideo.image = nil
    }
    
    @IBAction func saveToPhotoAction(_ button: UIButton) {
        delegate?.tableViewCell(self, buttonTapped: button)
    }
    
}
