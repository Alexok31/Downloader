//
//  DownloadService.swift
//  Downloader
//
//  Created by Alex Kharchenko on 04.12.2020.
//

import Alamofire

protocol DownloadControll {
    func downloadVideo(by videoUrl: String,
                       start: @escaping()->(),
                       progress: @escaping(Double)->(),
                       complition: @escaping(URL)->())
    func stop()
    func resume()
}

class DownloadService: DownloadControll {
    
    private var request: Alamofire.Request?
    
    func downloadVideo(by videoUrl: String,
                       start: @escaping()->(),
                       progress: @escaping(Double)->(),
                       complition: @escaping(URL)->()) {
        
        start()
        request = AF.request(videoUrl).downloadProgress(closure: { (progressDownload) in
            progress(progressDownload.fractionCompleted)
        }).responseData{ (response) in
            print(response.data?.count)
            if let data = try? response.result.get() {

                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let videoURL = documentsURL.appendingPathComponent("video.mp4")
                do {
                    try data.write(to: videoURL)
                    } catch {
                    print("Something went wrong!")
                }
                complition(videoURL)
            }
        }
    }
    
    func stop() {
        request?.suspend()
    }
    
    func resume() {
        request?.resume()
    }
}
