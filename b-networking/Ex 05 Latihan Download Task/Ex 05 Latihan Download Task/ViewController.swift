//
//  ViewController.swift
//  Ex 05 Latihan Download Task
//
//  Created by septe habudin on 22/09/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var messageView: UILabel!
    @IBOutlet weak var btnView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        messageView.text = ""
        progressView.isHidden = true
        
        DownloadManager.shared.progress = { (totalBytesWritten, totalBytesExpectedToWrite) in
            let totalMB = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .binary)
            let writenMB = ByteCountFormatter.string(fromByteCount: totalBytesWritten, countStyle: .binary)
            
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            
            DispatchQueue.main.async {
                self.btnView.isEnabled = false
                self.progressView.isHidden = false
                self.progressView.progress = progress
                self.messageView.text = "Downloading \(writenMB) of \(totalMB)"
            }
        }
        
        DownloadManager.shared.completed = { (location) in
            try? FileManager.default.removeItem(at: location)
            DispatchQueue.main.async {
                self.messageView.text = "Download finished"
                self.btnView.isEnabled = true
            }
        }
        
        DownloadManager.shared.downloadError = { task, error in
            print("Task completed \(task) error \(error.localizedDescription)")
        }
        
        // MARK: after defined class downloaderManager
        // upagate method application in app delegat
    }
    
    

    @IBAction func actDownload(_ sender: Any) {
        let url = URL(string: "http://212.183.159.230/50MB.zip")
        let task = DownloadManager.shared.session.downloadTask(with: url!)

        task.resume()
        
    }
    
}

