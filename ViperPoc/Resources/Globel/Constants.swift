//
//  Constants.swift
//  ViperPoc
//
//  Created by Ankush Dhawan on 3/16/19.
//  Copyright © 2019 Reliance. All rights reserved.
//


import Foundation
import UIKit
struct Constants {

    struct Indentifier
    {
        static let kCountryCell = "CountryCell"
        
    }
    static var isIpad:Bool {
    
    return UIDevice.current.userInterfaceIdiom == .pad
    
    }
    static var kScreenWidth:CGFloat
{
        get{
            return  UIScreen.main.bounds.width
        }
    }
static var kScreenHeight = UIScreen.main.bounds.height
    
}







    

