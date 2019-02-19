//
//  GetDistance.hpp
//  DirectOne
//
//  Created by Robert on 15.02.19.
//  Copyright © 2019 Robert. All rights reserved.
//

#ifndef GetDistance_hpp
#define GetDistance_hpp

#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif
    
    double getDistance(double lat1, double lon1,
                       double lat2, double lon2);
    
#ifdef __cplusplus
}
#endif

#endif /* GetDistance_hpp */
