//
//  LocationService.swift
//  Locator
//
//  Created by Алексей Бодров on 01.04.2023.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
    var fetchCurrentCoordinate: ((CLLocationCoordinate2D) -> Void)? { get set }
}

final class LocationService: NSObject, LocationServiceProtocol {

    // MARK: - public
    var fetchCurrentCoordinate: ((CLLocationCoordinate2D) -> Void)?

    // MARK: - property
    private let locationManager = CLLocationManager()

    // MARK: - life cycle funcs
    override init() {
        super.init()
        self.configureLocationManager()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        fetchCurrentCoordinate?(location)
    }
}

extension LocationService {
    // MARK: - flow funcs
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}
