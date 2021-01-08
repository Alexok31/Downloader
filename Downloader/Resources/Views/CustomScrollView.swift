//
//  CustomScrollView.swift
//  Downloader
//
//  Created by Alex Kharchenko on 05.01.2021.
//

import UIKit

class CustomScrollView: UIScrollView {
    
    var didTap: (()->())?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        didTap?()
    }

}
