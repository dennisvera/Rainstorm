//
//  WeekDayViewModelTests.swift
//  RainstormTests
//
//  Created by Dennis Vera on 9/30/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import XCTest
@testable import Rainstorm

class WeekDayViewModelTests: XCTestCase {
    
    var viewModel: WeekDayViewModel!

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
        viewModel = WeekDayViewModel(weatherData: darkSkyResponse.forecast[0])
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDay() {
        XCTAssertEqual(viewModel.day, "Sunday")
    }
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "September 30")
    }
    
    func testTemperature() {
        XCTAssertEqual(viewModel.temperature, "60.6 °F - 70.7 °F")
    }

    func testWindSpeed() {
        XCTAssertEqual(viewModel.windSpeed, "2 MPH")
    }
    
    func testImage() {
        let viewModelImage = viewModel.image
        let imageDataViewModel = UIImagePNGRepresentation(viewModelImage!)!
        let imageDataReference = UIImagePNGRepresentation(UIImage(named: "cloudy")!)!
        
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage!.size.width, 45.0)
        XCTAssertEqual(viewModelImage!.size.height, 33.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }
    
}
