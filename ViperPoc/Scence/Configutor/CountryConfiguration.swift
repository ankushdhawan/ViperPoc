//
//  CountryConfiguration.swift
//  ViperPoc
//
//  Created by Ankush Dhawan on 3/16/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation
protocol CountryConfigurationProtocol {
    func configurationCountryInfo(vc:CountryVC)
}
class CountryConfiguration:CountryConfigurationProtocol  {
   
    
    func configurationCountryInfo(vc: CountryVC)
    {
       
        let apiClient = APIService()
        let  interector = CountryInfoInterector(client: apiClient)
        let router = CountryRouter(catViewController:vc)
        let presenter = CountryInfoPresenter(apiInterector: interector, router: router)
        vc.countryInfoPresentor = presenter
    }
}
