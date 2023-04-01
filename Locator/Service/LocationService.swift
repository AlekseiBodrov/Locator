//
//  LocationService.swift
//  Locator
//
//  Created by Алексей Бодров on 01.04.2023.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
    func fetchLocation(complition: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void)
}

final class LocationService: NSObject, LocationServiceProtocol {
    // MARK: - property
    private var location: CLLocationCoordinate2D?
    var updateCoordinate: ((Result<CLLocationCoordinate2D, Error>) -> Void)?
    let locationManager = CLLocationManager()

    override init() {
        super.init()
        self.configure()
    }

    // MARK: - public funcs
    func fetchLocation(complition: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {

    }

    private func configure() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        self.location = location
    }
}
