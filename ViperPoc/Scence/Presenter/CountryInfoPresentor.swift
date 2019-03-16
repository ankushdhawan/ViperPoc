//
//  CountryPresentor.swift
//  ViperPoc
//
//  Created by Ankush Dhawan on 3/16/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation
import UIKit
protocol GenericProtocol {
    
    //Handler
    var successViewClosure: (()->())? {get set}
    var showAlertClosure: ((String)->())? {get set}
    var alertMessage: String {get set}
}

class CountryInfoPresenter : GenericProtocol{
    
    private let interector:CountryInfoInterector
    private let router:CountryRouter

    // let validator = Validator()
    init(apiInterector:CountryInfoInterector,router:CountryRouter) {
        interector = apiInterector
        self.router = router
    }
    //Handler
    var successViewClosure: (()->())?
    var showAlertClosure: ((String)->())?
    // Model that hold api data
    internal var countryInfo : CountryModel? {
        didSet { self.successViewClosure?() }
    }
    
    //Private
    internal var alertMessage: String = "Error" {
        didSet{
            self.showAlertClosure!(alertMessage)
        }
    }
    
    
    
    func callWebServices(servicePath : JCPostServicePath) {
        let resource = GenericResource(path: servicePath.path.rawValue, method:.GET)
        //Hit the api by sending resource object that holds all request parameter
        interector.fetchCountryData(resource: resource) { (response) in
            if response.isSuccess {
                if let country = response.value {
                    //REMOVE EMPTY RECORD FROM MODEL
                    let rows = country.rows.filter({ (model) -> Bool in
                        let status = (model.description != nil || model.title != nil || model.imageHref != nil)
                        return status
                        
                    })
                    self.countryInfo = country
                    self.countryInfo?.rows = rows
                }
                
            } else {
                self.alertMessage = response.error.debugDescription
            }
            
        }
        
    }
}
