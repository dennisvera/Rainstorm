//
//  LocationService.swift
//  Rainstorm
//
//  Created by Dennis Vera on 10/16/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import Foundation

enum LocationServiceError: Error {
    case notAuthorizedToRequestLocation
}

enum LocationsServiceResult {
    case success(Location)
    case failure(LocationServiceError)
}

protocol LocationService {
    
    // MARK: - Typealias
    
    typealias FetchLocationCompletion = (LocationsServiceResult) -> Void
    
    // MARK: - Methods

    func fetchLocation(completion: @escaping FetchLocationCompletion)
    
}
