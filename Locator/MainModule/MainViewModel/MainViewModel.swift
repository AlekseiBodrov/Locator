//
//  MainViewModel.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import Foundation

protocol MainViewModelProtocol {
    var personArray: [] { get }
}

final class MainViewModel: MainViewModelProtocol {
    private(set) var personArray: [] = .init()
}
