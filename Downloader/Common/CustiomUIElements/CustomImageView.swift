//
//  CustomImageView.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func downloadImege(from url: String?) {
        imageUrlString = url
        self.image = nil
        
        if let cachedImeg = imageCache.object(forKey: url as AnyObject) as? UIImage {
            DispatchQueue.main.async {
                self.image = cachedImeg
            }
            return
        }
        guard  let urlS = URL(string: url ?? "") else  { return }
        let urlRequest = URLRequest (url: urlS)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                return
            }
            if let data = data, let downloadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    if self.imageUrlString == url {
                        self.image = downloadedImage
            
                    }
                    imageCache.setObject(downloadedImage, forKey: url as AnyObject)
                }
            }
        }
        task.resume()
    }
}

