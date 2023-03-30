//
//  ServiceMock.swift
//  LocatorTests
//
//  Created by Алексей Бодров on 30.03.2023.
//

import Foundation
@testable import Locator

final class ServiceMock: NetworkServiceProtocol {
    func fetchData(complition: @escaping (Result<[Locator.Person], Error>) -> Void) {
//        ServiceMock.persons
    }

    func updateLocations(complition: @escaping ([Locator.Person]) -> Void) {

    }

//    static let persons: [Person] = [
//        Person(id: 1, icon: "Baz1", name: "Bar1", latitude: 1.1, longitude: 1.1),
//        Person(id: 2, icon: "Baz2", name: "Bar2", latitude: 2.1, longitude: 2.2)
//    ]
}
