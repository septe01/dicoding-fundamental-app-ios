import UIKit
import Foundation

var greeting = "Latihan Berinteraksi dengan API Melalui HTTP GET"


let apiKey = "3e128906dc7b9f34448c28d8c2348c89"
let language = "en-US"
let page = "1"


var components = URLComponents(string: "https://api.themoviedb.org/3/movie/popular")!
components.queryItems = [
    URLQueryItem(name: "api_key", value: apiKey),
    URLQueryItem(name: "language", value: language),
    URLQueryItem(name: "page", value: page),
]

let request = URLRequest(url: components.url!)

let task = URLSession.shared.dataTask(with: request) { data, res, error in
    guard let response = res as? HTTPURLResponse else {return}
    
    if let data = data {
        if response.statusCode == 200 {
            print("data \(data)")
        }else {
            print("Error \(data), HTTPS status \(response.statusCode) ")
        }
    }
}

task.resume()
