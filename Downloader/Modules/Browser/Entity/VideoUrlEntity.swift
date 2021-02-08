//
//  UrlVideoEntity.swift
//  Downloader
//
//  Created by Alex Kharchenko on 07.12.2020.
//

import Foundation

struct VideoUrlEntity: Decodable {
    var size: String?
    var title: String?
    var download_link: String?
    var duration: String?
    var ext: String?
    var poster: String?
}
