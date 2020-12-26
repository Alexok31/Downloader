//
//  UrlVideoEntity.swift
//  Downloader
//
//  Created by Alex Kharchenko on 07.12.2020.
//

import Foundation

struct VideoUrlEntity: Decodable {
    var download_link: String?
    var ext: String?
    var poster: String?
}
