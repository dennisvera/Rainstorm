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
    
    @IBOutlet var dateLabel: UILabel! {
        didSet {
            dateLabel.textColor = UIColor.Rainstorm.baseTextColor
            dateLabel.font = UIFont.Rainstorm.heavyLarge
        }
    }
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
           iconImageView.contentMode = .scaleAspectFill
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
    
    // MARK: - Helper Methods
    
    private func setupView() {
        // Configure View
        view.backgroundColor = .green
    }
    
    private func setupViewModel(with viewModel: DayViewModel) {
        print("DayViewModel: \n\(viewModel)\n")
    }
    
}
