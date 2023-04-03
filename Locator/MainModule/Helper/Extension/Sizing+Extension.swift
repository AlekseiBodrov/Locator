//
//  Sizing+Extension.swift
//  Locator
//
//  Created by Алексей Бодров on 28.03.2023.
//

import Foundation

public protocol Sizing {
    init(_ value: Double)
}

extension Int: Sizing { }
extension UInt: Sizing { }
extension Float: Sizing { }
extension Double: Sizing { }
extension CGFloat: Sizing { }

extension Sizing {

    /// Row
    ///
    /// Value: 100.0.
    static var rowSize: Self { Self(100.0) }

    /// XL
    ///
    /// Value: 32.0.
    static var xlSize: Self { Self(32.0) }

    /// L
    ///
    /// Value: 24.0.
    static var lSize: Self { Self(24.0) }

    /// MPlus
    ///
    /// Value: 20.0.
    static var mplusSize: Self { Self(20.0) }

    /// M
    ///
    /// Value: 16.0.
    static var mSize: Self { Self(16.0) }

    /// SPlus
    ///
    /// Value: 14.0.
    static var splusSize: Self { Self(14.0) }

    /// S
    ///
    /// Value: 12.0.
    static var sSize: Self { Self(12.0) }

    /// XS
    ///
    /// Value: 8.0.
    static var xsSize: Self { Self(8.0) }

    /// XXS
    ///
    /// Value: 4.0.
    static var xxsSize: Self { Self(4.0) }

    /// XXXS
    ///
    /// Value: 2.0.
    static var xxxsSize: Self { Self(2.0) }
}
