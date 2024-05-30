//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 27/05/24.
//

import Foundation

struct DetailAPI {
    public static let baseUrl = "https://api.rawg.io/api/"
    public static let apiKey = ""
}

protocol DetailEndpoint {
    var url: String { get }
}

enum DetailEndpoints {
    public enum Gets: DetailEndpoint {
        case game
        
        public var url: String {
            switch self {
            case .game: return "\(DetailAPI.baseUrl)games/"
            }
        }
    }
}
