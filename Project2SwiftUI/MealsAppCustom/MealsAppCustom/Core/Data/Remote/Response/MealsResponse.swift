//
//  MealResponse.swift
//  MealsAppCustom
//
//  Created by mac on 12/10/21.
//

import Foundation

struct MealsResponse: Decodable {
    let categories: [MealResponse]
}

struct MealResponse: Decodable {
    
    let id: String?
    let title: String?
    let image: String?
    let description: String?
    
    private enum CodingKeys: String, CodingKey {
       case id = "idCategory"
        case title = "strCategory"
        case image = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}
