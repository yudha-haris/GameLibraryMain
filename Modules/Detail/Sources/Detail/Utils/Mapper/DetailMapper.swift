//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 27/05/24.
//

import Foundation
import GameLibraryCore

class DetailMapper {
    static func mapGameDetailResponseToDomain(_ response: GameDetailResponse) -> GameDetail {
        GameDetail(
            id: response.id,
            name: response.name,
            released: response.released,
            backgroundImage: response.backgroundImage,
            rating: response.rating,
            description: response.description
        )
    }
}
