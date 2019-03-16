//
//  CountryRouter.swift
//  ViperPoc
//
//  Created by Ankush Dhawan on 3/16/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation
import UIKit
protocol viewRouter {
    func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)
    
}
extension viewRouter
{
    func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)
    {
    }
}

protocol CountryRouterProtocol:viewRouter {
    func navigateCountryDetailVC(cat: CountryModel)
}
class CountryRouter: CountryRouterProtocol {
   var catVC:CountryVC?
    var catModel:CountryModel?
    init(catViewController: CountryVC) {
        self.catVC = catViewController
    }
   func navigateCountryDetailVC(cat: CountryModel) {
        catModel = cat
        catVC?.performSegue(withIdentifier:"CategoryListController", sender: nil)
    }
    func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
    }
}
