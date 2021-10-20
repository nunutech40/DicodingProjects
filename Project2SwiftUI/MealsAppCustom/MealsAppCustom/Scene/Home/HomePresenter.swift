//
//  HomePresenter.swift
//  MealsAppCustom
//
//  Created by mac on 19/10/21.
//

import SwiftUI

class HomePresenter: ObservableObject {
    
    private let homeUseCase: HomeUseCase
    private let router = HomeRouter()
    
    @Published var meals: [MealModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        
        self.homeUseCase = homeUseCase
        
    }
    
    func getMeals() {
        loadingState = true
        homeUseCase.getMeals { result in
            switch result {
            case .success(let meals):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.meals = meals
                    print("cek mealsmnyaa: \(self.meals)")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.errorMessage = error.localizedDescription
                    print("cek error: \(self.errorMessage)")
                }
            }
        }
    }
    
    func linkBuilder<Content: View>(for meal: MealModel, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(
            destination: router.makeDetailMealView(for: meal)) { content()}
    }
    
}
