//
//  UnitConverter.swift
//  DirectOne
//
//  Created by Robert on 18.02.19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation

enum UnitConverter {
    enum unitState {
        case meter
        case kilmeter
        case feet
        case mile
    }
    
    case m(Double)
    case km(Double)
    case ft(Double)
    case miles(Double)
    var stringValue : String {
        switch self {
        case .m(let metters):
            return "\(metters.rounded()) m"
        case .km(let metters):
            return "\((metters / 1000).rounded()) km"
        case .ft(let metters):
            return "\((metters * 3.2808).rounded()) ft"
        case .miles(let metters):
            return "\((metters * 0.0006213712).rounded()) mi"
        }
    }
    static var allUnits = [UnitConverter.m, UnitConverter.km, UnitConverter.ft, UnitConverter.miles]
}
