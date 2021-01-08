//
//  TableViewCellDelegate.swift
//  Downloader
//
//  Created by Alex Kharchenko on 14.12.2020.
//

import UIKit

public protocol TableViewCellDelegate: class {
    func tableViewCell(_ cell: UITableViewCell, buttonTapped: UIButton)
}
