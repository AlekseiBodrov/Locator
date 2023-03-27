//
//  NetworkService.swift
//  Locator
//
//  Created by Алексей Бодров on 26.03.2023.
//

import Foundation
import CoreLocation

protocol NetworkServiceProtocol {
    func fetchData() throws -> [Person]
}

final class NetworkService: NetworkServiceProtocol {

    // MARK: - flow funcs
    func fetchData() throws -> [Person] {
        guard let path = Bundle.main.path(forResource: "locations", ofType: "json") else {return [] }
 //       do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let object = try JSONDecoder().decode([Person].self, from: data)
//            complition(.success(object))
//        } catch {
//            complition(.failure(error))
//        }
        return object
    }
}

