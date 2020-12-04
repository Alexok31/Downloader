//
//  DownloadProcessEntity.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import Foundation

struct DownloadProcessEntity {
    var nameFile: String
    var url: String
    var size: Int
    var percent: Double
    var urlFile: URL?
}
