//
//  DashboardGameViewModel.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 2/10/21.
//

import UIKit

class DashboardGameViewModel {
    
    var dataModel = [GameData]()
    var page: Int = 1
    var isHasLoad = false
    
    func fetchCellRecommGame(_ sender: DashboardGameViewController, _ indexPath: IndexPath, _ reusableCell: UITableViewCell) {
        let data = self.dataModel[indexPath.row]
        if let cell = reusableCell as? RecommendedCell {
            cell.mainView.customRounded(AppConfig.ROUND_PRIMARY)
            cell.rateLabel.text = String(data.rating ?? 0.0)
            var genres = [String]()
            for i in data.genres ?? [] where i.name?.isEmpty == false {
                genres.append(i.name ?? "")
            }
            cell.genreLabel.text = genres.joined(separator: ", ")
            let url = data.backgroundImage ?? ""
            MainHelper.setImage(cell.imageRecomendedGame, url, UIImage(named: "noImage")!)
            cell.titleLabel.text = data.name
            cell.releaseDate.text = data.released
        }
    }
    
    func getTwoBestGame(data: [GameData]) -> [GameData] {
        
        var twoData = [GameData]()
        
        if data.count > 2 {
            twoData = Array(data[0...1])
        }
        
        return twoData
    }
    
    func setupBestGame(_ sender: DashboardGameViewController, data: [GameData]) {
        
        let data = self.getTwoBestGame(data: data)
        guard data.count >= 2 else {
            sender.bestGameMainView1.isHidden = true
            sender.bestGameMainView2.isHidden = true
            return
        }
        
        // setup bestgame 1
        MainHelper.setImage(sender.imageBestGame1, data[0].backgroundImage ?? "", UIImage(named: "noImage")!)
        sender.rateLabelBestGame1.text = String(data[0].rating ?? 0.0)
        var genres1 = [String]()
        for i in data[0].genres ?? [] where i.name?.isEmpty == false {
            genres1.append(i.name ?? "")
        }
        sender.genreLabelBestGame1.text = genres1.joined(separator: ", ")
        sender.titleBestGame1.text = data[0].name
        
        // setup bestgame2
        MainHelper.setImage(sender.imageBestGame2, data[1].backgroundImage ?? "", UIImage(named: "noImage")!)
        sender.rateLabelBestGame2.text = String(data[1].rating ?? 0.0)
        var genres2 = [String]()
        for i in data[1].genres ?? []  where i.name?.isEmpty == false {
            genres2.append(i.name ?? "")
        }
        sender.genreLabelBestGame2.text = genres1.joined(separator: ", ")
        sender.titleBestGame2.text = data[1].name
    }
    
}
