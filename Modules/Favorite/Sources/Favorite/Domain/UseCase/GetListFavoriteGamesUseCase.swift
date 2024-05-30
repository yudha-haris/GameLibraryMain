//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 26/05/24.
//

import Foundation
import GameLibraryCore
import Home

public protocol GetListFavoriteGamesUseCase {
    func execute(completion: @escaping (Result<[GameModel], DatabaseError>) -> Void)
}

public class GetListFavoriteGamesInteractor: GetListFavoriteGamesUseCase {
    private let repository: FavoriteRepositoryProtocol
    
    public init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(completion: @escaping (Result<[GameModel], DatabaseError>) -> Void) {
        repository.getFavoriteGames { result in
            completion(result)
        }
    }
}

