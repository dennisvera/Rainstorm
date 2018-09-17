//
//  DayViewController.swift
//  Rainstorm
//
//  Created by Dennis Vera on 7/17/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import UIKit

final class DayViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet var temparatureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel! {
        didSet {
            dateLabel.textColor = UIColor.Rainstorm.baseTextColor
            dateLabel.font = UIFont.Rainstorm.heavyLarge
        }
    }
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
           iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = UIColor.Rainstorm.baseTintColor
        }
    }
    
    @IBOutlet var regularLabels: [UILabel]! {
        didSet {
            for label in regularLabels {
                label.textColor = .black
                label.font = UIFont.Rainstorm.lightRegular
            }
        }
    }
    
    @IBOutlet var smallLabels: [UILabel]! {
        didSet {
            for label in smallLabels {
                label.textColor = .black
                label.font = UIFont.Rainstorm.lightSmall
            }
        }
    }
    
    @IBOutlet var weatherDataViews: [UIView]! {
        didSet {
            for view in weatherDataViews {
                view.isHidden = true
            }
        }
    }
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    //MARK: - Properties
    
    var viewModel: DayViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            setupViewModel(with: viewModel)
        }
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup View
        setupView()
    }
    
    // MARK: - View Methods

    private func setupView() {
        // Configure View
        view.backgroundColor = UIColor.Rainstorm.lightBackgroundColor
    }
    
    // MARK: - Helper Methods

    private func setupViewModel(with viewModel: DayViewModel) {
        // Hide Activity Indicator View
        activityIndicatorView.stopAnimating()
        
        // Configure Labels
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        windSpeedLabel.text = viewModel.windSpeed
        temparatureLabel.text = viewModel.temperature
        descriptionLabel.text = viewModel.summary
        
        // Configure Icon Image View
        iconImageView.image = viewModel.image
        
        // Show Weather Data Views
        for view in weatherDataViews {
            view.isHidden = false
        }
    }
    
}











