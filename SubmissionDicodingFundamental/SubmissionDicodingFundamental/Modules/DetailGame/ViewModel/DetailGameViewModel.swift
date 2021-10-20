//
//  DetailGameViewModel.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 4/10/21.
//

import UIKit

class DetailGameViewModel {
    
    var dataDetail: DetailGameModel!
    var categoryGames: String!
    var idGame: Int!
    
    func setupDetailGame(_ sender: DetailGameViewController) {
        sender.gameCategoryLabel.text = categoryGames
        sender.gameDescLabel.text = dataDetail.redditDescription
        if let strUrl = dataDetail.backgroundImage {
            MainHelper.setImage(sender.imageDetailGame, strUrl, UIImage(named: "noImage")!)
        }
        
        var genres = [String]()
        for i in dataDetail.genres ?? [] where i.name?.isEmpty == false {
            genres.append(i.name ?? "")
        }
        sender.ggameGenreLabel.text = genres.joined(separator: ", ")
    }
}
