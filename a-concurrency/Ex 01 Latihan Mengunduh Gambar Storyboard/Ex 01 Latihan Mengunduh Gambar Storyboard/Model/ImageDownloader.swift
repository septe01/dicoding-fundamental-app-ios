//
//  ImageDownloader.swift
//  Ex 01 Latihan Mengunduh Gambar Storyboard
//
//  Created by septe habudin on 19/09/22.
//  class ini untuk menangani logika pengunduhan gambar
//

import Foundation
import UIKit

class ImageDownloader: Operation {
    private let movie: MovieModel
    
    init(movie: MovieModel){
        self.movie = movie
    }
    
    // semua pekerjaan yang berhubungan dengan Operation akan dieksekusi.
    override func main() {
        if isCancelled {
            return
        }
        
        //menggunakan kelas Data untuk mengunduh gambar menggunakan URL
        guard let imageData = try? Data(contentsOf: self.movie.poster) else {return}
        print("imageData \(imageData)")
        
        //Periksa kembali status tugas sebelum Anda melakukan assignment ke variabel image dan state, apakah dibatalkan atau tidak
        if isCancelled {
            return
        }
        
        //periksalah nilai dari imageData
        if !imageData.isEmpty{
            self.movie.image = UIImage(data: imageData)
            self.movie.state = .download
        }else{
            self.movie.image = nil
            self.movie.state = .failed
        }
    }
}

// elas untuk menangani berbagai request.
class PendingOperations {
    
    lazy var downloadInProgress: [IndexPath: Operation] = [:]
    
    lazy var downloadQueue: OperationQueue  = {
        var queue = OperationQueue()
        queue.name = "com.dicoding.imagedownload"
        queue.maxConcurrentOperationCount = 2
        return queue
    }()
}
