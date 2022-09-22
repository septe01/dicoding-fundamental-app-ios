//
//  DownloadManager.swift
//  Ex 05 Latihan Download Task
//
//  Created by septe habudin on 22/09/22.
//

import Foundation


class DownloadManager: NSObject {
    static var shared = DownloadManager()
    
    var progress: ((Int64, Int64) -> ())?
    var completed: ((URL) -> ())?
    var downloadError: ((URLSessionTask, Error) -> ())?
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "com.septe.downloadTask")
        config.isDiscretionary = false
        return URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
    }()
}

extension DownloadManager: URLSessionDelegate, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        completed!(location)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        downloadError!(task, error!)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if totalBytesWritten > 0 {
            progress!(totalBytesWritten,totalBytesExpectedToWrite)
        }
    }
    
    
}
