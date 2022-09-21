import UIKit

var greeting = "Latihan Default Session"


let path = "https://www.dicoding.com/blog/wp-content/uploads/2017/10/dicoding-logo-square.png"

let url = URL(string: path)

let configuration = URLSessionConfiguration.default
configuration.waitsForConnectivity = true
configuration.timeoutIntervalForResource = 30
configuration.timeoutIntervalForRequest = 30
configuration.allowsCellularAccess = true

let session = URLSession(configuration: configuration)

let downloadTask: URLSessionDataTask = session.dataTask(with: url!) { data, res, error in
    guard let data = data else {return}
    
    let image = UIImage(data: data)
    
    print(image!)
}

downloadTask.resume()

