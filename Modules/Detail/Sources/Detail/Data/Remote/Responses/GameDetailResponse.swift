//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 26/05/24.
//

import Foundation

public struct GameDetailResponse: Codable {
    public let id: Int
    public let name: String
    public let released: Date
    public let backgroundImage: String
    public let rating: Float
    public let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case description
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dateString = try container.decode(String.self, forKey: .released)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        released = dateFormatter.date(from: dateString)!
        
        let rawDesc = try container.decode(String.self, forKey: .description)
        let formattedDesc = rawDesc.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        description = formattedDesc
        
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.backgroundImage = try container.decode(String.self, forKey: .backgroundImage)
        self.rating = try container.decode(Float.self, forKey: .rating)
    }
}
