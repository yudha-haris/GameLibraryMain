//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 26/05/24.
//

import Foundation
import RealmSwift
import GameLibraryCore

public protocol LocaleDataSourceProtocol: AnyObject {
    func getFavoriteGames(result: @escaping (Result<[GameEntity], DatabaseError>) -> Void)
    func addFavoriteGame(_ game: GameEntity, result: @escaping (Result<Bool, DatabaseError>) -> Void)
    func removeFavoriteGame(_ game: GameEntity, result: @escaping (Result<Bool, DatabaseError>) -> Void)
    func getFavoriteById(_ id: String, result: @escaping (Result<GameEntity, DatabaseError>) -> Void)
}

public class FavoriteLocalDataSource: LocaleDataSourceProtocol {
    public let realm: Realm?
    
    public init(realm: Realm?) {
        self.realm = realm
    }
    
    public static let sharedInstance: (Realm?) -> FavoriteLocalDataSource = {
            realmDatabase in return FavoriteLocalDataSource(realm: realmDatabase)
    }
    
    public func addFavoriteGame(_ game: GameEntity, result: @escaping (Result<Bool, DatabaseError>) -> Void) {
        if let realm = realm {
            do {
                try realm.write {
                    realm.add(game, update: .all)
                }
                result(.success(true))
            } catch {
                result(.failure(DatabaseError(message: error.localizedDescription)))
            }
        } else {
            result(.failure(DatabaseError(message: "Database Bermasalah")))
        }
    }
    
    public func removeFavoriteGame(_ game: GameEntity, result: @escaping (Result<Bool, DatabaseError>) -> Void) {
        if let realm = realm {
            do {
                try realm.write {
                    if let game = realm.object(ofType: GameEntity.self, forPrimaryKey: game.id) {
                        realm.delete(game)
                    } else {
                        result(.failure(DatabaseError(message: "Game Tidak Ditemukan")))
                    }
                }
                result(.success(true))
            } catch {
                result(.failure(DatabaseError(message: error.localizedDescription)))
            }
        } else {
            result(.failure(DatabaseError(message: "Database Bermasalah")))
        }
    }
    
    public func getFavoriteGames(result: @escaping (Result<[GameEntity], DatabaseError>) -> Void) {
        if let realm = realm {
            let games: Results<GameEntity> = {
                realm.objects(GameEntity.self)
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            result(.success(games.toArray(ofType: GameEntity.self)))
        } else {
            result(.failure(DatabaseError(message: "Database Bermasalah")))
        }
    }
    
    public func getFavoriteById(_ id: String, result: @escaping (Result<GameEntity, DatabaseError>) -> Void) {
        if let realm = realm {
            if let game = realm.object(ofType: GameEntity.self, forPrimaryKey: id) {
                result(.success(game))
            } else {
                result(.failure(DatabaseError(message: "Game Tidak Ditemukan")))
            }
        } else {
            result(.failure(DatabaseError(message: "Database Bermasalah")))
        }
    }
}
