//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 27/05/24.
//

import Foundation

import Foundation

let filePath = Bundle.main.path(forResource: "RAWRIO-Info", ofType: "plist")

struct HomeAPI {
    public static let baseUrl = "https://api.rawg.io/api/"
    public static let apiKey = NSDictionary(contentsOfFile: filePath ?? "")?.object(forKey: "API_KEY") as? String
}

protocol HomeEndpoint {
    var url: String { get }
}

enum HomeEndpoints {
    public enum Gets: HomeEndpoint {
        case games
        
        public var url: String {
            switch self {
            case .games: return "\(HomeAPI.baseUrl)games"
            }
        }
    }
}
