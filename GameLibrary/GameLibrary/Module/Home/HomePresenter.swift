//
//  HomePresenter.swift
//  GameLibrary
//
//  Created by Yudha Haris Purnama on 20/05/24.
//

import Foundation
import RxRelay
import GameLibraryCore
import Home

protocol HomePresenterProtocol {
    func getGames()
}

class HomePresenter: HomePresenterProtocol {
    private let useCase: GetListGameUseCase
    public let games = BehaviorRelay<Result<[GameModel], Error>>(value: .success([]))
    
    init(useCase: GetListGameUseCase) {
        self.useCase = useCase
    }
    
    func getGames() {
        useCase.execute { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.games.accept(.success(data))
                case .failure(let error):
                    self.games.accept(.failure(error))
                }
            }
        }
    }
}
