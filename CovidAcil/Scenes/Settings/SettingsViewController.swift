//
//  SettingsViewController.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 26/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import UIKit
import DropDown

final class SettingsViewController: MasterViewController {

    @IBOutlet weak var selectedLanguageLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languageView: UIView!
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
        languageLabel.text = getLocalizedStringForKey("language")
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.shareApp))
        recommendView.addGestureRecognizer(gesture)
        
        let languageGesture = UITapGestureRecognizer(target: self, action:  #selector(self.languageSelection))
        languageView.addGestureRecognizer(languageGesture)
        
        if getLanguageKey() == "tr" {
            selectedLanguageLabel.text = getLocalizedStringForKey("turkish")
        }
        else {
            selectedLanguageLabel.text = getLocalizedStringForKey("english")
        }
    }
    
    func updateLanguage() {
        let language: String = getLanguageKey()
        var languageKey: String = "en"
        if selectedLanguageLabel.text == getLocalizedStringForKey("turkish") {
            languageKey = "tr"
        }
        if (languageKey != language) {
            setPref(key: LANGUAGE_KEY, value: languageKey)
            let rV = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CallsViewController") as! CallsViewController
            guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController
            else {
                return
            }
            rV.view.frame = rootViewController.view.frame
            rV.view.layoutIfNeeded()
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = rV
            })
        }
    }
    
    @objc func languageSelection (sender : UITapGestureRecognizer){
        let dropDown = DropDown()
        dropDown.anchorView = languageView
        dropDown.dimmedBackgroundColor = UIColor.init(hex: "000000", alpha: 0.5)
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        DropDown.appearance().setupCornerRadius(10)
        dropDown.dataSource = languages
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectedLanguageLabel.text = languages[index]
            dropDown.hide()
            self.updateLanguage()
        }
        dropDown.show()
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
    
    @IBAction func githubPressed(){
        let webURL = URL(string: "https://github.com/Makers-Covid-19")!
        UIApplication.shared.open(webURL)
    }
}
