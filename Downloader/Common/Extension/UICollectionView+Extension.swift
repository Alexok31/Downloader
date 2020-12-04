//
//  UICollectionView+Extension.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import UIKit

extension UICollectionView {
    
    func register(CellClass: UICollectionViewCell.Type) {
        register(CellClass.self, forCellWithReuseIdentifier: String(describing: CellClass.self))
    }
    
    func registerWithNib<CellClass: UICollectionViewCell>(cellClass: CellClass.Type) {
        let cellClassName = String(describing: cellClass.self)
        let nib = UINib(nibName: cellClassName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: cellClassName)
    }

    func dequeue<CellClass: UICollectionViewCell>(_ cellClass: CellClass.Type, for indexPath: IndexPath) -> CellClass {
        let cellClassName = String(describing: cellClass.self)
        let cell = dequeueReusableCell(withReuseIdentifier: cellClassName, for: indexPath)
        guard let typedCell = cell as? CellClass else {
            fatalError("Could not deque cell with type \(CellClass.self)")
        }
        return typedCell
    }
    
}
