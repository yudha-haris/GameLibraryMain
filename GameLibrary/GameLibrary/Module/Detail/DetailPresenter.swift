//
//  DetailPresenter.swift
//  GameLibrary
//
//  Created by Yudha Haris Purnama on 21/05/24.
//

import Foundation
import RxRelay
import GameLibraryCore
import Favorite
import Detail

protocol DetailPresenterProtocol {
    func getGame(_ id: Int)
    func addFavoriteGame(completion: @escaping (Bool) -> Void)
    func deleteFavoriteGame(completion: @escaping (Bool) -> Void)
    func getFavoriteGame(_ id: Int)
}

class DetailPresenter: DetailPresenterProtocol {

    private let detailUseCase: DetailUseCase
    private let addFavoriteUseCase: AddFavoriteGameUseCase
    private let removeFavoriteUseCase: RemoveFavoriteGameUseCase
    private let getFavoriteUseCase: GetFavoriteGameUseCase
    
    private var gameCache: GameDetail?
    
    public let game = BehaviorRelay<Result<GameDetail?, Error>>(value: .success(nil))
    public let isFavorite = BehaviorRelay<Bool>(value: false)
    
    init(detailUseCase: DetailUseCase, addFavoriteUseCase: AddFavoriteGameUseCase, removeFavoriteUseCase: RemoveFavoriteGameUseCase, getFavoriteUseCase: GetFavoriteGameUseCase) {
        self.detailUseCase = detailUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
        self.removeFavoriteUseCase = removeFavoriteUseCase
        self.getFavoriteUseCase = getFavoriteUseCase
    }
    
    func getFavoriteGame(_ id: Int) {
        getFavoriteUseCase.execute("\(id)") { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.isFavorite.accept(true)
                case .failure(_):
                    self.isFavorite.accept(false)
                }
            }
        }
    }
    
    func addFavoriteGame(completion: @escaping (Bool) -> Void) {
        if(gameCache == nil) {
            return
        }
        addFavoriteUseCase.execute(gameCache!) { [weak self] result in
            guard self != nil else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    completion(true)
                case .failure(_):
                    completion(false)
                }
            }
            
        }
    }
    
    func deleteFavoriteGame(completion: @escaping (Bool) -> Void) {
        if(gameCache == nil) {
            return
        }
        removeFavoriteUseCase.execute(gameCache!) { [weak self] result in
            guard self != nil else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    completion(true)
                case .failure(_):
                    completion(false)
                }
            }
            
        }
    }
    
    func getGame(_ id: Int) {
        detailUseCase.getGame(id) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.gameCache = data
                    self.game.accept(.success(data))
                case .failure(let error):
                    self.game.accept(.failure(error))
                }
            }
        }
    }
}
