//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 27/05/24.
//

import Foundation

class HomeMapper {
    static func mapGameResponseToDomain(_ response: GameResponse) -> GameModel {
        GameModel(
            id: response.id,
            name: response.name,
            released: response.released,
            backgroundImage: response.backgroundImage,
            rating: response.rating)
    }
    
    static func mapListGameResponseToDomain(_ response: [GameResponse]) -> [GameModel] {
        return response.map { result in
            return mapGameResponseToDomain(result)
        }
    }
}
