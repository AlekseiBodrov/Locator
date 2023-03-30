//
//  NetworkService.swift
//  Locator
//
//  Created by Алексей Бодров on 26.03.2023.
//

import Foundation
import CoreLocation

protocol NetworkServiceProtocol {
    func fetchData(complition: @escaping (Result<[Person], Error>) -> Void)
    func updateLocations(complition: @escaping ([Person]) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    // MARK: - property
    private var lastLocations = [Person]()

    // MARK: - public funcs
    func fetchData(complition: @escaping (Result<[Person], Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "locations", ofType: "json") else {return}
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let object = try JSONDecoder().decode([Person].self, from: data)
            self.lastLocations = object
            complition(.success(object))
        } catch {
            complition(.failure(error))
        }
    }

    func updateLocations(complition: @escaping ([Person]) -> Void){
        self.lastLocations.forEach({ person in
            person.latitude? += Double.random(in: -0.0001...0.0001)
            person.longitude? += Double.random(in: -0.0001...0.0001)
        })
        complition(lastLocations)
    }
}
