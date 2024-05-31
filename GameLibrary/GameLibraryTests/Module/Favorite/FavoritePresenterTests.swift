//
//  FavoritePresenterTests.swift
//  GameLibraryTests
//
//  Created by Yudha Haris Purnama on 31/05/24.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import GameLibrary
@testable import Favorite
@testable import Home
@testable import GameLibraryCore

class MockGetListFavoriteGamesUseCase: GetListFavoriteGamesUseCase {
    var result: Result<[GameModel], DatabaseError>?
    
    func execute(completion: @escaping (Result<[GameModel], DatabaseError>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}

final class FavoritePresenterTests: XCTestCase {
    var presenter: FavoritePresenter!
    var mockUseCase: MockGetListFavoriteGamesUseCase!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockUseCase = MockGetListFavoriteGamesUseCase()
        presenter = FavoritePresenter(useCase: mockUseCase)
        disposeBag = DisposeBag()
        
    }

    override func tearDownWithError() throws {
        disposeBag = nil
        presenter = nil
        mockUseCase = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetFavoriteGamesSuccess() {
        // Arrange
        let expectedGames = [
            GameModel(id: 1, name: "Test Game 1", released: Date(), backgroundImage: "url1", rating: 4.5),
            GameModel(id: 2, name: "Test Game 2", released: Date(), backgroundImage: "url2", rating: 4.0)
        ]
                
        mockUseCase.result = Result<[GameModel], DatabaseError>.success(expectedGames)
                
        let scheduler = TestScheduler(initialClock: 0)
        let observer: TestableObserver<Result<[GameModel], any Error>> = scheduler.createObserver(Result<[GameModel], Error>.self)
        presenter.games.asObservable().subscribe(observer).disposed(by: disposeBag)
                
        // Act
        presenter.getFavoriteGames()
        scheduler.start()
                
        // Assert
        let expectedEvents: [Recorded<Event<Result<[GameModel], any Error>>>] = [
            Recorded.next(0, Result.success(expectedGames))
        ]
        XCTAssertEqual(observer.events.count, expectedEvents.count)
    }
        
    func testGetFavoriteGamesFailure() {
            // Arrange
        let expectedError = DatabaseError.init(message: "")
            mockUseCase.result = .failure(expectedError)
            
            let observer = TestScheduler(initialClock: 0).createObserver(Result<[GameModel], Error>.self)
            presenter.games.asObservable().subscribe(observer).disposed(by: disposeBag)
            
            // Act
            presenter.getFavoriteGames()
            
            // Assert
            let expectedEvents: [Recorded<Event<Result<[GameModel], any Error>>>] = [
                Recorded.next(0, Result.failure(expectedError))
            ]
        XCTAssertEqual(observer.events.count, expectedEvents.count)
        }
}

func ==<T: Equatable>(lhs: Recorded<Event<T>>, rhs: Recorded<Event<T>>) -> Bool {
    return lhs.time == rhs.time && lhs.value.element == rhs.value.element
}

extension Recorded where Value: Equatable {
    static func == (lhs: Recorded<Value>, rhs: Recorded<Value>) -> Bool {
        return lhs.time == rhs.time && lhs.value == rhs.value
    }
}
