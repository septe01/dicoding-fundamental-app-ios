//
//  MovieModel.swift
//  Ex 01 Latihan Mengunduh Gambar Storyboard
//
//  Created by septe habudin on 18/09/22.
//

import Foundation
import UIKit

enum DownloadState {
    case new, download, failed
}


class MovieModel {
    let title: String
    let poster: URL
    
    var image: UIImage?
    var state: DownloadState = .new
    
    init(title: String,poster: URL){
        self.title = title
        self.poster = poster
    }
}


let movies = [
    MovieModel(
    title: "Thor: Love and Thunder",
    poster: URL(string: "https://image.tmdb.org/t/p/w500/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg")!
  ), MovieModel(
    title: "Minions: The Rise of Gru",
    poster: URL(string: "https://image.tmdb.org/t/p/w500/wKiOkZTN9lUUUNZLmtnwubZYONg.jpg")!
  ), MovieModel(
    title: "Jurassic World Dominion",
    poster: URL(string: "https://image.tmdb.org/t/p/w500/kAVRgw7GgK1CfYEJq8ME6EvRIgU.jpg")!
  ), MovieModel(
    title: "Top Gun: Maverick",
    poster: URL(string: "https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg")!
  ), MovieModel(
    title: "The Gray Man",
    poster: URL(string: "https://image.tmdb.org/t/p/w500/8cXbitsS6dWQ5gfMTZdorpAAzEH.jpg")!
  ), MovieModel(
    title: "The Black Phone",
    poster: URL(string: "https://image.tmdb.org/t/p/w500/p9ZUzCyy9wRTDuuQexkQ78R2BgF.jpg")!
  ), MovieModel(
    title: "Lightyear",
    poster: URL(string: "https://image.tmdb.org/t/p/w500/ox4goZd956BxqJH6iLwhWPL9ct4.jpg")!
  ), MovieModel(
    title: "Doctor Strange in the Multiverse of Madness",
    poster: URL(string: "https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg")!
  ), MovieModel(
    title: "Indemnity",
    poster: URL(string: "https://image.tmdb.org/t/p/w500/tVbO8EAbegVtVkrl8wNhzoxS84N.jpg")!
  ), MovieModel(
    title: "Borrego",
    poster: URL(string: "https://image.tmdb.org/t/p/w500/kPzQtr5LTheO0mBodIeAXHgthYX.jpg")!
  )
]
