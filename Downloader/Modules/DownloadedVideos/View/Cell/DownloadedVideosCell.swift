//
//  DownloadedVideosCell.swift
//  Downloader
//
//  Created by Alex Kharchenko on 13.12.2020.
//

import UIKit

class DownloadedVideosCell: UITableViewCell {
    
    @IBOutlet weak var previewVideo: CustomImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeVideo: UILabel!
    @IBOutlet weak var saveToPhotoButton: UIButton!
    
    weak var delegate: TableViewCellDelegate?
    
    var model: DownloadedVideosEntity? {
        willSet(model) {
            nameLabel.text = model?.name
            sizeVideo.text = model?.size
            if previewVideo.image == nil {
                previewVideo.downloadImege(from: model?.previewImageLink)
            }
        }
    }
    
    override func prepareForReuse() {
        previewVideo.image = nil
    }
    
    @IBAction func saveToPhotoAction(_ button: UIButton) {
        delegate?.tableViewCell(self, buttonTapped: button)
    }
    
}
