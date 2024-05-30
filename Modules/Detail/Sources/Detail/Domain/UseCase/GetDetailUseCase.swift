//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 27/05/24.
//

import Foundation
import GameLibraryCore

public protocol DetailUseCase {
    func getGame(_ id: Int, completion: @escaping (Result<GameDetail, Error>) -> Void)
}

public class DetailInteractor: DetailUseCase {
    private let repository: DetailRepository
    
    public required init(repository: DetailRepository) {
        self.repository = repository
    }
    
    public func getGame(_ id: Int, completion: @escaping (Result<GameDetail, any Error>) -> Void) {
        repository.getGame(id) { result in
            completion(result)
        }
    }
}
