//
//  GameModel.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 2/10/21.
//

struct GameModel: Decodable {
    let count: Int?
    let results: [GameData]?
}

struct GameData: Decodable {
    let id: Int?
    let slug: String?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let genres: [GenreGames]?
}

struct GenreGames: Decodable {
    let id: Int?
    let name: String?
}
