//
//  ViewController.swift
//  Lat-GetAPI
//
//  Created by mac on 13/9/21.
//

import UIKit

class ViewController: UIViewController {
    
    let apiKey = "3a5523320856fb0b9d7ad8812f94feba"
    let language = "en-US"
    let page = "1"
    var components = URLComponents(string: "https://api.themoviedb.org/3/movie/popular")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        task.resume()
        
        
        // post
        self.getGuessSessionId { guest in
            var components = URLComponents(string: "https://api.themoviedb.org/3/movie/339095/rating")!
            
            components.queryItems = [
                URLQueryItem(name: "api_key", value: self.apiKey),
                URLQueryItem(name: "guest_session_id", value: guest.guestSessionId),
            ]
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonRequest = [
                "value": 8.5
            ]
            
            let jsonData = try! JSONSerialization.data(withJSONObject: jsonRequest, options: [])
            
            let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
                guard let response = response as? HTTPURLResponse, let data = data else {
                    return
                }
                if response.statusCode == 200 {
                    self.decodeJSON(data: data)
                } else {
                    print("Error: \(data), HTTP Status: \(response.statusCode)")
                }
                
            }
            
            task.resume()
        }
        
        // get popular
        self.getPopular()
    }
    
    func getPopular() {
        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/popular")!
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "page", value: page)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else {
                return
            }
            print("cek responsestatus popular: \(response.statusCode)")
            if response.statusCode == 200 {
                self.decodeJSON(data: data)
                
            } else {
                print("Error: \(data), HTTP Status: \(response.statusCode)")
            }
            
        }
        
        task.resume()
    }
    
    func getGuessSessionId(completion: ((Guest) -> ())?) {
        var components = URLComponents(string: "https://api.themoviedb.org/3/authentication/guest_session/new")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        guard let url = components?.url else {
            return
        }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else {
                return
            }
            
            if response.statusCode == 200 {
                let decoder = JSONDecoder()
                let response = try! decoder.decode(Guest.self, from: data)
                print("cek response after decode: \(response)")
                completion?(response)
            } else {
                print("ERROR: \(data), HTTP Status: \(response.statusCode)")
            }
        }
        
        task.resume()
    }
    
    private func decodeJSON(data: Data) {
        let decoder = JSONDecoder()
        print("cek data before decode: \(data)")
        if let movies = try? decoder.decode(Movies.self, from: data) as Movies {
            
            
        } else {
            print("ERROR: can't Decode JSON")
        }
        
    }


}

