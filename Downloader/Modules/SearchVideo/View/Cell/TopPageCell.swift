//
//  TopPageCell.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import UIKit

class TopPageCell: UICollectionViewCell {

    @IBOutlet weak var icon: LoadingImageView!
    @IBOutlet weak var name: UILabel!
    
    var modelInfo: TopPageInfo? {
        willSet(model) {
            name?.text = model?.name
            if let imageLink = model?.imageUrl {
                icon?.loadImage(by: imageLink)
            }
        }
    }
    
    override func prepareForReuse() {
        icon.image = nil
        icon.canceled()
    }
}


