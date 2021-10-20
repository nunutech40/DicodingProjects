//
//  MealsRepository.swift
//  MealsAppCustom
//
//  Created by mac on 12/10/21.
//

import Foundation

protocol MealsRepositoryProtocol {
    
    func getMeals(result: @escaping (Result<[MealModel], Error>) -> Void)
    
}

final class MealsRepository: NSObject {
    
    typealias MealInstance = (MealsDataSource) -> MealsRepository
    
    fileprivate let remote: MealsDataSource
    
    private init(remote: MealsDataSource) {
        self.remote = remote
    }
    
    static let sharedInstace: MealInstance = { mealRepo in
        return MealsRepository(remote: mealRepo)
    }
    
}

extension MealsRepository: MealsRepositoryProtocol {
    
    func getMeals(result: @escaping (Result<[MealModel], Error>) -> Void) {
        self.remote.getMeals { remoteResponse in
            switch remoteResponse {
            case .success(let mealResponse):
                let resultList = ListMealsMapper.mapMealResponsesToDomains(input: mealResponse)
                result(.success(resultList))
            case .failure(let error):
                result(.failure(error))
            }
            
        }
    }
}
