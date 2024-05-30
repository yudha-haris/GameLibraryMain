//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 27/05/24.
//

import Foundation

import Foundation

struct HomeAPI {
    public static let baseUrl = "https://api.rawg.io/api/"
    public static let apiKey = ""
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
