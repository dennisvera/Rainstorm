//
//  Configuration.swift
//  Rainstorm
//
//  Created by Dennis Vera on 7/18/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import Foundation

enum Defaults {
    
    static let location = Location(latitude: 40.7590562, longitude: -74.0042502)
}

enum Configuration {
    
    static var refreshThreshold: TimeInterval {
        #if DEBUG
        return 60.0
        #else
        return 10.0 * 60.0
        #endif
    }
}

enum WeatherService {
    
    private static let apiKey = "51880986ba359208b4f1cc85edb56a8e"
    private static let baseUrl = URL(string: "https://api.darksky.net/forecast/")!
    
    static var authenticatedBaseUrl: URL {
        return baseUrl.appendingPathComponent(apiKey)
    }
}
