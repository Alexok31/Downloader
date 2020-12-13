//
//  DownloadedVideosEntity.swift
//  Downloader
//
//  Created by Alex Kharchenko on 13.12.2020.
//

import Realm
import RealmSwift

class DownloadedVideosEntity: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var urlLink: String = ""
    @objc dynamic var fileUrl: String = ""
    @objc dynamic var previewImageLink: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var size: String = ""
    
}
