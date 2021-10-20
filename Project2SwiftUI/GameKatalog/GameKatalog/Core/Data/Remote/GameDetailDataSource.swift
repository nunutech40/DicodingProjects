//
//  GameDetailDataSource.swift
//  GameKatalog
//
//  Created by mac on 20/10/21.
//

import Foundation

protocol GameDetailDataSourceProtocol: class {
    func getDetailGame(id: String, result: @escaping (Result<GameDetailResponse, URLError>) -> Void)
}

final class GameDetailDataSource: NSObject {
    
    private override init() {}
    
    static let sharedInstance: GameDetailDataSource = GameDetailDataSource()
}

extension GameDetailDataSource: GameDetailDataSourceProtocol {
    
    func getDetailGame(id: String, result: @escaping (Result<GameDetailResponse, URLError>) -> Void) {
        print("cek id dtailgame: \(id)")
        guard let url = URL(string: Endpoints.Gets.getGameDetail(id).url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let gameDetail = try decoder.decode(GameDetailResponse.self, from: data)
                    result(.success(gameDetail))
                    print("cek gamedetail: \(gameDetail)")
                } catch {
                    print("cek failure")
                    result(.failure(.invalidResponse))
                }
            }
            
        }
        task.resume()
    }
}
