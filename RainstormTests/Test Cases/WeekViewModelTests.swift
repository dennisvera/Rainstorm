//
//  WeekViewModelTests.swift
//  RainstormTests
//
//  Created by Dennis Vera on 9/30/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import XCTest
@testable import Rainstorm

class WeekViewModelTests: XCTestCase {
    
    var viewModel: WeekViewModel!
    
    override func setUp() {
        super.setUp()

        // Load Stub
        let data = loadStub(name: "darkSky", extension: "json")
        
        // Intialize JSON Decoder
        let decoder = JSONDecoder()
        
        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // Initialize Dark Sky Response
        let darkSkyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
        
        // Initialize View Model
        viewModel = WeekViewModel(weatherData: darkSkyResponse.forecast)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNumberOfDays() {
        XCTAssertEqual(viewModel.numberOfDays, 8)
    }
    
    func testViewModelForIndex() {
        let weekDayViewModel = viewModel.viewModel(for: 0)
        
        XCTAssertEqual(weekDayViewModel.day, "Sunday")
        XCTAssertEqual(weekDayViewModel.date, "September 30")
    }
    
}
