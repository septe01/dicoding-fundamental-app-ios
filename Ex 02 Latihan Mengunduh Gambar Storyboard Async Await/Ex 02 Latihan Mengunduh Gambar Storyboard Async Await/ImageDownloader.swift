//
//  ImageDownloader.swift
//  Ex 02 Latihan Mengunduh Gambar Storyboard Async Await
//
//  Created by septe habudin on 20/09/22.
//

import Foundation
import UIKit

class ImageDownloader {
    
    func downloadImage(url: URL) async throws -> UIImage {
        async let imageData: Data = try Data(contentsOf: url)
        
        return UIImage(data: try await imageData)!
    }
}
