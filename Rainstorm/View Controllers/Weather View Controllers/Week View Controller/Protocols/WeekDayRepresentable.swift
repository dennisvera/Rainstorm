//
//  WeekDayRepresentable.swift
//  Rainstorm
//
//  Created by Dennis Vera on 9/17/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import UIKit

protocol WeekDayRepresentable {
    
    var day: String { get }
    var date: String { get }
    var temperature: String { get }
    var windSpeed: String { get }
    var image: UIImage? { get }
    
}
