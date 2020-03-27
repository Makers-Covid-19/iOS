//
//  SettingsViewController.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 26/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import UIKit

final class SettingsViewController: MasterViewController {

    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var govLabel: UILabel!
    @IBOutlet weak var followLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var notificationsLabel: UILabel!
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var recommendLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.title = getLocalizedStringForKey("settings")
        
        super.viewWillAppear(animated)
    }
    
    func prepareView() {
        settingsLabel.text = getLocalizedStringForKey("settings")
        govLabel.text = getLocalizedStringForKey("government")
        followLabel.text = getLocalizedStringForKey("follow_us")
        notificationsLabel.text = getLocalizedStringForKey("notifications")
        recommendLabel.text = getLocalizedStringForKey("recommend_us")
        fromLabel.text = getLocalizedStringForKey("from")
    }
}
