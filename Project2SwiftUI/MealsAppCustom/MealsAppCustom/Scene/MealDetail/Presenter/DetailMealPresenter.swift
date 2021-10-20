//
//  DetailMealPresenter.swift
//  MealsAppCustom
//
//  Created by mac on 19/10/21.
//

import SwiftUI

class DetailMealPresenter: ObservableObject {
    
    private let detailUseCase: MealDetailUseCase
    
    @Published var meal: MealModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(detailUseCase: MealDetailUseCase) {
        self.detailUseCase = detailUseCase
        meal = detailUseCase.getMeal()
    }
}
