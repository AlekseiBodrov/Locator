//
//  MainViewModel.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import Foundation
import CoreLocation

protocol MainViewModelProtocol {
    var updateSelfCoordinate: ((String) -> Void)? { get set }
    var updateViewData: ((ViewData) -> Void)? { get set }
    //  var coordinateCurentUser
//  func updateCurentUser
//    tabelViewTrigger
    var personArray: [Person] { get }
    var selfCoordinate: CLLocationCoordinate2D { get set }
    var selectedCoordinate: CLLocationCoordinate2D { get set }
    func numberOfRows() -> Int
    func prepareSelfCoordinate() -> String
    func updateData(completion: () -> Void)
    func getDistanceFor(indexPath: IndexPath) -> String
    func startFetch()
    func error()
}

final class MainViewModel: MainViewModelProtocol {

    let locationService: LocationServiceProtocol
    let networkService: NetworkServiceProtocol
//    var viewData: ViewData = .initial {
//        didSet {
//
//        }
//    }
    var updateSelfCoordinate: ((String) -> Void)?
    var selectedCoordinate = CLLocationCoordinate2D()
    var selfCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()

    var updateViewData: ((ViewData) -> Void)?

    // MARK: - property

    private(set) var personArray: [Person] = .init()

    // MARK: - life cycle funcs
    init(networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol) {
        self.networkService = networkService
        self.locationService = locationService

        startFetch()
        updateViewData?(.initial)
    }

    // MARK: - flow funcs
    func prepareSelfCoordinate() -> String {
        let text = "    LAT: \(selfCoordinate.latitude) \nLONG: \(selfCoordinate.longitude)"
        return text
    }

    func prepareSelectedCoordinate() -> String {
        let text = "    LAT: \(selectedCoordinate.latitude) \nLONG: \(selectedCoordinate.longitude)"
        return text
    }

//    "\(Int(person.getDistance(from: CLLocation.init(latitude: 1.1, longitude: 2.4)))) m."
    func updateData(completion: () -> Void) {
//        do {
////            self.personArray = try networkService.fetchData()
//        } catch {
//            print(error)
//        }
    }

    func startFetch() {
        networkService.fetchData { [unowned self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                switch result {
                case .success(let locations):
                    self.personArray = locations
                    self.updateViewData?(.success(locations))
                case .failure(let failure):
                    print(failure)
                    self.updateViewData?(.failure([Person]()))
                }
            }
        }

        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            self.networkService.updateLocations { [unowned self] result in
                self.updateViewData?(.success(result))
            }
        }
    }

    func error() {
    }

    func numberOfRows() -> Int {
        personArray.count
    }

    func getDistanceFor(indexPath: IndexPath) -> String {
        let latitude = selectedCoordinate.latitude
        let longitude = selectedCoordinate.longitude
        let location = CLLocation.init(latitude: latitude, longitude: longitude)

        let distance = personArray[indexPath.row].getDistance(from: location)

        let text =  "\(Int(distance)) m."
        return text
    }
}
