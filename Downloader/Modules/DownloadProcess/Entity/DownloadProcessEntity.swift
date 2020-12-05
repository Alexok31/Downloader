//
//  DownloadProcessEntity.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import Foundation

class DownloadProcessEntity {
    var nameFile: String = ""
    var url: String = ""
    var size: Int = 0
    var percent: Double = 0.0
    var speedDownload: String?
    var urlFile: URL?
    
    init(nameFile: String, url: String, size: Int, percent: Double, speedDownload: String?, urlFile: URL?) {
        self.nameFile = nameFile
        self.url = url
        self.size = size
        self.percent = percent
        self.speedDownload = speedDownload
        self.urlFile = urlFile
    }
}
