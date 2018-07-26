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
            dateLabel.textColor = UIColor(red: 0.31, green: 0.72, blue: 0.83, alpha: 1.0)
            dateLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .heavy)
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
                label.font = UIFont.systemFont(ofSize: 17.0, weight: .light)
            }
        }
    }
    
    @IBOutlet var smallLabels: [UILabel]! {
        didSet {
            for label in smallLabels {
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 15.0, weight: .light)
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
        view.backgroundColor = .blue
    }
    
    private func setupViewModel(with viewModel: DayViewModel) {
        print("DayViewModel: \n\(viewModel)\n")
    }
    
}
