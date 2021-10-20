//
//  GameRepository.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import Foundation

protocol GamesRepositoryProtocol {
    
    func getGamesList(page: String, result: @escaping (Result<[GameModel], Error>) -> Void)
    
}

final class GameRepository: NSObject {
    
    typealias GameInstance = (GamesDataSource) -> GameRepository
    
    fileprivate let remote: GamesDataSource
    
    private init(remote: GamesDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: GameInstance = { gameRepo in
        return GameRepository(remote: gameRepo)
    }
}

extension GameRepository: GamesRepositoryProtocol {
    func getGamesList(page: String, result: @escaping (Result<[GameModel], Error>) -> Void) {
        self.remote.getGameList(page: page) { remoteResponse in
            switch remoteResponse {
            case .success(let gameResponse):
                let resultList = GameListMapper.mapGameResponsesToDomains(input: gameResponse)
                result(.success(resultList))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
