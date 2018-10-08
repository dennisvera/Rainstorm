//
//  RootViewModel.swift
//  Rainstorm
//
//  Created by Dennis Vera on 7/18/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import Foundation
import CoreLocation

class RootViewModel: NSObject {
    
    // MARK: Types
    
    enum WeatherDataError: Error {
        case notAuthorizedToRequestLocation
        case noWeatherDataAvailable
    }
    
    // MARK: - Typealias
    
    typealias DidFetchWeatherDataCompletion = (WeatherData?, WeatherDataError?) -> Void
    
    // MARK - Properties
    
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        
        locationManager.delegate = self
        
        return locationManager
    }()
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        
        // Fetch Weather Data
        fetchWeatherData(for: Defaults.location)
        
        // Fetch Users Location
        fetchLocation()
    }
    
    // MARK: - Helper Methods
    
    func fetchLocation() {
        locationManager.requestLocation()
    }
    
    func fetchWeatherData(for location: CLLocation) {
        // Initialize Weather Request
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: location)
        
        // Create Data Task
        URLSession.shared.dataTask(with: weatherRequest.url) { [weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Response Status Code: \(response.statusCode)\n")
            }
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Unable to Fetch Wetaher Data \(error)")
                    
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


extension RootViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse {
            fetchLocation()
        } else {
            didFetchWeatherData?(nil, .notAuthorizedToRequestLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        fetchWeatherData(for: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to Fetch Location: \(error)")
    }
}














