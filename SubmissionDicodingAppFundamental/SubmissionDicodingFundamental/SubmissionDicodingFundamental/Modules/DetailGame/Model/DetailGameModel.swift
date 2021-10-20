//
//  DetailGameModel.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 4/10/21.
//

struct DetailGameModel: Decodable {
    let id: Int?
    let slug: String?
    let name: String?
    let name_original: String?
    let descriptionRaw: String?
    let backgroundImage: String?
    let rating: Double?
    let genres: [GenreGames]?
    let website: String?
    let released: String?
}
