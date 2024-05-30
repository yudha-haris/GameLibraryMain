//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 26/05/24.
//

import Foundation
import GameLibraryCore
import Detail
import Home

public protocol FavoriteRepositoryProtocol {
    func getFavoriteGames(result: @escaping (Result<[GameModel], DatabaseError>) -> Void)
    func addFavoriteGame(_ game: GameDetail, result: @escaping (Result<Bool, DatabaseError>) -> Void)
    func removeFavoriteGame(_ game: GameDetail, result: @escaping (Result<Bool, DatabaseError>) -> Void)
    func getFavoriteById(_ id: String, result: @escaping (Result<GameModel, DatabaseError>) -> Void)
}

public final class FavoriteRepository: NSObject {
    public typealias FavoriteInstance = (FavoriteLocalDataSource) -> FavoriteRepository
    private let _locale: FavoriteLocalDataSource
    
    public init(locale: FavoriteLocalDataSource) {
        self._locale = locale
    }
    
    public static let sharedInstance: FavoriteInstance = {
        localeRepo in return FavoriteRepository(locale: localeRepo)
    }
    
    
}

extension FavoriteRepository: FavoriteRepositoryProtocol {
    public func getFavoriteById(_ id: String, result: @escaping (Result<GameModel, DatabaseError>) -> Void) {
        _locale.getFavoriteById(id) { response in
            switch response {
            case .success(let entity):
                let data = FavoriteMapper.mapGameEntityToDomain(entity)
                result(.success(data))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    public func addFavoriteGame(_ game: GameDetail, result: @escaping (Result<Bool, DatabaseError>) -> Void) {
        let entity = FavoriteMapper.mapDomainToEntity(game)
        _locale.addFavoriteGame(entity) { response in
            switch response {
            case .success(let success):
                result(.success(success))
            case .failure(let failure):
                result(.failure(failure))
            }
        }
    }
    
    public func removeFavoriteGame(_ game: GameDetail, result: @escaping (Result<Bool, DatabaseError>) -> Void) {
        let entity = FavoriteMapper.mapDomainToEntity(game)
        _locale.removeFavoriteGame(entity) { response in
            switch response {
            case .success(let success):
                result(.success(success))
            case .failure(let failure):
                result(.failure(failure))
            }
        }
    }
    
    public func getFavoriteGames(result: @escaping (Result<[GameModel], DatabaseError>) -> Void) {
        _locale.getFavoriteGames { response in
            switch response {
            case .success(let success):
                let data = FavoriteMapper.mapListGameEntityToDomain(success)
                result(.success(data))
            case .failure(let failure):
                result(.failure(failure))
            }
        }
    }
}
