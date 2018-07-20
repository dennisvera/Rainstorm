//
//  RootViewModel.swift
//  Rainstorm
//
//  Created by Dennis Vera on 7/18/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import Foundation

class RootViewModel {
    
    // MARK: Types
    
    enum WeatherDataError: Error {
        case noWeatherDataAvailable
    }
    
    // MARK: - Typealias
    
    typealias DidFetchWeatherDataCompletion = (WeatherData?, WeatherDataError?) -> Void
    
    // MARK - Properties
    
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    // MARK: - Initialization
    
    init() {
        // Fetch Wetaher Data
        fetchWeatherData()
    }
    
    // MARK: - Helper Methods
    
    func fetchWeatherData() {
        // Initialize Weather Request
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: Defaults.location)
        
        // Create Data Task
        URLSession.shared.dataTask(with: weatherRequest.url) { [weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Response Status Code: \(response.statusCode)\n")
            }
            
            if let error = error {
                print("Unable to Fetch Wetaher Data \(error)")
                
                self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let darkSkyResponse = try decoder.decode(DarkSkyResponse.self, from: data)
                    
                    self?.didFetchWeatherData?(darkSkyResponse, nil)
                } catch {
                    print("Uneable to Decode JSON Response: \(error)")
                    
                    self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
                }
            } else {
                self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
            }
            }.resume()
    }
}






