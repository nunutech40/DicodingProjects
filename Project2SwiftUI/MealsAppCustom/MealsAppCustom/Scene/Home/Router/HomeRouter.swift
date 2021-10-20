//
//  HomeRouter.swift
//  MealsAppCustom
//
//  Created by mac on 19/10/21.
//

import SwiftUI

class HomeRouter {
    func makeDetailMealView(for meal: MealModel) -> some View {
        let mealDetailUseCase = Injection().provideDetail(meal: meal)
        let presenter = DetailMealPresenter(detailUseCase: mealDetailUseCase)
        return DetailView(presenter: presenter)
    }
}
