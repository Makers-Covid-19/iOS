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
    
    //MARK: - TODO LINK CHANGE
    let iTunesURL: String = "https://itunes.apple.com/app/..."
    
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
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.shareApp))
        recommendView.addGestureRecognizer(gesture)
    }
    
    @objc func shareApp (sender : UITapGestureRecognizer){
        let webURL = URL(string: iTunesURL)
        let activityViewController = UIActivityViewController(activityItems: [getLocalizedStringForKey("share_text"), webURL!], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    func openApp(applicationUrl : String, websiteUrl : String){
        let appURL = URL(string: applicationUrl)!
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        }
        else {
            let webURL = URL(string: websiteUrl)!
            application.open(webURL)
        }
    }
    
    //MARK: - Local
    
    @IBAction func ayvFB(){
        openApp(applicationUrl: "fb://user?screen_name=ayvalikyerelinisiyatif", websiteUrl: "https://www.facebook.com/ayvalikyerelinisiyatif")
    }
    
    @IBAction func ayvTwitter(){
        openApp(applicationUrl: "twitter://user?screen_name=ayvalikyerel", websiteUrl: "https://twitter.com/ayvalikyerel")
    }
    
    @IBAction func ayvInstagram(){
        openApp(applicationUrl: "instagram://user?username=ayvalikyerel", websiteUrl: "https://instagram.com/ayvalikyerel")
    }
    
    @IBAction func ayvWhatsapp(){
        openApp(applicationUrl: "https://api.whatsapp.com/send?phone=+905326682864", websiteUrl: "tel://05326682864")
    }
    
    //MARK: - Gov
    
    @IBAction func govFB(){
        openApp(applicationUrl: "fb://user?screen_name=AyvalikBelediyesi", websiteUrl: "https://www.facebook.com/AyvalikBelediyesi/")
    }
    
    @IBAction func govTwitter(){
        openApp(applicationUrl: "twitter://user?screen_name=AYVALIKBELEDIYE", websiteUrl: "https://twitter.com/AYVALIKBELEDIYE")
    }
    
    @IBAction func govWhatsapp(){
        openApp(applicationUrl: "https://api.whatsapp.com/send?phone=+905331440099", websiteUrl: "tel://05331440099")
    }
}
