//
//  ApplicationCoordinator.swift
//  ViperPoc
//
//  Created by Ankush Dhawan on 3/16/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

class ApplicationCoordinator: Coordinator {
    let window: UIWindow  // 2
    let rootViewController: UINavigationController  // 3
    
    init(window: UIWindow) { //4
        self.window = window
        rootViewController = RootNavVC()
        // Code below is for testing purposes   // 5
        UINavigationBar.appearance().backgroundColor = UIColor.blue
        let vc = CountryVC()
        rootViewController.pushViewController(vc, animated: false)
    }
    
    func start() {  // 6
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
