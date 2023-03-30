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
//    case loading
    case success([Person])
    case failure([Person])
}

final class Person: Decodable {
    var id: Int?
    var icon: String?
    var name: String?
    var latitude: Double?
    var longitude: Double?

//    init(id: Int?, icon: String?, name: String, latitude: Double, longitude: Double) {
//        self.id = id
//        self.icon = icon
//        self.name = name
//        self.latitude = latitude
//        self.longitude = longitude
//    }

    func getDistance(from location: CLLocation) -> CLLocationDistance {
        CLLocation(latitude: latitude!, longitude: longitude!).distance(from: location)
    }
}

