//
//  APICall.swift
//  MealsAppCustom
//
//  Created by mac on 12/10/21.
//

import Foundation

struct API {
    
    static let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
    
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints {
        
    enum Gets: Endpoint {
        case meals
        case filterMeals
        case lookup
        case search
        
        public var url: String {
            switch self {
            case .meals: return "\(API.baseUrl)categories.php"
            case .filterMeals: return "\(API.baseUrl)filter.php?c="
            case .lookup: return "\(API.baseUrl)lookup.php?i="
            case .search: return "\(API.baseUrl)search.php?s="
            }
        }
    }
    
}
