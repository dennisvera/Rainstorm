//
//  DayViewModelTests.swift
//  RainstormTests
//
//  Created by Dennis Vera on 9/30/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import XCTest
@testable import Rainstorm

class DayViewModelTests: XCTestCase {
    
    var viewModel: DayViewModel!
    
    override func setUp() {
        super.setUp()
        
        let data = loadStub(name: "darkSky", extension: "json")
        
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let darkSkyResponse = try! decoder.decode(DarkSkyResponse.self, from: data)
        
        viewModel = DayViewModel(weatherData: darkSkyResponse.current)
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "Sun, September 30 2018")
    }
    
    func testTime() {
        XCTAssertEqual(viewModel.time, "05:31 PM")
    }
    
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Clear")
    }
    
    func testTemperature() {
        XCTAssertEqual(viewModel.temperature, "70.0 °F")
    }
    
    func testWindSpeed() {
        XCTAssertEqual(viewModel.windSpeed, "5 MPH")
    }
    
    func testImage() {
        let viewModelImage = viewModel.image
        let imageDataViewModel = UIImagePNGRepresentation(viewModelImage!)!
        let imageDataReference = UIImagePNGRepresentation(UIImage(named: "clear-day")!)!
        
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage!.size.width, 48.0)
        XCTAssertEqual(viewModelImage!.size.height, 48.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }
    
}





