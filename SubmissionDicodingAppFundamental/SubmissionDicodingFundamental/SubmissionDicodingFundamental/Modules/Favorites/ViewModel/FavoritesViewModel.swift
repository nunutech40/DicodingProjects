//
//  FavoritesViewModel.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 10/10/21.
//

import UIKit

class FavoritesViewModel {
    
    var dataModel = [GameFavModel]()
    
    func fetchCellRecommGame(_ sender: FavoritesViewController, _ indexPath: IndexPath, _ reusableCell: UITableViewCell) {
        let data = dataModel[indexPath.row]
        
        if let cell = reusableCell as? RecommendedCell {
            cell.mainView.customRounded(AppConfig.ROUND_PRIMARY)
            cell.rateLabel.text = String(data.rating ?? 0.0)
            cell.genreLabel.text = data.genres
            let image = UIImage(data: data.backgroundImage!)
            cell.imageRecomendedGame.image = image
            cell.titleLabel.text = data.name
            cell.releaseDate.text = data.released
        }
    }
    
}
