//
//  MainViewModel.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import Foundation
import CoreLocation

protocol MainViewModelProtocol {
    var updateViewData: ((ViewData) -> Void)? { get set }
    var updateSelectedPersonData: ((Person, String) -> Void)? { get set }

    func numberOfRows() -> Int
    func getDistancePersonFor(_ index: Int) -> String
    func startFetchData()
    func headerViewFetchData(index: Int?)
    func getPersonFor(_ index: Int) -> Person
    func setSelectedCoordinateWith(_ index: Int)
    func prepareTextCoordinate(latitude: Double, longitude: Double) -> String
}

final class MainViewModel: MainViewModelProtocol {
    // MARK: - property
    private var locationService: LocationServiceProtocol
    private let networkService: NetworkServiceProtocol

    private var selectedPersonIndex: Int? {
        didSet {
            headerViewFetchData(index: selectedPersonIndex)
        }
    }
    var updateSelectedPersonData: ((Person, String) -> Void)?
    private var selectedCoordinate: CLLocationCoordinate2D?
    private var myCoordinate = CLLocationCoordinate2D()

    var updateViewData: ((ViewData) -> Void)?

    private var personArray: [Person] = .init() {
        didSet {
            // Не увидишь предварительный выход из функции во время исполнения
            #warning("Проверки нужно объединить в одну цепочку")
            guard let index = selectedPersonIndex else { return }
            guard let lat = personArray[index].latitude,
                  let long = personArray[index].longitude else { return } // <- return лучше вынести на новую строку
            selectedCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
    }

    // MARK: - life cycle funcs
    init(networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol) {
        self.networkService = networkService
        self.locationService = locationService
        startFetchData()
        startFetchLocation()
    }

    // MARK: - flow funcs
    #warning("Можно написать в одну строчку")
    func prepareTextCoordinate(latitude: Double, longitude: Double) -> String {
        let text = "    LAT: \(latitude) \nLONG: \(longitude)"
        return text
    }

    func setSelectedCoordinateWith(_ index: Int) {
        if selectedPersonIndex == index {
            selectedPersonIndex = nil
            selectedCoordinate = myCoordinate
        } else {
            // Не увидишь предварительный выход из функции во время исполнения
            guard let latitude = personArray[index].latitude,
                  let longitude = personArray[index].longitude else { return } // <- return лучше вынести на новую строку
            selectedCoordinate = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
            selectedPersonIndex = index
        }
    }
    #warning("Можно написать в одну строчку")
    func getPersonFor(_ index: Int) -> Person {
        let person = personArray[index]
        return person
    }

    func getDistancePersonFor(_ index: Int) -> String {
       if
        let lat = selectedCoordinate?.latitude,
        let long = selectedCoordinate?.longitude {
           let distance = personArray[index].getDistance(from: CLLocation(latitude: lat,
                                                                          longitude: long))
           return "\(Int(distance)) m."
       } else {
           return ""
       }
    }

    func headerViewFetchData(index: Int?) {

        if let index = index {
            updateSelectedPersonData?(personArray[index], "Is Selected")
        } else {
            let user = defaultUserData()
            // Не увидишь предварительный выход из функции во время исполнения
            guard let lat = user.latitude,
                  let long = user.longitude else { return } // <- return лучше вынести на новую строку

            updateSelectedPersonData?(user, prepareTextCoordinate(latitude: lat,
                                                                      longitude: long))
        }
    }

    func defaultUserData() -> Person {
        /*
         let user = Person(
            id: nil,
            icon: "redPin",
            name: "Me",
            latitude: myCoordinate.latitude,
            longitude: myCoordinate.longitude)
         */
        // Не очень наглядное выравнивание
        let user = Person(id: nil, icon: "redPin", name: "Me",
                              latitude: myCoordinate.latitude,
                              longitude: myCoordinate.longitude)
        return user
    }

    func startFetchData() {
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
        #warning("Подумай, не удобнее ли вынести это в отдельнную функцию?")
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            self.networkService.updateLocations { [unowned self] result in
                self.personArray = result
                self.updateViewData?(.success(result))
            }
        }
    }
    func startFetchLocation() {
        self.locationService.fetchCurrentCoordinate = { [unowned self] result in
            self.myCoordinate = result
            #warning("Зачем тут использовать конструкцию if... если не условия else?")
            if selectedPersonIndex == nil {
                self.selectedCoordinate = myCoordinate
            }
        }
    }

    func numberOfRows() -> Int {
        personArray.count
    }
}
