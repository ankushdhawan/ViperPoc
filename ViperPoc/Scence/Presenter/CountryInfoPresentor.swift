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
    var showLoaderClosure: ((Bool)->())? {get set}
    var alertMessage: String {get set}
}

protocol CountryInfoProtocol {
    func didSelectRowAtIndexPath(index:IndexPath)
    func fetchAPI()
    func viewDidLoad()
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
    var showLoaderClosure: ((Bool) -> ())?
    var successViewClosure: (()->())?
    var showAlertClosure: ((String)->())?
    //InternalShowLoader
    internal var isLoaderShow : Bool = false {
        didSet {
            print(isLoaderShow)
            self.showLoaderClosure?(isLoaderShow) }
    }
    
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
        interector.fetchCountryData(resource: resource) { [weak self] (response) in
            //HIDE LOADER
            self?.isLoaderShow = false
            if response.isSuccess {
                if let country = response.value {
                    //REMOVE EMPTY RECORD FROM MODEL
                    let rows = country.rows.filter({ (model) -> Bool in
                        let status = (model.description != nil || model.title != nil || model.imageHref != nil)
                        return status
                        
                    })
                    self?.countryInfo = country
                    self?.countryInfo?.rows = rows
                }
                
            } else {
                self?.alertMessage = response.error.debugDescription
            }
            
        }
        
    }
}

extension CountryInfoPresenter:CountryInfoProtocol
{
    
    func viewDidLoad()
    {
        //SHOW LOADER
        self.isLoaderShow = true
        self.fetchAPI()
    }
    func fetchAPI() {
        
        let servicePath = JCPostServicePath.countryDetail()
        self.callWebServices(servicePath: servicePath)
    }
    
    func didSelectRowAtIndexPath(index: IndexPath) {
        
        router.navigateCountryDetailVC(cat:countryInfo!.rows[index.row] )
    }
    
    
}
