//
//  Endpoints.swift
//  SubmissionDicodingFundamental
//
//  Created by mac on 8/10/21.
//

import UIKit

public enum Endpoints {
    static let key = "dde5e8d50a7b45c39e751473a338180a"
    static let base = "https://api.rawg.io/api/games"
    case getGameList(String)
    case search(String, String)
    case getTwoFav(Int)
    case getGameDetail(String)
    
    var url: URL {
        return URL(string: stringValue)!
    }
    
    var stringValue: String {
        switch self {
        case .getGameList(let page):
            return Endpoints.base + "?key=\(Endpoints.key)&page=\(page)&page_size=100"
        case .search(let page, let query):
            return Endpoints.base +  "?key=\(Endpoints.key)&page=\(page)&page_size=10&search=\(query.replacingOccurrences(of: " ", with: "%20"))"
        case .getTwoFav(let page):
            return Endpoints.base + "?key=\(Endpoints.key)&page=\(page)&page_size=10"
        case .getGameDetail(let idGame):
            return Endpoints.base + "/\(idGame)?key=\(Endpoints.key)"
        }
    }
}
