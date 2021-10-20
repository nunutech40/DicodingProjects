//
//  DetailView.swift
//  MealsAppCustom
//
//  Created by mac on 19/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    
    @ObservedObject var presenter: DetailMealPresenter
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack {
                    imageCategory
                    spacer
                    content
                    spacer
                }.padding()
            }
        }
    }
}

extension DetailView {
    
    var spacer: some View {
        Spacer()
    }
    
    var imageCategory: some View {
        WebImage(url: URL(string: self.presenter.meal.image ?? ""))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 250, height: 250, alignment: .center)
    }
    
    var description: some View {
        Text(self.presenter.meal.description ?? "")
            .font(.system(size: 15))
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title.uppercased())
            .font(.headline)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerTitle(self.presenter.meal.title ?? "")
                .padding([.top, .bottom])
            description
        }
    }
}
