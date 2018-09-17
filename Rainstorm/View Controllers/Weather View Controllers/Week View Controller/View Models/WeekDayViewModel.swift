//
//  WeekDayViewModel.swift
//  Rainstorm
//
//  Created by Dennis Vera on 9/17/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import UIKit

struct WeekDayViewModel {
    
    // MARK: - Properties
    
    let weatherData: ForecastWeatherConditions
    
    private let dateFormatter = DateFormatter()
    
    // MARK: -

    var day: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "EEEE"
        
        // Convert Date to String
        return dateFormatter.string(from: weatherData.time)
    }
    
    var date: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "MMMM d"
        
        // Convert Date to String
        return dateFormatter.string(from: weatherData.time)
    }
    
    var temperature: String {
        let min = String(format: "%.1f °F", weatherData.temperatureMin)
        let max = String(format: "%.1f °F", weatherData.temperatureMax)
        
        return "\(min) - \(max)"
    }
    
    var windSpeed: String {
        return String(format: "%.f MPH", weatherData.windSpeed)
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(with: weatherData.icon)
    }
    
}

extension WeekDayViewModel: WeekDayRepresentable {
    
}
