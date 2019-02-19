//
//  GetDistance.swift
//  DirectOne
//
//  Created by Robert on 15.02.19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation
import MapKit

func getDistanceBetween(from : CLLocationCoordinate2D?, to : CLLocationCoordinate2D?) -> Double {
    var distance : Double = 0
    if let from = from, let to = to {
        distance = getDistance(from.latitude, from.longitude, to.latitude, to.longitude)
    }
    return distance
}

