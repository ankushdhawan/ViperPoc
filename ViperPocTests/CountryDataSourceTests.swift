//
//  CountryDataSourceTests.swift
//  ViperPocTests
//
//  Created by Ankush Dhawan on 3/16/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation
import XCTest
@testable import ViperPoc

class CountryDataSourceTests: XCTestCase {
    var dataSource: CountryDataSource!
    let flowLayout = UICustomCollectionViewLayout()
    
    let collectionView:UICollectionView = {
        let flowLayout = UICustomCollectionViewLayout()
        flowLayout.numberOfColumns = 3
        let collectionView = UICollectionView(frame:CGRect(x: 0, y: 0, width: 300, height: 300), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    override func setUp() {
        super.setUp()
        
        dataSource = CountryDataSource()
        // Register cell
        flowLayout.numberOfColumns = Constants.isIpad ? 3 : 1
        collectionView.collectionViewLayout = flowLayout
        collectionView.register(CountryCell.self, forCellWithReuseIdentifier: Constants.Indentifier.kCountryCell)
        // Add Dummy data in In the model
        for number in 0..<20 {
            let model = CountryDetailModel(title: "Tile:\(number)", description:"description:\(number)" , imageHref: "url:\(number)")
            dataSource.countryDtailModels.append(model)
        }
    }
    
    func testDataSourceHasCountries() {
        XCTAssertEqual(dataSource.countryDtailModels.count, 20,
                       "DataSource should have correct number of CountryModelArray")
    }
    
    
    
    func testHasOneSectionWhenCountryArePresent() {
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 1,
                       "collectionview should have one section when CountryModelArray are present")
    }
    
    func testNumberOfRows() {
        let numberOfRows = dataSource.collectionView(collectionView, numberOfItemsInSection: 20)
        XCTAssertEqual(numberOfRows, 20,
                       "Number of rows in table should match number of CountryModelArray")
    }
    func testCellForCustomClass()
    {
        //Check table view cell class
        let cell = dataSource.collectionView(collectionView, cellForItemAt: IndexPath(row:0, section:0))
        guard cell is CountryCell  else {
            return XCTFail("Controller's  collectionview cell should have a country tableView cell")
        }
    }
    
    func testCellForRow() {
        //Check data source providing right data to cell
        testCellForCustomClass()
        let cell = dataSource.collectionView(collectionView, cellForItemAt: IndexPath(row:0, section:0))as! CountryCell
        XCTAssertEqual(cell.titleLable.text, "Tile:0",
                       "The first cell should display name of first Country")
    }
    
    
}

