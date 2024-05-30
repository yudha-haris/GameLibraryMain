//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 27/05/24.
//

import Foundation

public struct GameResponse: Codable {
    public let id: Int
    public let name: String
    public let released: Date
    public let backgroundImage: String
    public let rating: Float
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dateString = try container.decode(String.self, forKey: .released)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        released = dateFormatter.date(from: dateString)!
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.backgroundImage = try container.decode(String.self, forKey: .backgroundImage)
        self.rating = try container.decode(Float.self, forKey: .rating)
    }
}
