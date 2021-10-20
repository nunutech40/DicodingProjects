//
//  DashboardGameService.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 3/10/21.
//

import UIKit
import Alamofire

extension DashboardGameViewController {
    
    func getGames(page: String, completion: @escaping (PageList) -> Void) {
        let strUrl = "https://api.rawg.io/api/games?key=dde5e8d50a7b45c39e751473a338180a&page=\(page)&page_size=10"
        
        ReqHelper.request(self, strUrl, method: .get) { (resModel) in
            if resModel.success {
                do{
                    let model  = try MainHelper.getDecoder().decode(GameModel.self, from: resModel.data)
                    completion(PageList(status: true, dataList: model.results ?? []))
                } catch let error{
                    print(error)
                    let alert = UIAlertController(title: "Error Load Data", message: error.localizedDescription.description, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    completion(PageList(status: false, dataList: []))
                }
            } else {
                completion(PageList(status: false, dataList: []))
                let alert = UIAlertController(title: "Error Load Data", message: "status code: \(resModel.resCode)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

    }
    
    func getGamesSearch(page: String, text: String, completion: @escaping (PageList) -> Void) {
        let strUrl = "https://api.rawg.io/api/games?key=dde5e8d50a7b45c39e751473a338180a&page=\(page)&page_size=10&search=\(text.replacingOccurrences(of: " ", with: "%20"))"
        
        ReqHelper.request(self, strUrl, method: .get) { (resModel) in
            if resModel.success {
                do{
                    let model  = try MainHelper.getDecoder().decode(GameModel.self, from: resModel.data)
                    completion(PageList(status: true, dataList: model.results ?? []))
                } catch let error{
                    print(error)
                    let alert = UIAlertController(title: "Error Load Data", message: error.localizedDescription.description, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    completion(PageList(status: false, dataList: []))
                }
            } else {
                completion(PageList(status: false, dataList: []))
                let alert = UIAlertController(title: "Error Load Data", message: "status code: \(resModel.resCode)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

    }
    
    func getTwoFav(completion: @escaping (PageList) -> Void) {
        let page = 1
        let strUrl = "https://api.rawg.io/api/collections/lists/popular?key=dde5e8d50a7b45c39e751473a338180a&page=\(page)&page_size=10"
        
        ReqHelper.request(self, strUrl, method: .get) { (resModel) in
            if resModel.success {
                do{
                    let model  = try MainHelper.getDecoder().decode(GameModel.self, from: resModel.data)
                    completion(PageList(status: true, dataList: model.results ?? []))
                } catch let error{
                    print(error)
                    let alert = UIAlertController(title: "Error Load Data", message: error.localizedDescription.description, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    completion(PageList(status: false, dataList: []))
                }
            } else {
                completion(PageList(status: false, dataList: []))
                let alert = UIAlertController(title: "Error Load Data", message: "status code: \(resModel.resCode)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

    }
    
}

struct PageList {
    var status: Bool?
    var dataList: [GameData]?
}
