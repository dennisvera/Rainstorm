//
//  WeatherRequest.swift
//  Rainstorm
//
//  Created by Dennis Vera on 7/18/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherRequest {
    
    let baseUrl: URL
    let location: CLLocation
    
    private var latitude: Double {
       return location.coordinate.latitude
    }
    
    private var longitude: Double {
        return location.coordinate.longitude
    }
    
    var url: URL {
        return baseUrl.appendingPathComponent("\(latitude),\(longitude)")
    }
}
