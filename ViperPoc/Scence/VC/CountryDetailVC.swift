//
//  CountryDetailVC.swift
//  ViperPoc
//
//  Created by Ankush Dhawan on 3/17/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation
import UIKit

class CountryDetailVC: UIViewController {
    
   
    let titleLabel:UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
        
    
    }()
    let DescriptionLabel:UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
        
        
    }()

    
    let countryImageVIew:UIImageView = {
        var imageView = ScaledHeightImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "PlaceHolder")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    //MARK:LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
       self.view.addSubview(countryImageVIew)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillLayoutSubviews() {
        
        addConstraint()
    }
    private func addConstraint()
    {
        let views: [String: Any] = [
            "countryImageVIew": countryImageVIew,"titleLabel":titleLabel,"DescriptionLabel":DescriptionLabel]
        var allConstraints: [NSLayoutConstraint] = []
        
        // SET LEADIING AND TRIALING CONSTRAINT TABLEVIEW
        
        let containerHorizenralConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[countryImageVIew(100)]|", options: .alignAllCenterY, metrics: nil, views: views)
        
        let containerverticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-150-[countryImageVIew(200)]", metrics: nil, views: views)

       
        
      
       allConstraints += containerHorizenralConstraints
        allConstraints += containerverticalConstraints
        NSLayoutConstraint.activate(allConstraints)
        
    }
    
    
    
}
