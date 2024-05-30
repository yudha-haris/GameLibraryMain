//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 27/05/24.
//

import UIKit
import GameLibraryCore

public class GameDetail {
    
    public let id: Int
    public let name: String
    public let released: Date
    public let backgroundImage: String
    public let rating: Float
    public let description: String
    
    public var image: UIImage?
    public var state: DownloadState = .new
    
    public init(id: Int, name: String, released: Date, backgroundImage: String, rating: Float, description: String) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.description = description
    }
}
