//
//  GameListMapper.swift
//  GameKatalog
//
//  Created by mac on 19/10/21.
//

import Foundation

final class GameListMapper {
    
    static func mapGameResponsesToDomains(input gameResponses: [GameResponse]) -> [GameModel] {
        
        return gameResponses.map { result in
            return GameModel(
                id: result.id ?? 0,
                slug: result.slug ?? "",
                name: result.name ?? "",
                released: result.released ?? "",
                backgroundImage: result.backgroundImage ?? "",
                rating: result.rating ?? 0.0,
                ratingTop: result.ratingTop ?? 0.0,
                genres: result.genres)
        }
    }
    
}

