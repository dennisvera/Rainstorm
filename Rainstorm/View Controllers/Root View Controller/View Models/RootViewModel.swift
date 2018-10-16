//
//  RootViewModel.swift
//  Rainstorm
//
//  Created by Dennis Vera on 7/18/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import Foundation

class RootViewModel: NSObject {
    
    // MARK: Types
    
    enum WeatherDataError: Error {
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
    }
    
    // MARK: - Typealias
    
    typealias DidFetchWeatherDataCompletion = (WeatherData?, WeatherDataError?) -> Void
    
    // MARK - Properties
    
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    private let locationService: LocationService
    
    // MARK: - Initialization
    
    init(locationService: LocationService) {
        self.locationService = locationService
        
        super.init()
        
        // Fetch Weather Data
        fetchWeatherData(for: Defaults.location)
        
        // Fetch Users Location
        fetchLocation()
    }
    
    // MARK: - Helper Methods
    
    func fetchLocation() {
        // Request Location
        locationService.fetchLocation { [weak self] (location, error) in
            if let error = error {
                print("Unable to Fetch Location \(error)")
                
                self?.didFetchWeatherData?(nil, .notAuthorizedToRequestLocation)
                
            } else if let location = location {
                self?.fetchWeatherData(for: location)
            } else {
                print("Unable to Fetch Location")
                
                self?.didFetchWeatherData?(nil, .failedToRequestLocation)
            }
        }
    }
    
    func fetchWeatherData(for location: Location) {
        // Initialize Weather Request
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: location)
        
        // Create Data Task
        URLSession.shared.dataTask(with: weatherRequest.url) { [weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Response Status Code: \(response.statusCode)\n")
            }
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Unable to Fetch Weather Data \(error)")
                    
                    self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
                } else if let data = data {
                    // Initialize JSON Decoder
                    let decoder = JSONDecoder()
                    
                    decoder.dateDecodingStrategy = .secondsSince1970
                    
                    do {
                        // Decode JSON Response
                        let darkSkyResponse = try decoder.decode(DarkSkyResponse.self, from: data)
                        
                        // Invoke Completion Handler
                        self?.didFetchWeatherData?(darkSkyResponse, nil)
                    } catch {
                        print("Uneable to Decode JSON Response: \(error)")
                        
                        // Invoke Completion Handler
                        self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
                    }
                } else {
                    self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
                }
            }
            }.resume()
    }
}















