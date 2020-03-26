//
//  Utilities.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 26/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import UIKit
import MapKit
import Toast_Swift

func getAppName() -> String {
    return Bundle.main.infoDictionary!["CFBundleName"] as! String
}

func getActiveViewController() -> UIViewController! {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.activeViewController
}

func isDeviceiPad() -> Bool {
    if (UIDevice.current.userInterfaceIdiom == .pad) {
        return true
    }
    
    return false
}

func getAppType() -> String {
    if isDeviceiPad() {
        return "1"
    }
    
    return "0"
}

func getLocalizedStringForKey(_ key: String) -> String {
    let path = Bundle.main.path(forResource: getLanguageKey(), ofType: "lproj")
    let bundle = Bundle(path: path!)
    
    if (bundle != nil) {
        return NSLocalizedString(key, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    else {
        return NSLocalizedString(key, comment: "")
    }
}

func getLanguageKey() -> String {
    if getStringPreference(key: LANGUAGE_KEY) != nil {
        return getStringPreference(key: LANGUAGE_KEY)!
    }
    else {
        return Locale.current.languageCode!
    }
}

func directionsAction(title: String, coordinate: CLLocationCoordinate2D) {
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = title
    
    MKMapItem.openMaps(with: [mapItem], launchOptions: launchOptions)
}

func getRegularFont(punto: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue-Regular", size: punto) ?? UIFont.systemFont(ofSize: punto, weight: UIFont.Weight.regular)
}

func getLightFont(punto: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue-Light", size: punto) ?? UIFont.systemFont(ofSize: punto, weight: UIFont.Weight.light)
}

func getMediumFont(punto: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue-Medium", size: punto) ?? UIFont.boldSystemFont(ofSize: punto)
}

func getBoldFont(punto: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue-Bold", size: punto) ?? UIFont.boldSystemFont(ofSize: punto)
}

func configureToastView() {
    var style = ToastStyle()
    style.backgroundColor = UIColor.init(hex: themeColor)
    style.messageColor = UIColor.white
    style.titleAlignment = NSTextAlignment.center
    style.messageAlignment = NSTextAlignment.center
    style.titleFont = getRegularFont(punto: 14)
    style.messageFont = getRegularFont(punto: 14)
    
    ToastManager.shared.style = style
    ToastManager.shared.isQueueEnabled = false
    ToastManager.shared.isTapToDismissEnabled = true
}

func showToastOnTop(message: String, title: String?, duration: TimeInterval) {
    UIApplication.shared.keyWindow!.makeToast(message, duration: duration, position: .top, title: title, style: ToastManager.shared.style)
}

func showToastOnCenter(message: String, title: String?, duration: TimeInterval) {
    UIApplication.shared.keyWindow!.makeToast(message, duration: duration, position: .center, title: title, style: ToastManager.shared.style)
}

func showToastOnBottom(message: String, title: String?, duration: TimeInterval) {
    UIApplication.shared.keyWindow!.makeToast(message, duration: duration, position: .bottom, title: title, style: ToastManager.shared.style)
}
