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
    var catModel:CountryDetailModel?
    init(catViewController: CountryVC) {
        self.catVC = catViewController
    }
   func navigateCountryDetailVC(cat: CountryDetailModel) {
        catModel = cat
    //ADD THE NAVIGATION CODE IN THIS CONTROLLER
    let vc = CountryDetailVC()
    self.catVC?.navigationController?.pushViewController(vc, animated: true)
        }
    
}
