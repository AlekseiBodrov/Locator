//
//  MainViewModelTests.swift
//  LocatorTests
//
//  Created by Алексей Бодров on 30.03.2023.
//

import XCTest
@testable import Locator

final class MainViewModelTests: XCTestCase {

    func test_ViewModelReturnPersons() {
//        systemAnderTest
        let sut = makeSUT()
        sut.updateData { }

        XCTAssertEqual(sut.personArray, ServiceMock.persons)
    }

    func test_ViewModelReturnnumberOfCellsArray() {
        let sut = makeSUT()
        sut.updateData { }

        XCTAssertEqual(sut.numberOfRows(), ServiceMock.persons.count)
    }
}

extension MainViewModelTests {
    func makeSUT() -> MainViewModel {
        return MainViewModel(networkService: ServiceMock())
    }
}
