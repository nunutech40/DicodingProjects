//
//  HomeView.swift
//  MealsAppCustom
//
//  Created by mac on 12/10/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        ZStack{
            if presenter.loadingState {
                VStack {
                    Text("Lagi Loading ya...")
                    ActivityIndicator()
                }
            } else {
               
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(
                        self.presenter.meals,
                        id: \.id
                    ) { meal in
                        ZStack {
                            self.presenter.linkBuilder(for: meal) {
                                MealRow(meal: meal)
                            }.buttonStyle(PlainButtonStyle())
                        }.padding(8)
                    }
                }
            }
        }.onAppear {
            if self.presenter.meals.count == 0 {
                self.presenter.getMeals()
            }
        }.navigationBarTitle(
            Text("Meals List"),
            displayMode: .automatic
        )
    }
}
