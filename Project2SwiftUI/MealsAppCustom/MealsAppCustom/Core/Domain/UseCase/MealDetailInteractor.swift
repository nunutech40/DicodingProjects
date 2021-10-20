//
//  MealDetailInteractor.swift
//  MealsAppCustom
//
//  Created by mac on 19/10/21.
//

import Foundation

protocol MealDetailUseCase {
    func getMeal() -> MealModel
}

class MealDetailInteractor: MealDetailUseCase {
    
    private let repository: MealsRepositoryProtocol
    private let meal: MealModel
    
    required init(repository: MealsRepositoryProtocol, meal: MealModel) {
        self.repository = repository
        self.meal = meal
    }
    
    func getMeal() -> MealModel {
        return meal
    }
    
    
}
