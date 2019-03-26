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
   // private var dataSource = CountryDataSource()
    var dataSource : GenricDataSource<CountryCell,CountryDetailModel> =  GenricDataSource<CountryCell,CountryDetailModel>()
    let flowLayout = UICustomCollectionViewLayout()
    var configurator = CountryConfiguration()

    
    let countryDescCollectionView:UICollectionView = {
        let flowLayout = UICustomCollectionViewLayout()
        flowLayout.numberOfColumns = 1
        let collectionView = UICollectionView(frame:CGRect(x: 0, y: 0, width: 300, height: 300), collectionViewLayout: flowLayout)
        collectionView.alwaysBounceHorizontal = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    //MARK:LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationObserver()
        configurator.configurationCountryInfo(vc: self)
        customInit()
        setUpHandler()
        countryInfoPresentor?.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
   
    override func viewWillLayoutSubviews() {
        
        addConstraint()
    }
    //MARK:DESTROY OBJECT FROM MEMORY
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    //MARK:DEVICE ORIENTATION WILL CHANGE METHOD

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        Constants.isIpad ? self.setLayoutForIpad() : ()
        // setLayoutForIpad()
    }
    //MARK:DEVICE ORIENTATION DID CHANGE METHOD

    @objc func deviceOrientationDidChange()  {
        print("deviceDidRotate")
        //   setLayoutForIpad()
        !Constants.isIpad ? self.setLayoutForIphone() : ()
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
    
    func setLayoutForIphone()
    {
        //SHOW UI FOR IPHONE OF COLLECTIONVIEW
        flowLayout.reloadLayout()
        countryDescCollectionView.reloadData()
        
    }
    func addNotificationObserver()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
   
    // Handler handle all the callbacks from View Mddek
    func setUpHandler()  {
        countryInfoPresentor?.showLoaderClosure = { [weak self] (signal) in
            print(signal)
            signal ? showLoader(with: self!.view) : hideLoader(parentView: self!.view)
            
        }
        
        
        // Handle the success response from ViewModel
        countryInfoPresentor?.successViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                hideLoader(parentView: (self?.view)!)
                self?.dataSource.itemList = self?.countryInfoPresentor?.countryInfo!.rows ?? [CountryDetailModel]()
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
            self?.countryInfoPresentor?.fetchAPI()
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
        self.view.layoutIfNeeded()
}
    
    //MARK:GRID HEIGHT CALCULATION METHOD(S)
    func getGridHeight(model:CountryDetailModel)->CGSize
    {
        let text = model.description ?? ""
        let width = Constants.isIpad ? (Constants.kScreenWidth/CGFloat(flowLayout.numberOfColumns) - 40) : Constants.kScreenWidth
        print(width)
        return  CGSize(width: width, height: heightForView(text: text, width: width))
        
    }
    
    
    func heightForView(text:String, font:UIFont = UIFont.systemFont(ofSize: 17), width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width - 95, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        let height = (label.frame.height < 30) ? 80.0 : label.frame.height + 50
        return height
    }
    //MARK:SCROLLVIEW DELGATE
    //FOR BOUNCING LEFT RIGHT ISSUE I USE THIS CODE
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == countryDescCollectionView {
            //you will never bounce to left
            scrollView.contentOffset.x = max(0,scrollView.contentOffset.x - 40)
        }
    }
    
    
}
extension CountryVC:UICollectionViewDelegate,CustomLayoutDelegate
{
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        if dataSource.itemList[indexPath.row] != nil
        {
            return getGridHeight(model: dataSource.itemList[indexPath.row]).height
        }
        return CGSize(width: Constants.kScreenWidth, height: 40).height
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        countryInfoPresentor?.didSelectRowAtIndexPath(index:indexPath)
    }

}
