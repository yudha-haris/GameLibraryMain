//
//  Injection.swift
//  GameLibrary
//
//  Created by Yudha Haris Purnama on 26/05/24.
//

import Foundation

class AppInjection {
    static func provideFavoritePresenter() -> FavoritePresenter {
        let useCase = Injection.init().provideGetListFavoriteGame()
        return FavoritePresenter(useCase: useCase)
    }
    
    static func provideDetailPresenter() -> DetailPresenter {
        return DetailPresenter(
            detailUseCase: Injection.init().provideDetailUseCase(),
            addFavoriteUseCase: Injection.init().provideAddFavoriteGame(),
            removeFavoriteUseCase: Injection.init().provideRemoveFavoriteGame(),
            getFavoriteUseCase: Injection.init().provideGetFavoriteGame())
    }
    
    static func provideHomePresenter() -> HomePresenter {
        return HomePresenter(useCase: Injection.init().provideGetListGameUseCase())
    }
}
