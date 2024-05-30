//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 26/05/24.
//

import Foundation
import GameLibraryCore
import Detail

public protocol RemoveFavoriteGameUseCase {
    func execute(_ game: GameDetail, completion: @escaping (Result<Bool, DatabaseError>) -> Void)
}

public class RemoveFavoriteGameInteractor: RemoveFavoriteGameUseCase {
    private let repository: FavoriteRepositoryProtocol
    
    public init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(_ game: GameDetail, completion: @escaping (Result<Bool, DatabaseError>) -> Void) {
        repository.removeFavoriteGame(game) { result in
            completion(result)
        }
    }
}
