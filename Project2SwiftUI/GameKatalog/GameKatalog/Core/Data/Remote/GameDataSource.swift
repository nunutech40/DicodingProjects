//
//  GameDataSource.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import Foundation

protocol GameDataSourceProtocol: class {

    func getGameList(page: String, result: @escaping (Result<[GameResponse], URLError>) -> Void)
}

final class GamesDataSource: NSObject {
    private override init() {}
    
    static let sharedInstance: GamesDataSource = GamesDataSource()
}

extension GamesDataSource: GameDataSourceProtocol {
    
    func getGameList(page: String, result: @escaping (Result<[GameResponse], URLError>) -> Void) {
        
        guard let url = URL(string: Endpoints.Gets.getGameList(page).url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let games = try decoder.decode(GameResponses.self, from: data).results
                    result(.success(games))
                } catch {
                    result(.failure(.invalidResponse))
                }
            }
            
        }
        task.resume()
        
    }
}
