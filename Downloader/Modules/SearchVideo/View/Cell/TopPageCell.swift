//
//  TopPageCell.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import UIKit

class TopPageCell: UICollectionViewCell {

    @IBOutlet weak var icon: CustomImageView!
    @IBOutlet weak var name: UILabel!
    
    var modelInfo: TopPageInfo? {
        willSet(model) {
            name?.text = model?.name
            icon?.downloadImege(from: model?.imageUrl)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}


