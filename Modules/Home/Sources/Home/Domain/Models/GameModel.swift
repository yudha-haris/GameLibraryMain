//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 27/05/24.
//
import UIKit
import GameLibraryCore

public struct GameModel: Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let released: Date
    public let backgroundImage: String
    public let rating: Float
    
    public var image: UIImage?
    public var state: DownloadState = .new
    
    public init(id: Int, name: String, released: Date, backgroundImage: String, rating: Float, image: UIImage? = nil, state: DownloadState = .new) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.image = image
        self.state = state
    }
    
    public func copyWith(image: UIImage? = nil, state: DownloadState = .new) -> GameModel {
        return GameModel(
            id: self.id,
            name: self.name,
            released: self.released,
            backgroundImage: self.backgroundImage,
            rating: self.rating,
            image: image,
            state: state
        )
    }
}
