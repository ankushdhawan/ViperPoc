//
//  CountryRouter.swift
//  ViperPoc
//
//  Created by Ankush Dhawan on 3/16/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation
import UIKit


protocol CountryRouterProtocol {
    func navigateCountryDetailVC(cat: CountryDetailModel)
}
class CountryRouter: CountryRouterProtocol {
   var catVC:CountryVC?
    init(catViewController: CountryVC) {
        self.catVC = catViewController
    }
   func navigateCountryDetailVC(cat: CountryDetailModel) {
    //ADD THE NAVIGATION CODE IN THIS CONTROLLER
        }
    
}
