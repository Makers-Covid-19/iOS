//
//  CustomTabBarController.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 26/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import UIKit

final class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor.init(hex: themeColor)
        self.tabBar.barTintColor = UIColor.white
        
        self.tabBar.items?[0].title = getLocalizedStringForKey("calls")
        self.tabBar.items?[1].title = getLocalizedStringForKey("my_contacts")
        self.tabBar.items?[2].title = getLocalizedStringForKey("settings")
    }
    
}
