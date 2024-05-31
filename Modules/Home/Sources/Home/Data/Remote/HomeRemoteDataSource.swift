//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 27/05/24.
//

import Foundation
import Alamofire

public protocol HomeRemoteDataSourceProtocol: AnyObject {
    func getGames(result: @escaping (Result<[GameResponse], URLError>) -> Void)
}

public final class HomeRemoteDataSource: NSObject {
    private override init() {}
    
    public static let sharedInstance: HomeRemoteDataSource =  HomeRemoteDataSource()
}

extension HomeRemoteDataSource: HomeRemoteDataSourceProtocol {
    public func getGames(result: @escaping (Result<[GameResponse], URLError>) -> Void) {
        guard let url = URL(string: HomeEndpoints.Gets.games.url) else { return }
        
        let parameters: [String: String] = [
            "key": HomeAPI.apiKey ?? ""
        ]
        
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: PaginationResponse<GameResponse>.self) { response in
                
                switch response.result {
                case .success(let value): result(.success(value.results))
                case .failure: result(.failure(.init(.badServerResponse)))
                }
            }
    }
}
