//
//  GameModel.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 2/10/21.
//

import UIKit

struct GameModel: Decodable {
    var count: Int?
    var results: [GameData]?
}

struct GameData: Decodable {
    var id: Int?
    var slug: String?
    var name: String?
    var released: String?
    var backgroundImage: String?
    var rating: Double?
    var ratingTop: Int?
    var genres: [GenreGames]?
}

struct GenreGames: Decodable {
    var id: Int?
    var name: String?
}
