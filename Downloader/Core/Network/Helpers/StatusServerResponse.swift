//
//  StatusServerResponse.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import Foundation

enum StatusServerResponse: Int {
    case successful
    case videoNotAvailable
    case reqerstCancelled
    case notResponding
    case noInternetConnection
}
