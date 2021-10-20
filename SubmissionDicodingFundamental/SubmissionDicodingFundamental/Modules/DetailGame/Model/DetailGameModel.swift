//
//  DetailGameModel.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 4/10/21.
//

import UIKit

struct DetailGameModel: Decodable {
    var id: Int?
    var slug: String?
    var name: String?
    var name_original: String?
    var redditDescription: String?
    var backgroundImage: String?
    var rating: Double?
    var genres: [GenreGames]?
    var website: String?
}
