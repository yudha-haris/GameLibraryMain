//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 26/05/24.
//

import Foundation
import Alamofire

public protocol DetailRemoteDataSourceProtocol: AnyObject {
    func getGame(_ id: Int, result: @escaping (Result<GameDetailResponse, URLError>) -> Void)
}

public class DetailRemoteDataSource: DetailRemoteDataSourceProtocol {
    
    public static let sharedInstance: DetailRemoteDataSource = DetailRemoteDataSource()
    
    public func getGame(_ id: Int, result: @escaping (Result<GameDetailResponse, URLError>) -> Void) {
        guard let url = URL(string: "\(DetailEndpoints.Gets.game.url)\(id)") else { return }
        
        let parameters: [String: String] = [
            "key": DetailAPI.apiKey
        ]
        
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: GameDetailResponse.self) { response in
                
                switch response.result {
                    
                case .success(let value):
                    result(.success(value))
                case .failure(_):
                    result(.failure(.init(.badServerResponse)))
                }
                
            }
    }
}
