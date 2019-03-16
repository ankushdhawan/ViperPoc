//
//  CountryModelTests.swift
//  ViperPocTests
//
//  Created by Ankush Dhawan on 3/16/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation
@testable import ViperPoc
import XCTest

class CountryModelTests: XCTestCase {
    var model:CountryModel! = nil
    override func setUp() {
        let modelArray = [CountryDetailModel]()
        model = CountryModel(title: "test1", rows: modelArray)
    }
    override func tearDown() {
        model = nil
    }
    func testModelHasATitle() {
        
        XCTAssertEqual(model.title, "test1",
                       "CountryModel Title should be set in initializer")
        
    }
    
    func testCountryRowsIsNotNilByDefault() {
        XCTAssertNotNil(model.rows,
                        "model rows not be nil")
    }
    
    
    
}
