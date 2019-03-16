//
//  CountryVC.swift
//  ViperPoc
//
//  Created by Ankush Dhawan on 3/15/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import UIKit

class CountryVC: UIViewController {

    //MARK:VARIABLE DECELARATION
    var countryInfoPresentor:CountryInfoPresenter? = nil
    private var dataSource = CountryDataSource()
    let flowLayout = UICustomCollectionViewLayout()
    var configurator = CountryConfiguration()

    
    let countryDescCollectionView:UICollectionView = {
        let flowLayout = UICustomCollectionViewLayout()
        flowLayout.numberOfColumns = 1
        let collectionView = UICollectionView(frame:CGRect(x: 0, y: 0, width: 300, height: 300), collectionViewLayout: flowLayout)
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    //MARK:LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configurationCountryInfo(vc: self)
        customInit()
        fetchCountryDetail()
        setUpHandler()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillLayoutSubviews() {
        
        addConstraint()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        Constants.isIpad ? self.setLayoutForIpad() : ()
        
    }
    
    //MARK:PRIVATE METHOD(S)
    func setLayoutForIpad()
    {
        //SHOW UI FOR IPAD OF COLLECTIONVIEW
        if UIDevice.current.orientation.isLandscape {
            print("landscape")
            flowLayout.numberOfColumns = 4
        } else {
            print("portrait")
            flowLayout.numberOfColumns = 3
            
        }
        flowLayout.reloadLayout()
        countryDescCollectionView.reloadData()
        
    }
    
    
    func fetchCountryDetail()
    {
        showLoader(with: self.view)
        let servicePath = JCPostServicePath.countryDetail()
        countryInfoPresentor?.callWebServices(servicePath: servicePath)
    }
    // Handler handle all the callbacks from View Mddek
    func setUpHandler()  {
        // Handle the success response from ViewModel
        countryInfoPresentor?.successViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                hideLoader(parentView: (self?.view)!)
                self?.dataSource.countryDtailModels = self?.countryInfoPresentor?.countryInfo!.rows ?? [CountryDetailModel]()
                self?.countryDescCollectionView.reloadData()
                self?.title = self?.countryInfoPresentor?.countryInfo?.title
                self?.countryInfoPresentor?.countryInfo?.rows.count == 0 ? self?.countryDescCollectionView.showEmptyScreen("No Data Found.") :self?.countryDescCollectionView.showEmptyScreen("")
                self?.countryDescCollectionView.refreshControl?.endRefreshing()
                
            }
        }
        // Handle the Alert Message from view model
        countryInfoPresentor?.showAlertClosure = { [weak self] (messgae) in
            DispatchQueue.main.async {
                hideLoader(parentView: (self?.view)!)
                
                self?.countryDescCollectionView.showEmptyScreen("No Data Found.")
                self?.popupAlert(title:"Alert", message:"No Data Found.", actionTitles: ["Ok"], actions:[{action1 in
                    }, nil])
                
            }
            } as ((String) -> ())
    }
    
    private func customInit()
    {
        //IPAD CASE SHOW 3 COLOUM AND IPHONE CASE SHOW 1 COLOUM
        flowLayout.numberOfColumns = Constants.isIpad ? 3 : 1
        flowLayout.delegate = self
        countryDescCollectionView.collectionViewLayout = flowLayout
        countryDescCollectionView.dataSource = dataSource
        countryDescCollectionView.delegate = self
        self.view.addSubview(countryDescCollectionView)
        //REGISTER CELL
        countryDescCollectionView.register(CountryCell.self, forCellWithReuseIdentifier: Constants.Indentifier.kCountryCell)
        
        countryDescCollectionView.reloadData()
        //PULL TO REFRESH CALL BACK
        countryDescCollectionView.pullToRefresh() { [weak self] in
            self?.fetchCountryDetail()
        }
        
    }
    private func addConstraint()
    {
        let views: [String: Any] = [
            "tableView": countryDescCollectionView]
        var allConstraints: [NSLayoutConstraint] = []
        
        // SET LEADIING AND TRIALING CONSTRAINT TABLEVIEW
        
        let tableViewVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[tableView]-0-|",
            metrics: nil,
            views: views)
        allConstraints += tableViewVerticalConstraints
        
        // SET TOP AND BOTTOM CONSTRAINT TABLEVIEW
        
        let tableViewHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[tableView]-0-|",
            metrics: nil,
            views: views)
        allConstraints += tableViewHorizontalConstraints
        NSLayoutConstraint.activate(allConstraints)
        
    }
    
    //MARK:GRID HEIGHT CALCULATION METHOD(S)
    func getGridHeight(model:CountryDetailModel)->CGSize
    {
        let text = model.description ?? ""
        let width = Constants.isIpad ? (Constants.kScreenWidth/CGFloat(flowLayout.numberOfColumns) - 40) : Constants.kScreenWidth
        return  CGSize(width: width, height: heightForView(text: text, width: width))
        
    }
    
    
    func heightForView(text:String, font:UIFont = UIFont.systemFont(ofSize: 17), width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width - 95, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        let height = (label.frame.height < 30) ? 70.0 : label.frame.height + 50
        return height
    }
    
    
}
extension CountryVC:UICollectionViewDelegate,CustomLayoutDelegate
{
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        if dataSource.countryDtailModels[indexPath.row] != nil
        {
            return getGridHeight(model: dataSource.countryDtailModels[indexPath.row]).height
        }
        return CGSize(width: Constants.kScreenWidth, height: 40).height
    }

}
