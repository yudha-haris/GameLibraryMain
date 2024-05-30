//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 26/05/24.
//

import Foundation
import GameLibraryCore
import Detail

public protocol AddFavoriteGameUseCase {
    func execute(_ game: GameDetail, completion: @escaping (Result<Bool, DatabaseError>) -> Void)
}

public class AddFavoriteGameInteractor: AddFavoriteGameUseCase {
    private let repository: FavoriteRepositoryProtocol
    
    public init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(_ game: GameDetail, completion: @escaping (Result<Bool, DatabaseError>) -> Void) {
        repository.addFavoriteGame(game) { result in
            completion(result)
        }
    }
}
