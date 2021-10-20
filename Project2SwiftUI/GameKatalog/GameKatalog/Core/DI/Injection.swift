//
//  Injection.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import Foundation

final class Injection: NSObject {
    
    // provide gamelist
    private func provideRepository() -> GamesRepositoryProtocol {
        let remote: GamesDataSource = GamesDataSource.sharedInstance
        return GameRepository.sharedInstance(remote)
    }
    
    func provideGameList() -> GameListUseCase {
        let repository = provideRepository()
        return GameListInteractor(repository: repository)
    }
    
    // provide gameDetail
    private func provideGameDetailRepo() -> GameDetailRepositoryProtocol {
        let remote: GameDetailDataSource = GameDetailDataSource.sharedInstance
        return GameDetailRepository.sharedInstace(remote)
    }
    
    func provideGameDetail(id: String) -> GameDetailUseCase {
        let repository = provideGameDetailRepo()
        return GameDetailInteractor(repository: repository, id: id)
    }
}
