//
//  DownloadProcessEntity.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import Foundation

class DownloadProcessEntity {
    var nameFile: String = ""
    var previewImage: String? = nil
    var urlLink: String = ""
    var size: String = ""
    var percent: Double = 0.0
    var speedDownload: String?
    var urlFile: String = ""
    
    init(nameFile: String, urlLink: String, size: String, percent: Double, speedDownload: String?, urlFile: String, previewImage: String?) {
        self.nameFile = nameFile
        self.previewImage = previewImage
        self.urlLink = urlLink
        self.size = size
        self.percent = percent
        self.speedDownload = speedDownload
        self.urlFile = urlFile
    }
}
