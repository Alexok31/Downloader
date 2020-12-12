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
    var url: String = ""
    var size: String = ""
    var percent: Double = 0.0
    var speedDownload: String?
    var urlFile: URL?
    
    init(nameFile: String, url: String, size: String, percent: Double, speedDownload: String?, urlFile: URL?, previewImage: String?) {
        self.nameFile = nameFile
        self.previewImage = previewImage
        self.url = url
        self.size = size
        self.percent = percent
        self.speedDownload = speedDownload
        self.urlFile = urlFile
    }
}
