//
//  Person + Extension.swift
//  LocatorTests
//
//  Created by Алексей Бодров on 30.03.2023.
//

import Foundation
@testable import Locator

extension Person: Equatable {
    public static func == (lhs: Person, rhs: Person) -> Bool {
        if lhs.id != rhs.id {
            return false
        }
        if lhs.name != rhs.name {
            return false
        }
        return true
    }
}

