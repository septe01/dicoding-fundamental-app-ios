import UIKit
import Foundation

var greeting = "Latihan Berinteraksi dengan API Melalui HTTP POST"


let apiKey = "3e128906dc7b9f34448c28d8c2348c89"


//untuk menyimpan data guest_session_id hasil dari server dengan nama Guest
struct Guest: Codable{
    let success: Bool
    let guestSessionId: String
    
    enum CodingKeys: String, CodingKey {
    case success
    case guestSessionId = "guest_session_id"
    }
}


func getGuestSessionId(completion: ((Guest)->())?) {
    let url = "https://api.themoviedb.org/3/authentication/guest_session/new"
    var component = URLComponents(string: url)
    
    component?.queryItems = [
        URLQueryItem(name: "api_key", value: apiKey)
    ]
    
    let request = URLRequest(url: (component?.url)!)
    
//    buat task dengan tipe .sharedSession
    let task = URLSession.shared.dataTask(with: request){ data, res, error in
        guard let response = res as? HTTPURLResponse, let data = data else {
            return
        }
        
        if response.statusCode == 200 {
            let decoder = JSONDecoder()
            let response = try! decoder.decode(Guest.self, from: data)
            print(response)
            completion?(response)
        }else{
            print("ERROR: \(data), HTTP Status: \(response.statusCode)")
        }
    }
    
    task.resume()
}

getGuestSessionId { guest in
  var components = URLComponents(string: "https://api.themoviedb.org/3/movie/610150/rating")!
//    print("after get session id")
    
    components.queryItems = [
        URLQueryItem(name: "api_key", value: apiKey),
        URLQueryItem(name: "guest_session_id", value: guest.guestSessionId)
    ]
    
    var request = URLRequest(url: components.url!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let jsonRequest = [
        "value": 9.0
    ]
    
//    mengonversi dictionary jsonRequest tersebut menjadi jsonData (NSData)
    let jsonData = try! JSONSerialization.data(withJSONObject: jsonRequest,options: [])
    
    let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, res, error in
        guard let response = res as? HTTPURLResponse, let data = data else {return}
        
        if response.statusCode == 201{
            print("Data \(data)")
        }
    }
    
    task.resume()
        
}
