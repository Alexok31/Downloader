//
//  PlayerViewController.swift
//  Downloader
//
//  Created by Alex Kharchenko on 18.01.2021.
//

import AVKit

class PlayerViewController: AVPlayerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
    }
}
