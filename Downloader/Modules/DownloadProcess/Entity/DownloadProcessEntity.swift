//
//  DownloadProcessEntity.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import Foundation

class DownloadProcessEntity: Equatable {
    
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
    
    static func == (lhs: DownloadProcessEntity, rhs: DownloadProcessEntity) -> Bool {
        return lhs.nameFile == rhs.nameFile && lhs.previewImage == rhs.previewImage && lhs.urlLink == rhs.urlLink && lhs.size == rhs.size && lhs.previewImage == rhs.previewImage && lhs.urlFile == rhs.urlFile
    }
}
