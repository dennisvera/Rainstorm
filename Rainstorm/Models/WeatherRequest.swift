//
//  WeatherRequest.swift
//  Rainstorm
//
//  Created by Dennis Vera on 7/18/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import Foundation

struct WeatherRequest {
    
    // MARK: - Properties
    
    let baseUrl: URL
    
    // MARK: -

    let location: Location
    
    // MARK: -

    private var latitude: Double {
       return location.latitude
    }
    
    private var longitude: Double {
        return location.longitude
    }
    
    // MARK: -

    var url: URL {
        return baseUrl.appendingPathComponent("\(latitude),\(longitude)")
    }
    
}
