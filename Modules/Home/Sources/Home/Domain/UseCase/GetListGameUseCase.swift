//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 27/05/24.
//

import Foundation

public protocol GetListGameUseCase {
    func execute(completion: @escaping (Result<[GameModel], Error>) -> Void)
}

public class GetListGameInteractor: GetListGameUseCase {
    private let repository: HomeRepositoryProtocol
    
    public required init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(completion: @escaping (Result<[GameModel], any Error>) -> Void) {
        repository.getGames { result in
            completion(result)
        }
    }
    
}
