//
//  XCTestCase.swift
//  RainstormTests
//
//  Created by Dennis Vera on 9/30/18.
//  Copyright © 2018 Dennis Vera. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func loadStub(name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        
        return  try! Data(contentsOf: url!)
    }
    
}
