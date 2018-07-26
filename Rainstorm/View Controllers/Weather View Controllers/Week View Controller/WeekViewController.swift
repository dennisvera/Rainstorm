//
//  WeekViewController.swift
//  Rainstorm
//
//  Created by Dennis Vera on 7/17/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import UIKit

final class WeekViewController: UIViewController {
    
    // MARK: - Properties

    var viewModel: WeekViewModel? {
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
    
    // MARK: - Helper Method
    
    private func setupView() {
        // Configure View
        view.backgroundColor = .green
    }
    
    private func setupViewModel(with viewModel: WeekViewModel) {
        print("WeekViewModel: \n\(viewModel)\n")
    }
    

}
