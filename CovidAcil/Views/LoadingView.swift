//
//  LoadingView.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 26/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    
    class func startLoading() {
        let window: UIWindow = UIApplication.shared.keyWindow!
        
        let spinnerViewWidth: CGFloat = isDeviceiPad() ? UIScreen.main.bounds.size.width * 0.35 : UIScreen.main.bounds.size.width * 0.5
        let spinnerViewHeight: CGFloat = isDeviceiPad() ? 150 : 110
        let spinnerViewVerticalMargin: CGFloat = 8
        
        let shadowView: UIView = UIView(frame: window.frame)
        shadowView.tag = 1001
        shadowView.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3)
        
        let backView: UIView = UIView(frame: CGRect(x: (window.frame.size.width - spinnerViewWidth) / 2, y: (window.frame.size.height - spinnerViewHeight) / 2, width: spinnerViewWidth, height: spinnerViewHeight))
        backView.tag = 1002
        backView.layer.cornerRadius = 15
        backView.backgroundColor = UIColor.white
        
        let topView: UIView = UIView(frame: CGRect(x: (window.frame.size.width - spinnerViewWidth) / 2, y: ((window.frame.size.height - spinnerViewHeight) / 2) + 8, width: spinnerViewWidth, height: (spinnerViewHeight * 0.65) - spinnerViewVerticalMargin))
        topView.tag = 1003
        let bottomView: UIView = UIView(frame: CGRect(x: (window.frame.size.width - spinnerViewWidth) / 2, y: topView.frame.origin.y + topView.frame.size.height, width: spinnerViewWidth, height: (spinnerViewHeight * 0.35) - spinnerViewVerticalMargin))
        bottomView.tag = 1004
        
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x: (topView.frame.size.width - activityIndicatorView.frame.size.width) / 2, y: (topView.frame.size.height - activityIndicatorView.frame.size.height) / 2, width: activityIndicatorView.frame.size.width, height: activityIndicatorView.frame.size.height)
        activityIndicatorView.tag = 1005
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = UIColor.init(hex: themeColor)
        topView.addSubview(activityIndicatorView)
        
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: bottomView.frame.size.width, height: bottomView.frame.size.height))
        label.tag = 1006
        label.font = getSansFont(punto: 17)
        label.font = UIFont(name: label.font!.fontName, size: label.font!.pointSize + (isDeviceiPad() ? 3 : 0))
        label.textColor = UIColor.init(hex: themeColor)
        label.textAlignment = .center
        label.text = getLocalizedStringForKey("loading")
        bottomView.addSubview(label)
        
        activityIndicatorView.startAnimating()
        
        window.addSubview(shadowView)
        window.addSubview(backView)
        window.addSubview(topView)
        window.addSubview(bottomView)
    }
    
    class func stopLoading() {
        let window: UIWindow = UIApplication.shared.keyWindow!
        let shadowView: UIView? = window.viewWithTag(1001)
        let backView: UIView? = window.viewWithTag(1002)
        let topView: UIView? = window.viewWithTag(1003)
        let bottomView: UIView? = window.viewWithTag(1004)
        let activityIndicatorView: UIActivityIndicatorView? = window.viewWithTag(1005) as? UIActivityIndicatorView
        let label: UILabel? = window.viewWithTag(1006) as? UILabel
        
        activityIndicatorView?.stopAnimating()
        
        activityIndicatorView?.removeFromSuperview()
        label?.removeFromSuperview()
        bottomView?.removeFromSuperview()
        topView?.removeFromSuperview()
        backView?.removeFromSuperview()
        shadowView?.removeFromSuperview()
    }
}
