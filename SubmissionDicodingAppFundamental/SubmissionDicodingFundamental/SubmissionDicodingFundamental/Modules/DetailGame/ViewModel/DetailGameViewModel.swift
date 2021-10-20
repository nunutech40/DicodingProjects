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
    var ifThisFav: Bool = false
    
    func setupDetailGame(_ sender: DetailGameViewController) {
        sender.gameCategoryLabel.text = dataDetail.name
        sender.gameDescLabel.text = dataDetail.descriptionRaw
        if let strUrl = dataDetail.backgroundImage {
            MainHelper.setImage(sender.imageDetailGame, strUrl, UIImage(named: "noImage")!)
        }
        
        var genres = [String]()
        for genre in dataDetail.genres ?? [] where genre.name?.isEmpty == false {
            genres.append(genre.name ?? "")
        }
        sender.ggameGenreLabel.text = genres.joined(separator: ", ")
    }
}
