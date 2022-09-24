//
//  ImageDownloader.swift
//  Ex 09 Latihan Menampilkan Data API dalam Aplikas
//
//  Created by septe habudin on 24/09/22.
//

import Foundation
import UIKit

class ImageDownloader {
    func downloadImage(url: URL) async throws -> UIImage {
        async let imageData: Data = try Data(contentsOf: url)
        
        return UIImage(data: try await imageData)!
    }
}
