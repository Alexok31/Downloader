//
//  UITableView+Extension.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import UIKit

extension UITableView {
    
    func register(CellClass: UITableViewCell.Type) {
        register(CellClass.self, forCellReuseIdentifier: String(describing: CellClass.self))
    }
    
    func registerWithNib<CellClass: UITableViewCell>(cellClass: CellClass.Type) {
        let cellClassName = String(describing: cellClass.self)
        let nib = UINib(nibName: cellClassName, bundle: nil)
        register(nib, forCellReuseIdentifier: cellClassName)
    }

    func dequeue<CellClass: UITableViewCell>(_ cellClass: CellClass.Type, for indexPath: IndexPath) -> CellClass {
        let cellClassName = String(describing: cellClass.self)
        
        let cell = dequeueReusableCell(withIdentifier: cellClassName, for: indexPath)
        guard let typedCell = cell as? CellClass else {
            fatalError("Could not deque cell with type \(CellClass.self)")
        }
        return typedCell
    }
    
}
