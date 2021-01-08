//
//  Extension+String.swift
//  Downloader
//
//  Created by Alex Kharchenko on 05.01.2021.
//

import Foundation

extension String {
    var encodeUrl: String? {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    
    var decodeUrl: String? {
        return self.removingPercentEncoding
    }
}
