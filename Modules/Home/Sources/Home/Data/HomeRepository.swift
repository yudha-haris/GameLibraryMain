//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 27/05/24.
//

import Foundation

public protocol HomeRepositoryProtocol {
    func getGames(result: @escaping (Result<[GameModel], Error>) -> Void)
}

public final class HomeRepository: NSObject {
    public typealias HomeInstance = (HomeRemoteDataSource) -> HomeRepository
    
    fileprivate let remote: HomeRemoteDataSource
    
    public init(remote: HomeRemoteDataSource) {
        self.remote = remote
    }
    
    public static let sharedInstance: HomeInstance = {remoteRepo in
        return HomeRepository(remote: remoteRepo)
    }
}

extension HomeRepository: HomeRepositoryProtocol {
    
    public func getGames(result: @escaping (Result<[GameModel], any Error>) -> Void) {
        remote.getGames { response in
            switch response {
                case .success(let data):
                    let resultList = HomeMapper.mapListGameResponseToDomain(data)
                    result(.success(resultList))
                case .failure(let error):
                    result(.failure(error))
            }
        }
    }
    
    
}
