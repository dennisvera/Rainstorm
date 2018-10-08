//
//  RootViewController.swift
//  Rainstorm
//
//  Created by Dennis Vera on 7/17/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    private enum AlertType {
        case notAuthorizedToRequestLocation
        case noWeatherDataAvailable
    }
    
    // MARK: - Properties
    
    var viewModel: RootViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            // Setup View Model
            setupViewModel(with: viewModel)
        }
    }
    
    // MARK: -
    
    private let dayViewController: DayViewController = {
        guard let dayViewController = UIStoryboard.main.instantiateViewController(withIdentifier: DayViewController.storyboardIdentifier) as? DayViewController else { fatalError("Unable to instantiate Day View Controller") }
        
        // Configure Day View Controller
        dayViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return dayViewController
    }()
    
    private let weekViewController: WeekViewController = {
        guard let weekViewController = UIStoryboard.main.instantiateViewController(withIdentifier: WeekViewController.storyboardIdentifier) as? WeekViewController else { fatalError("Unable to instantiate Week View Controller") }
        
        // Configure Week View Controller
        weekViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return weekViewController
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Child View Controllers
        setupChildViewControllers()        
    }
    
    // MARK: - Helper Method
    
    private func setupChildViewControllers() {
        addChildViewController(dayViewController)
        addChildViewController(weekViewController)
        
        view.addSubview(dayViewController.view)
        view.addSubview(weekViewController.view)
        
        // Configure Day View
        dayViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dayViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dayViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // Configure Week View
        weekViewController.view.topAnchor.constraint(equalTo: dayViewController.view.bottomAnchor).isActive = true
        weekViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        weekViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        weekViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Notify Child View Controller
        dayViewController.didMove(toParentViewController: self)
        weekViewController.didMove(toParentViewController: self)
    }
    
    // MARK: -
    
    private func setupViewModel(with viewModel: RootViewModel) {
        // Configure View Model
        viewModel.didFetchWeatherData = { [weak self] (weatherData, error) in
            if let error = error {
                let alertType: AlertType
                
                switch error {
                case .notAuthorizedToRequestLocation:
                    alertType = .notAuthorizedToRequestLocation
                case .noWeatherDataAvailable:
                    alertType = .noWeatherDataAvailable
                }
                
                // Notify User
                self?.presentAlert(of: alertType)
            } else if let weatherData = weatherData {
                let dayViewModel = DayViewModel(weatherData: weatherData.current)
                
                self?.dayViewController.viewModel = dayViewModel
                
                let weekViewModel = WeekViewModel(weatherData: weatherData.forecast)
                
                self?.weekViewController.viewModel = weekViewModel
            } else {
                // Notify user
                self?.presentAlert(of: .noWeatherDataAvailable)
            }
        }
    }
    
    // MARK: -
    
    private func presentAlert(of alertType: AlertType) {
        // Helpers
        let title: String
        let message: String
        
        switch alertType {
        case .notAuthorizedToRequestLocation:
            title = "Unable to Fetch Weather Data for Your Location"
            message = "Rainstorm is not authorized to access your current location. This means it's unable to show you the weather for your current location. You can grant Rainstorm access to your current location in the Settings application."
        case .noWeatherDataAvailable:
            title = "Unable to Fetch Weather Data"
            message = "The application is unable to fetch weather data. Please make sure your device is connected over Wi-Fi or cellular."
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
}















