//
//  WeekDayTableViewCell.swift
//  Rainstorm
//
//  Created by Dennis Vera on 9/17/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import UIKit

class WeekDayTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet var daylabel: UILabel! {
        didSet {
            daylabel.textColor = UIColor.Rainstorm.baseTextColor
            daylabel.font = UIFont.Rainstorm.heavyLarge
        }
    }
    
    @IBOutlet var datelabel: UILabel! {
        didSet {
            datelabel.textColor = .black
            datelabel.font = UIFont.Rainstorm.lightRegular
        }
    }
    
    @IBOutlet var windSpeedlabel: UILabel! {
        didSet {
            windSpeedlabel.textColor = .black
            windSpeedlabel.font = UIFont.Rainstorm.lightSmall
        }
    }
    
    @IBOutlet var temperaturelabel: UILabel! {
        didSet {
            temperaturelabel.textColor = .black
            temperaturelabel.font = UIFont.Rainstorm.lightSmall
        }
    }
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = UIColor.Rainstorm.baseTintColor
        }
    }
    
    // MARK: - Static Properties
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure Cell
        selectionStyle = .none
    }
    
    // MARK: - Configuration
    
    func configure(with representable: WeekDayRepresentable) {
        daylabel.text = representable.day
        datelabel.text = representable.date
        iconImageView.image = representable.image
        windSpeedlabel.text = representable.windSpeed
        temperaturelabel.text = representable.temperature
    }
    
}









