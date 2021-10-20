//
//  MealsDataSource.swift
//  MealsAppCustom
//
//  Created by mac on 12/10/21.
//

import Foundation

protocol MealsDataSourceProtocol: class {
    
    func getMeals(result: @escaping (Result<[MealResponse], URLError>) -> Void)
    
}

final class MealsDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: MealsDataSource = MealsDataSource()
}

extension MealsDataSource: MealsDataSourceProtocol {
    
    func getMeals(result: @escaping (Result<[MealResponse], URLError>) -> Void) {
        
        guard let url = URL(string: Endpoints.Gets.meals.url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let meals = try decoder.decode(MealsResponse.self, from: data).categories
                    result(.success(meals))
                } catch {
                    result(.failure(.invalidResponse))
                }
            }
            
        }
        task.resume()
        
    }
    
}
