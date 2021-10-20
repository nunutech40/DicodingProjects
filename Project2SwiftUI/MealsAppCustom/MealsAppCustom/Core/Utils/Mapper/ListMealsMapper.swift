//
//  ListMealsMapper.swift
//  MealsAppCustom
//
//  Created by mac on 19/10/21.
//

final class ListMealsMapper {
    
    static func mapMealResponsesToDomains(input mealResponses: [MealResponse]) -> [MealModel] {
        
        return mealResponses.map { result in
            return MealModel(
                id: result.id ?? "",
                title: result.title ?? "",
                image: result.image ?? "",
                description: result.description ?? "")
        }
    }
    
}
