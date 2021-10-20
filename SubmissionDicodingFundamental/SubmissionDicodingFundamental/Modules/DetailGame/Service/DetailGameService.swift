//
//  DetailGameService.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 4/10/21.
//

import UIKit

extension DetailGameViewController {
    
    func getDetailGames(id: String, completion: @escaping (DetailGameModel) -> Void) {
        let strUrl = "https://api.rawg.io/api/games/\(id)?key=dde5e8d50a7b45c39e751473a338180a"
        
        ReqHelper.request(self, strUrl, method: .get) { (resModel) in
            if resModel.success {
                do{
                    let model  = try MainHelper.getDecoder().decode(DetailGameModel.self, from: resModel.data)
                    completion(model)
                } catch let error {
                    print("print error: \(error.localizedDescription)")
                    let alert = UIAlertController(title: "Error Load Data", message: error.localizedDescription.description, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Error Load Data", message: "status code: \(resModel.resCode)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

    }
    
}
