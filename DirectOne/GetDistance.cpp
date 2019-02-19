//
//  GetDistance.cpp
//  DirectOne
//
//  Created by Robert on 15.02.19.
//  Copyright © 2019 Robert. All rights reserved.
//

#include "GetDistance.hpp"
#include <GeographicLib/Geodesic.hpp>

double getDistance(double lat1, double lon1,
                   double lat2, double lon2) {
    const GeographicLib::Geodesic geodesic = GeographicLib::Geodesic::WGS84();
    double result;
    geodesic.Inverse(lat1, lon1, lat2, lon2, result);
    return result;
}
