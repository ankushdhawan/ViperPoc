//
//  TableView+Extension.swift
//  Liscio
//
//  Created by Ankush Dhawan on 03/11/17.
//  Copyright © 2017 Ajay Singh Mehra. All rights reserved.
//

import Foundation
import UIKit
var completionHandler: (() -> Void)?



extension UICollectionView {
    func pullToRefresh( callBack: @escaping () -> Void) {
        let refreshControl = UIRefreshControl()
        self.refreshControl = refreshControl
        completionHandler = callBack
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)


    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        completionHandler!()
    }
    
   func showEmptyScreen(_ message: String) {
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 10, y: self.bounds.height / 2 - 50, width: self.bounds.size.width - 20, height: 100))
        noDataLabel.text = message
        noDataLabel.textAlignment = .center
        noDataLabel.numberOfLines = 0
        self.backgroundView?.addSubview(noDataLabel)
    }
}

