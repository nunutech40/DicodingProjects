//
//  GameProvider.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 10/10/21.
//

import UIKit
import CoreData

struct GameFavModel {
    let id: Int?
    let slug: String?
    let name: String?
    let backgroundImage: Data?
    let rating: Double?
    let genres: String?
    let released: String?
    let favoritesStatus: Bool?
}

class GameProvider {
    
    func addToFav(
        _ id: Int,
        _ name: String,
        _ slug: String,
        _ rating: Double,
        _ released: String,
        _ backgroundImage: Data,
        _ favoritesStatus: Bool,
        _ genres: String,
        completion: @escaping() -> Void
    ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Games", in: managedContext) {
                let games = NSManagedObject(entity: entity, insertInto: managedContext)
                
                games.setValue(id, forKeyPath: "id")
                games.setValue(name, forKeyPath: "name")
                games.setValue(rating, forKeyPath: "rating")
                games.setValue(released, forKeyPath: "released")
                games.setValue(slug, forKeyPath: "slug")
                games.setValue(backgroundImage, forKeyPath: "backgroundImage")
                games.setValue(favoritesStatus, forKeyPath: "favoritesStatus")
                games.setValue(genres, forKeyPath: "genres")
                print("set games addtofav")
                do {
                    try managedContext.save()
                    print("cek after save games add tofav")
                    completion()
                } catch let error as NSError {
                    print("Tida bisa menambahkan add to fav. Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func getAllFavGames(completion: @escaping(_ members: [GameFavModel]) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // 1.
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Games")
            do {
                let results = try managedContext.fetch(fetchRequest)
                var games: [GameFavModel] = []
                for result in results {
                    let game = GameFavModel(
                        id: result.value(forKeyPath: "id") as? Int,
                        slug: result.value(forKeyPath: "slug") as? String,
                        name: result.value(forKeyPath: "name") as? String,
                        backgroundImage: result.value(forKey: "backgroundImage") as? Data,
                        rating: result.value(forKeyPath: "rating") as? Double,
                        genres: result.value(forKey: "genres") as? String,
                        released: result.value(forKeyPath: "released") as? String,
                        favoritesStatus: result.value(forKey: "favoritesStatus") as? Bool
                    )
                    games.append(game)
                }
                completion(games)
            } catch let error as NSError {
                print("Could not fetch games. \(error), \(error.userInfo)")
            }
        }
    }

    func checkFav(_ id: Int, completion: @escaping(_ status: Bool) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Games")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if let result = try managedContext.fetch(fetchRequest).first {
                    completion(true)
                } else {
                    completion(false)
                }
            } catch let error as NSError {
                print("Error get data. \(error), \(error.userInfo)")
            }
        }
    }

    func deleteFavGames(_ id: Int, completion: @escaping() -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? managedContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }

}
