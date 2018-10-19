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
    
    enum WeatherDataResults {
        case success(WeatherData)
        case failure(WeatherDataError)
    }
    
    // MARK: - Typealias
    
    typealias FetchWeatherDataCompletion = (WeatherDataResults) -> Void
    
    // MARK - Properties
    
    var didFetchWeatherData: FetchWeatherDataCompletion?
    
    // MARK -
    
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
        locationService.fetchLocation { [weak self] (result) in
            switch result {
            case .success(let location):
                self?.fetchWeatherData(for: location)
            case .failure(let error):
                print("Unable to Fetch Location \(error)")
                
                let result: WeatherDataResults = .failure(.notAuthorizedToRequestLocation)
                
                // Invoke Completion Handler
                self?.didFetchWeatherData?(result)
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
                    
                    let result: WeatherDataResults = .failure(.notAuthorizedToRequestLocation)

                    self?.didFetchWeatherData?(result)
                } else if let data = data {
                    // Initialize JSON Decoder
                    let decoder = JSONDecoder()
                    
                    decoder.dateDecodingStrategy = .secondsSince1970
                    
                    do {
                        // Decode JSON Response
                        let darkSkyResponse = try decoder.decode(DarkSkyResponse.self, from: data)
                        
                        let result: WeatherDataResults = .success(darkSkyResponse)

                        // Invoke Completion Handler
                        self?.didFetchWeatherData?(result)
                    } catch {
                        print("Uneable to Decode JSON Response: \(error)")
                        
                        let result: WeatherDataResults = .failure(.notAuthorizedToRequestLocation)

                        self?.didFetchWeatherData?(result)
                    }
                } else {
                    let result: WeatherDataResults = .failure(.notAuthorizedToRequestLocation)

                    self?.didFetchWeatherData?(result)
                }
            }
            }.resume()
    }
}















