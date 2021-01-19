//
//  LoadingImageView.swift
//  Downloader
//
//  Created by Alex Kharchenko on 19.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

class LoadingImageView: UIImageView {
    
    var disposable: Disposable?
    
    func loadImage(by urlString: String) {
        disposable = loadImage(for: urlString).bind(to: self.rx.image)
    }
    
    func canceled() {
        disposable?.dispose()
    }
    
    private func loadImage(for urlLink: String?) -> Observable<UIImage?> {
        guard let url = URL(string: urlLink ?? "") else { return Observable.never() }
        return Observable.just(url).flatMap { (url) -> Observable<UIImage?> in
            return ImageLoader.shared.loadImage(from: url)
        }.asObservable()
    }
    
}

