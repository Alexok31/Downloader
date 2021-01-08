//
//  UIViewController + Extension(Alert).swift
//  Downloader
//
//  Created by Alex Kharchenko on 14.12.2020.
//

import UIKit

extension UIViewController {
    
    static func alertMessage(title: String, message: String, cansel: (() -> ())? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let clouse = UIAlertAction(title: "Okay", style: .cancel) { (alert) in cansel?() }
            alert.addAction(clouse)
        return alert
    }
    
    func alertWithActions(title: String, message: String, actionsTitle: String, canselTitle: String,
                          actions: @escaping () -> (), cansel: (() -> ())?) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        let actions = UIAlertAction(title: actionsTitle, style: .default) { (alert) in actions() }
        let cansel = UIAlertAction(title: canselTitle, style: .cancel) { (alert) in cansel?() }
        alert.addAction(actions)
        alert.addAction(cansel)
        self.present(alert, animated: true, completion: nil)
    }
}
