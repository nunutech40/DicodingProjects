import UIKit

let apiKey = "3a5523320856fb0b9d7ad8812f94feba"
let language = "en-US"
let page = "1"

var components = URLComponents(string: "https://api.themoviedb.org/3/movie/popular")!

components.queryItems = [
    URLQueryItem(name: "api_key", value: apiKey),
    URLQueryItem(name: "language", value: language),
    URLQueryItem(name: "page", value: page)
]
var request: URLRequest?
if let urlData = components.url {
    request = URLRequest(url: urlData)
}

let task = URLSession.shared.dataTask(with: request!) { data, response, error in
    guard let response = response as? HTTPURLResponse else {
        return
    }
    
    if let data = data {
        
        if response.statusCode == 200 {
            print("data: \(data)")
        } else {
            print("Error: \(data), HTTP Status: \(response.statusCode)")
        }
        
    }
}


