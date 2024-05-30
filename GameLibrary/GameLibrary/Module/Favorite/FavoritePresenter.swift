//
//  FavoritePresenter.swift
//  GameLibrary
//
//  Created by Yudha Haris Purnama on 21/05/24.
//

import Foundation
import RxRelay
import Favorite
import GameLibraryCore
import Home

protocol FavoritePresenterProtocol {
    func getFavoriteGames()
}

class FavoritePresenter: FavoritePresenterProtocol {
    private let useCase: GetListFavoriteGamesUseCase
    public let games = BehaviorRelay<Result<[GameModel], Error>>(value: .success([]))
    
    init(useCase: GetListFavoriteGamesUseCase) {
        self.useCase = useCase
    }
    
    
    func getFavoriteGames() {
        useCase.execute { [weak self] result in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.games.accept(.success(data))
                case .failure(let fail):
                    self.games.accept(.failure(fail))
                }
            }
            
        }
    }
}
