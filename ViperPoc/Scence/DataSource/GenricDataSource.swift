//
//  GenricDataSource.swift
//  ViperPoc
//
//  Created by Ankush Dhawan on 3/26/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation
import UIKit


class GenricDataSource<T:BaseCell<U>,U:Codable>: NSObject, UICollectionViewDataSource   {
    
    var itemList = [U]()
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:BaseCell<U> = collectionView.dequeueReusableCell(withReuseIdentifier:String(describing: T.self), for: indexPath) as! T
        cell.configure(model:itemList[indexPath.row])   
        cell.awakeFromNib()
        return cell
    }
    
    
    
    
    
}
