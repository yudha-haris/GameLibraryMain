//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 26/05/24.
//

import GameLibraryCore
import Detail
import Home
import UIKit

class FavoriteMapper {
    
    static func mapGameEntityToDomain(_ entity: GameEntity) -> GameModel {
        let dateString = entity.released
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let released = dateFormatter.date(from: dateString)!
        
        return GameModel(
            id: Int(entity.id) ?? 0,
            name: entity.name,
            released: released,
            backgroundImage: "",
            rating: entity.rating,
            image: UIImage(data: entity.image!),
            state: DownloadState.downloaded)
    }
    
    static func mapListGameEntityToDomain(_ response: [GameEntity]) -> [GameModel] {
        return response.map { result in
            return mapGameEntityToDomain(result)
        }
    }
    
    static func mapDomainToEntity(_ model: GameDetail) -> GameEntity {
        let entity = GameEntity()
        entity.id = "\(model.id)"
        entity.name = model.name
        entity.released = CustomDateFormatter.toMMMdYYYY(date: model.released)
        entity.rating = model.rating
        entity.desc = model.description
        entity.image = model.image == nil ? nil : model.image!.pngData()! as Data
        
        return entity
    }
}
