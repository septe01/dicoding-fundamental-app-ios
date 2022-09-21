import UIKit

var greeting = "Latihan Shared Session"


let path = "https://www.dicoding.com/blog/wp-content/uploads/2017/10/dicoding-logo-square.png"

let url = URL(string: path)

let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: url!) { data, res, error in
    guard let data = data else {return}
    
    let image = UIImage(data: data)
    
    print(image!)
}

//untuk menjalankan tugas URLSession
downloadTask.resume()
