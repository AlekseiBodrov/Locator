//
//  MainViewModel.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import Foundation

protocol MainViewModelProtocol {
    var personArray: [Person] { get }

    func numberOfRows() -> Int
    func updateData(completion:() -> Void)
}

final class MainViewModel: MainViewModelProtocol {

    // MARK: - property
    let networkService: NetworkServiceProtocol
    private(set) var personArray: [Person] = .init()

    // MARK: - life cycle funcs
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService


    }

    // MARK: - flow funcs
    func updateData(completion:() -> Void) {
        do {
            self.personArray = try networkService.fetchData()
        } catch {
            print(error)
        }
    }

    func numberOfRows() -> Int {
        personArray.count
    }
}
