//
//  Configuration.swift
//  Rainstorm
//
//  Created by Dennis Vera on 7/18/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import Foundation
import CoreLocation

enum Defaults {
    
    static let location = CLLocation(latitude: 40.7590562, longitude: -74.0042502)
}

enum WeatherService {
    
    private static let apiKey = "51880986ba359208b4f1cc85edb56a8e"
    private static let baseUrl = URL(string: "https://api.darksky.net/forecast/")!
    
    static var authenticatedBaseUrl: URL {
        return baseUrl.appendingPathComponent(apiKey)
    }
}
