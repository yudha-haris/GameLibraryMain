//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 26/05/24.
//

import Foundation

import Foundation
import GameLibraryCore
import Home

public protocol GetFavoriteGameUseCase {
    func execute(_ id: String, completion: @escaping (Result<GameModel, DatabaseError>) -> Void)
}

public class GetFavoriteGameInteractor: GetFavoriteGameUseCase {
    private let repository: FavoriteRepositoryProtocol
    
    public init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(_ id: String, completion: @escaping (Result<GameModel, DatabaseError>) -> Void) {
        repository.getFavoriteById(id) { result in
            completion(result)
        }
    }
}
