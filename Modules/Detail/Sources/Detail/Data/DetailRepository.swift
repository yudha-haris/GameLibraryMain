//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 26/05/24.
//

import Foundation

public protocol DetailRepositoryProtocol {
    func getGame(_ id: Int, result: @escaping (Result<GameDetail, Error>) -> Void)
}

public final class DetailRepository: NSObject {
    public typealias DetailInstance = (DetailRemoteDataSource) -> DetailRepository
    
    private let _remote: DetailRemoteDataSource
    
    public init(remote: DetailRemoteDataSource) {
        self._remote = remote
    }
    
    public static let sharedInstance: DetailInstance = {
        remoteRepo in return DetailRepository(remote: remoteRepo)
    }
}

extension DetailRepository: DetailRepositoryProtocol {
    
    public func getGame(_ id: Int, result: @escaping (Result<GameDetail, Error>) -> Void) {
        _remote.getGame(id) { response in
            switch response {
            case .success(let data):
                let gameDetail = DetailMapper.mapGameDetailResponseToDomain(data)
                result(.success(gameDetail))
            case .failure(let error):
                result(.failure(error))
            }
            
        }
    }
}
