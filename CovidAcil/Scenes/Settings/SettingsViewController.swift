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
    
    //MARK: - Local
    
    @IBAction func ayvFB(){
        let appURL = URL(string: "fb://user?screen_name=ayvalikyerelinisiyatif")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        }
        else {
            let webURL = URL(string: "https://www.facebook.com/ayvalikyerelinisiyatif")!
            application.open(webURL)
        }
    }
    
    @IBAction func ayvTwitter(){
        let appURL = URL(string: "twitter://user?screen_name=ayvalikyerel")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        }
        else {
            let webURL = URL(string: "https://twitter.com/ayvalikyerel")!
            application.open(webURL)
        }
    }
    
    @IBAction func ayvInstagram(){
        let appURL = URL(string: "instagram://user?username=ayvalikyerel")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        }
        else {
            let webURL = URL(string: "https://instagram.com/ayvalikyerel")!
            application.open(webURL)
        }
    }
    
    @IBAction func ayvWhatsapp(){
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=+905326682864")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        }
        else{
            if let url = URL(string: "tel://05326682864") {
                UIApplication.shared.open(url)
            }
        }
    }
    
    //MARK: - Gov
    
    @IBAction func govFB(){
        if let url = URL(string: "https://www.facebook.com/AyvalikBelediyesi/") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func govTwitter(){
        let appURL = URL(string: "twitter://user?screen_name=AYVALIKBELEDIYE")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        }
        else {
            let webURL = URL(string: "https://twitter.com/AYVALIKBELEDIYE")!
            application.open(webURL)
        }
    }
    
    @IBAction func govWhatsapp(){
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=+905331440099")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        }
        else{
            if let url = URL(string: "tel://05331440099") {
                UIApplication.shared.open(url)
            }
        }
    }
}
