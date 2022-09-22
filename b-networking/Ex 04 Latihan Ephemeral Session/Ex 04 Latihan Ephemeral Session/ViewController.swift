//
//  ViewController.swift
//  Ex 04 Latihan Ephemeral Session
//
//  Created by septe habudin on 22/09/22.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        downloadImage()
    }
    
    private func downloadImage() {
        let path = "https://www.dicoding.com/blog/wp-content/uploads/2017/10/dicoding-logo-square.png"
        
        let url = URL(string: path)
        
       // let configuration = URLSessionConfiguration.ephemeral
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration)
        
        if let response = configuration.urlCache?.cachedResponse(for: URLRequest(url:  url!)) {
            label.text = "use cache image"
            imageView.image = UIImage(data: response.data)
        }else{
            label.text = "Call image from network"
            
            // Ketika tidak ada data dalam cache, buat taskuntuk mengunduh gambar dengan URL yang ada
            let downloadTask = session.dataTask(with: url!) { [weak self] data, res, err in
                guard let self = self, let data = data else {return}
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
            
            downloadTask.resume()
        }
    }


}

