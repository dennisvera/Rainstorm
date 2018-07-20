//
//  DarkSkyResponse.swift
//  Rainstorm
//
//  Created by Dennis Vera on 7/19/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import Foundation

struct DarkSkyResponse: Codable {
    
    struct Conditions: Codable {
        let time: Date
        let icon: String
        let summary: String
        let windSpeed: Double
        let temperature: Double
    }
    
    struct Daily: Codable {
        let data: [Conditions]
        
        struct Conditions: Codable {
            let time: Date
            let icon: String
            let summary: String
            let windSpeed: Double
            let temperatureMin: Double
            let temperatureMax: Double
        }
    }
    
    let latitude: Double
    let longitude: Double
    
    let currently: Conditions
    let daily: Daily
    
}
