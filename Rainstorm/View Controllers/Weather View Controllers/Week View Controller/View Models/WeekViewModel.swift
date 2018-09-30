//
//  WeekViewModel.swift
//  Rainstorm
//
//  Created by Dennis Vera on 7/20/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import Foundation

struct WeekViewModel {
    
    // MARK: - Properties
    
    let weatherData: [ForecastWeatherConditions]
    
    var numberOfDays: Int {
        return weatherData.count
    }
    
    // MARK: - Methods
    
    func viewModel(for index: Int) -> WeekDayViewModel {        
        return WeekDayViewModel(weatherData: weatherData[index])
    }
    
}
