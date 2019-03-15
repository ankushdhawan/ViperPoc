
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
static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
}
struct ScreenTitle
{
        static let kTitleSettings = ""
    
    }






    

