//
//  LocationService.swift
//  Rainstorm
//
//  Created by Dennis Vera on 10/16/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import Foundation

enum LocationServiceError {
    
    case notAuthorizedToRequestLocation
}

protocol LocationService {
    
    typealias FetchLocationCompletion = (Location?, LocationServiceError?) -> Void
    
    func fetchLocation(completion: @escaping FetchLocationCompletion)
    
}
