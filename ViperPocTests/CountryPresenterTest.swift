//
//  CountryPresenterTest.swift
//  ViperPocTests
//
//  Created by Ankush Dhawan on 3/16/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation
import UIKit
@testable import ViperPoc
import XCTest

class CountryPresenterTest: XCTestCase
{
//    var sut: CountryInfoPresenter!
    var model:CountryModel!
    
    var mockAPIService: MockService!
    override func setUp() {
        super.setUp()
      }
    override func tearDown() {
        //sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    func testMockApi()
    {
        mockAPIService = MockService()
        var isSuccess = false
        var count = 0
        
        let client = CountryInfoInterector(client: mockAPIService)
        let resource = GenericResource(path: "Country", method:.GET)
        let expect = XCTestExpectation(description: "reload closure triggered")
        client.fetchCountryData(resource: resource) { [weak self] (response) in
            isSuccess = response.isSuccess
            count = response.value?.rows.count ?? 0
            self?.model = response.value!
            
            expect.fulfill()
        }
        XCTAssertTrue(isSuccess == true,
                      "MOCK SERVICE DATA NOT LOAD")
        XCTAssertTrue(count == 13,
                      "Record Count not right")
        wait(for: [expect], timeout: 3.0)
        
    }
    func testRealServerApi()
    {
        
        mockAPIService = MockService()
        
        let servicePath = JCPostServicePath.countryDetail()
        var isSuccess = false
        var count = 0
        
        let client = CountryInfoInterector()
        let resource = GenericResource(path: servicePath.path.rawValue, method:.GET)
        let expect = XCTestExpectation(description: "reload closure triggered")
        client.fetchCountryData(resource: resource) { [weak self] (response) in
            isSuccess = response.isSuccess
            count = response.value?.rows.count ?? 0
            self?.model = response.value!
            XCTAssertTrue(isSuccess == true,
                          "MOCK SERVICE DATA NOT LOAD")
            XCTAssertTrue(count > 0,
                          "Record Count not right")
            expect.fulfill()
        }
        
        
    }
    func testBasePathCorrect()
    {
        let servicePath = JCPostServicePath.countryDetail()
        let resource = GenericResource(path: servicePath.path.rawValue, method:.GET)
        let endPoint = JCConfigEndPoints()
        XCTAssertEqual(resource.basePath, endPoint.appMode.baseEndPoint())
    }
    func testRecordContentFill()
    {
        testMockApi()
        XCTAssertNotNil(model)
        XCTAssertNotNil(model.rows)
        model.rows.forEach { (model) in
            let status = (model.description != nil || model.title != nil || model.imageHref != nil)
            print("check",status)
            XCTAssertTrue(status,"NULL record found")
            
            
        }
    }
}
