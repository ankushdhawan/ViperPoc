//
//  File.swift
//  ViperPoc
//
//  Created by Ankush Dhawan on 3/15/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import UIKit
import Kingfisher
class CountryCell: UICollectionViewCell {
    //MARK:DECELARTION OF OBJECTS
    var containerView:UIView = {
        var view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var titleLable:UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var descriptionLable:UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    var countryImageView:ScaledHeightImageView = {
        var imageView = ScaledHeightImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    //MARK: LIFE CYCLE
    override func layoutSubviews() {
        DispatchQueue.main.async {  [weak self] in
            // REMOVE TOP SPACE FROM DESCRIPTION LABEL USE SIZE TO FIT
            self?.descriptionLable.sizeToFit()
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addConstraint()
        
        // Initialization code
    }
    
    //MARK:PUBLIC METHOD(S)
    public func configureView(model:CountryDetailModel?)
    {
        self.addSubview(containerView)
        containerView.addSubview(countryImageView)
        containerView.addSubview(titleLable)
        containerView.addSubview(descriptionLable)
        // SET MODEL CONTENT TO LABEL AND IMAGE
        titleLable.text = model?.title
        descriptionLable.text = model?.description
        // CHECK IMAGE IS URL NOT LOADING IMAGE THEN SHOW PLACEHOILDER IMAGE
        let url = URL(string: model?.imageHref ?? "")
        countryImageView.kf.indicatorType = .activity
        countryImageView.kf.setImage(with: url) {[weak self] result in
            switch result {
            case .success(let value):
                print(value.image)
            case .failure( _):
                self?.countryImageView.image = UIImage(named: "PlaceHolder")
                
            }
        }
    }
    //MARK:PRIVATE METHOD(S)
    private  func addConstraint()
    {
        let views: [String: Any] = [
            "containerView": containerView,"titleLable":titleLable,"descriptionLable":descriptionLable,"countryImageView":countryImageView]
        var allConstraints: [NSLayoutConstraint] = []
        
        // SET TOP AND BOTTOM CONSTRAINT CONTAINER VIEW
        
        let containerVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[containerView]-0-|",
            metrics: nil,
            views: views)
        allConstraints += containerVerticalConstraints
        
        // SET LEADIING AND TRIALING CONSTRAINT CONTAINER VIEW
        
        let containerHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[containerView]-0-|",
            metrics: nil,
            views: views)
        allConstraints += containerHorizontalConstraints
        
        // SET LEADIING AND TRIALING CONSTRAINT countryImageView and titleLable
        
        let imageViewHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[countryImageView(70)]-5-[titleLable]-5-|",
            metrics: nil,
            views: views)
        allConstraints += imageViewHorizontalConstraints
        
        // SET TOP AND BOTTOM CONSTRAINT countryImageView
        
        let imageViewVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-10-[countryImageView(70)]",
            metrics: nil,
            views: views)
        allConstraints += imageViewVerticalConstraints
        
        // SET TOP AND BOTTOM CONSTRAINT titleLable and descriptionLable
        
        let titleVerticalVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-2-[titleLable(25)]-2-[descriptionLable]-5-|",
            metrics: nil,
            views: views)
        allConstraints += titleVerticalVerticalConstraints
        
        // SET LEADING AND TRAILING CONSTRAINT countryImageView and descriptionLable
        
        let descriptionLabelHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[countryImageView(100)]-5-[descriptionLable]-5-|",
            metrics: nil,
            views: views)
        allConstraints += descriptionLabelHorizontalConstraints
        
        NSLayoutConstraint.activate(allConstraints)
        self.layoutIfNeeded()
        
        
        
        
    }
    
    
    
    
}
