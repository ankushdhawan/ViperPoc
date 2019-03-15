
import Foundation
import UIKit

func showLoader(with parentView:UIView,withMessage message: String = "Please wait...", color: UIColor = .lightGray) -> Void {
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = parentView.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    activityIndicator.startAnimating()
    blurEffectView.contentView.addSubview(activityIndicator)
    activityIndicator.center = blurEffectView.contentView.center
    parentView.addSubview(blurEffectView)
}
    


func hideLoader(parentView:UIView) -> Void {
    parentView.subviews.compactMap {  $0 as? UIVisualEffectView }.forEach {
        $0.removeFromSuperview()
    }
    
}

