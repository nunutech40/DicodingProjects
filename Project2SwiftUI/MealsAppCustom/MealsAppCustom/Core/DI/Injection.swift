//
//  Injection.swift
//  MealsAppCustom
//
//  Created by mac on 19/10/21.
//

import Foundation

final class Injection: NSObject {
    
    private func provideRepository() -> MealsRepositoryProtocol {
        
        let remote: MealsDataSource = MealsDataSource.sharedInstance
        
        return MealsRepository.sharedInstace(remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail(meal: MealModel) -> MealDetailUseCase {
        let repository = provideRepository()
        return MealDetailInteractor(repository: repository, meal: meal)
    }
    
}
