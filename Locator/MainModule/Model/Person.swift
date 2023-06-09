//
//  Person.swift
//  Locator
//
//  Created by Алексей Бодров on 26.03.2023.
//

import CoreLocation
import Foundation

enum ViewData {
    case initial
    case success([Person])
    case failure([Person])
}

class Person: Decodable {
    var id: Int?
    var icon: String?
    var name: String?
    var latitude: Double?
    var longitude: Double?

    init(id: Int? = nil, icon: String? = nil, name: String? = nil,
         latitude: Double? = nil, longitude: Double? = nil) {
        self.id = id
        self.icon = icon
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }

    func getDistance(from location: CLLocation) -> CLLocationDistance {
        guard let latitude = self.latitude, let longitude = self.longitude else {
            return CLLocationDistance()
        }

        return CLLocation(latitude: latitude, longitude: longitude).distance(from: location)
    }
}
