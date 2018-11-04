//
//  WeekViewController.swift
//  Rainstorm
//
//  Created by Dennis Vera on 7/17/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import UIKit

final class WeekViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.isHidden = true
            tableView.dataSource = self
            tableView.separatorInset = .zero
            tableView.estimatedRowHeight = 44.0
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.showsVerticalScrollIndicator = false
        }
    }
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
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
        view.backgroundColor = .white
    }
    
    // MARK: - Helper Methods

    private func setupViewModel(with viewModel: WeekViewModel) {
        // Hide Activity Indicator View
        activityIndicatorView.stopAnimating()
                
        // Update Table View
        tableView.reloadData()
        tableView.isHidden = false        
    }
    
}

extension WeekViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfDays ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekDayTableViewCell.reuseIdentifier, for: indexPath) as? WeekDayTableViewCell else { fatalError("Unable to Dequeue Week Day Table View Cell") }
        
        guard let viewModel = viewModel else { fatalError("No View Model Present") }

        // Configure Cell
        cell.configure(with: viewModel.viewModel(for: indexPath.row))
                
        return cell
    }
    
}





















