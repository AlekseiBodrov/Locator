//
//  Person.swift
//  Locator
//
//  Created by Алексей Бодров on 26.03.2023.
//

import CoreLocation
import Foundation

struct Person: Decodable {
    var id: Int
    var name: String
    let latitude: Double
    let longitude: Double

    func getDistance(from location: CLLocation) -> CLLocationDistance {
        CLLocation(latitude: latitude, longitude: longitude).distance(from: location)
    }
}

