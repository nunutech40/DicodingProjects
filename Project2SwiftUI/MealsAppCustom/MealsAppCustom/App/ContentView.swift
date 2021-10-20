//
//  ContentView.swift
//  MealsAppCustom
//
//  Created by mac on 12/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var homePresenter: HomePresenter
    
    var body: some View {
        NavigationView {
            HomeView(presenter: homePresenter)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
