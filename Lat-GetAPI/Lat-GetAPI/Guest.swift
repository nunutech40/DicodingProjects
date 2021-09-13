//
//  Guest.swift
//  Lat-GetAPI
//
//  Created by mac on 13/9/21.
//

import UIKit

let apiKey = "3a5523320856fb0b9d7ad8812f94feba"

struct Guest: Codable {
    let success: Bool
    let guestSessionId: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case guestSessionId = "guest_session_id"
    }
}
