//
//  CategoryRow.swift
//  MealsAppCustom
//
//  Created by mac on 12/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MealRow: View {
    
    var meal: MealModel
    
    var body: some View {
        VStack {
            imageCategory
            content
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 250)
        .background(Color.random.opacity(0.3))
        .cornerRadius(30)
    }
}

extension MealRow {
    
    var imageCategory: some View {
        WebImage(url: URL(string: meal.image!))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 200)
            .cornerRadius(30)
            .padding(.top)
    }
    
    var content: some View {
      VStack(alignment: .leading, spacing: 10) {
        Text(meal.title ?? "")
          .font(.title)
          .bold()
        
        Text(meal.description ?? "")
          .font(.system(size: 14))
          .lineLimit(2)
      }.padding(
        EdgeInsets(
          top: 0,
          leading: 16,
          bottom: 16,
          trailing: 16
        )
      )
    }
}


// present
struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        let meal = MealModel(
            id: "1",
            title: "Daging lah",
            image: "https://www.themealdb.com/images/category/beef.png",
            description: "Beef is the culinary name for meat from cattle, particularly skeletal muscle.")
        
        MealRow(meal: meal)
    }
}
