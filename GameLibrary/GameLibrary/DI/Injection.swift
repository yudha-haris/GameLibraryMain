//
//  Injection.swift
//  GameLibrary
//
//  Created by Yudha Haris Purnama on 20/05/24.
//

import Foundation
import RealmSwift
import Favorite
import Detail
import Home

final class Injection: NSObject {
    static var realm: Realm?
    
    // Home
    func provideHomeRepository() -> HomeRepositoryProtocol{
        let remote: HomeRemoteDataSource = HomeRemoteDataSource.sharedInstance
        
        return HomeRepository.sharedInstance(remote)
    }
    
    func provideGetListGameUseCase() -> GetListGameUseCase {
        return GetListGameInteractor(repository: provideHomeRepository())
    }
    
    // Detail
    func provideDetailRepository() -> DetailRepository {
        let remote: DetailRemoteDataSource = DetailRemoteDataSource.sharedInstance
        
        return DetailRepository.sharedInstance(remote)
    }
    
    func provideDetailUseCase() -> DetailUseCase {
        return DetailInteractor(repository: provideDetailRepository())
    }
    
    // Favorite
    func provideFavoriteRepository() -> FavoriteRepositoryProtocol {
        let realm = try? Realm()
        let locale: FavoriteLocalDataSource = FavoriteLocalDataSource.sharedInstance(realm)
        
        return FavoriteRepository.sharedInstance(locale)
    }
    
    // Favorite Use Case
    func provideGetListFavoriteGame() -> GetListFavoriteGamesUseCase {
        let repository = provideFavoriteRepository()
        return GetListFavoriteGamesInteractor(repository: repository)
    }
    
    func provideGetFavoriteGame() -> GetFavoriteGameUseCase {
        let repository = provideFavoriteRepository()
        return GetFavoriteGameInteractor(repository: repository)
    }
    
    func provideAddFavoriteGame() -> AddFavoriteGameUseCase {
        let repository = provideFavoriteRepository()
        return AddFavoriteGameInteractor(repository: repository)
    }
    
    func provideRemoveFavoriteGame() -> RemoveFavoriteGameUseCase {
        let repository = provideFavoriteRepository()
        return RemoveFavoriteGameInteractor(repository: repository)
    }
    
}

