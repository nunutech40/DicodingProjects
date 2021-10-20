//
//  HomeInteractor.swift
//  MealsAppCustom
//
//  Created by mac on 19/10/21.
//

import Foundation

protocol HomeUseCase {
    
    func getMeals(completion: @escaping (Result<[MealModel], Error>) -> Void)
    
}

class HomeInteractor: HomeUseCase {
    
    private let repository: MealsRepositoryProtocol
    
    required init(repository: MealsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMeals(completion: @escaping (Result<[MealModel], Error>) -> Void) {
        repository.getMeals { result in
            completion(result)
        }
    }
    
}
