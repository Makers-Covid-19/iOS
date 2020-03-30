//
//  CallsViewController.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 26/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import UIKit
import DropDown

final class CallsViewController: MasterViewController {
        
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var districtView: UIView!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var numbersModel : NumbersModel!
    var cityList : [CityModel] = []
    var districtList : [CityModel] = []
    var cityId = 0
    var districtId = 0
    var cityName = ""
    var districtName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        numbersModel = NumbersModel.init(majorPhones: [], publicPhones: [], globalPhones: [])
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: "NumberCell", bundle: nil), forCellReuseIdentifier: "NumberCell")
        self.tableView.register(UINib(nibName: "CollectionViewTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionViewTableViewCell")
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        cityLabel.text = getLocalizedStringForKey("select_city")
        districtLabel.text = getLocalizedStringForKey("select_district")
                
        getCitiesRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.title = getLocalizedStringForKey("calls")
        super.viewWillAppear(animated)
    }
    
    func getCitiesRequest(){
        let request: CitiesRequest = CitiesRequest.init()
        request.APIRequest(succeed: { (responseData, message) in
            guard let responseModel = try? JSONDecoder().decode([CityModel].self, from: responseData) else { return }
            self.cityList = responseModel
            let cityGesture = UITapGestureRecognizer(target: self, action:  #selector(self.cityAction))
            self.cityView.addGestureRecognizer(cityGesture)
            if (self.cityId == 0 && self.cityList.count > 0){
                self.cityLabel.text = self.cityList[0].name
                self.cityName = self.cityList[0].name
                self.getGeneralNumbersRequest()
            }
        }) { (message) in
            self.numbersModel = UserDefaults.standard.decode(for: NumbersModel.self, using: NUMBER_MODEL)
            self.cityLabel.text = getPrefString(key: CITY_NAME)
            self.districtLabel.text = getPrefString(key: DISTRICT_NAME)
            self.tableView.reloadData()
        }
    }
    
    @objc func cityAction(sender : UITapGestureRecognizer) {
        let dropDown = DropDown()
        dropDown.anchorView = cityView
        dropDown.dimmedBackgroundColor = UIColor.init(hex: "000000", alpha: 0.5)
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        DropDown.appearance().setupCornerRadius(10)
        var cityArray : [String] = []
        for value in cityList {
            cityArray.append(value.name)
        }
        dropDown.dataSource = cityArray
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.cityLabel.text = self.cityList[index].name
            self.cityId = self.cityList[index].id
            self.cityName = self.cityList[index].name
            dropDown.hide()
            self.getGeneralNumbersRequest()
            self.getDistrictsRequest()
            self.numbersModel = NumbersModel.init(majorPhones: [], publicPhones: [], globalPhones: [])
            self.districtLabel.text = getLocalizedStringForKey("select_district")
        }
        dropDown.show()
    }
    
    func getDistrictsRequest(){
        let request: DistrictRequest = DistrictRequest.init(id: cityId)
        request.APIRequest(succeed: { (responseData, message) in
            guard let responseModel = try? JSONDecoder().decode([CityModel].self, from: responseData) else { return }
            self.districtList = responseModel
            let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.districtAction))
            self.districtView.addGestureRecognizer(gesture)
        }) { (message) in }
    }
    
    @objc func districtAction(sender : UITapGestureRecognizer) {
        let dropDown = DropDown()
        dropDown.anchorView = districtView
        dropDown.dimmedBackgroundColor = UIColor.init(hex: "000000", alpha: 0.5)
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        DropDown.appearance().setupCornerRadius(10)
        var array : [String] = []
        for value in districtList {
            array.append(value.name)
        }
        dropDown.dataSource = array
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.districtLabel.text = self.districtList[index].name
            self.districtId = self.districtList[index].id
            self.districtName = self.districtList[index].name
            dropDown.hide()
            self.numbersModel = NumbersModel.init(majorPhones: [], publicPhones: [], globalPhones: [])
            self.getNumbersRequest()
        }
        dropDown.show()
    }
    
    func getGeneralNumbersRequest(){
        let request: GetGeneralNumbersRequest = GetGeneralNumbersRequest.init(id: cityId)
        request.APIRequest(succeed: { (responseData, message) in
            guard let responseModel = try? JSONDecoder().decode(NumbersModel.self, from: responseData) else { return }
            self.numbersModel = responseModel
            setPref(key: CITY_NAME, value: self.cityName)
            setPref(key: DISTRICT_NAME, value: getLocalizedStringForKey("select_district"))
            UserDefaults.standard.encode(for: self.numbersModel, using: NUMBER_MODEL)
            self.tableView.reloadData()
        }) { (message) in }
    }
    
    func getNumbersRequest(){
        let request: GetNumbersRequest = GetNumbersRequest.init(id: districtId)
        request.APIRequest(succeed: { (responseData, message) in
            guard let responseModel = try? JSONDecoder().decode(NumbersModel.self, from: responseData) else { return }
            self.numbersModel = responseModel
            setPref(key: DISTRICT_NAME, value: self.districtName)
            UserDefaults.standard.encode(for: self.numbersModel, using: NUMBER_MODEL)
            self.tableView.reloadData()
        }) { (message) in }
    }
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {

    }

}

extension CallsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0){
            let height : Int = (numbersModel.majorPhones.count + 1) / 2
            return CGFloat((height * 191) + (height * 10))
        }
        else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return 1
        }
        else if (section == 1){
            return numbersModel.publicPhones.count
        }
        else{
            return numbersModel.globalPhones.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewTableViewCell", for: indexPath) as! CollectionViewTableViewCell
            cell.selectionStyle = .none
            cell.setData(phoneList: numbersModel.majorPhones)
            cell.removeMargins()
            return cell
        }
        else if (indexPath.section == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "NumberCell", for: indexPath) as! NumberCell
            cell.selectionStyle = .none
            cell.removeMargins()
            cell.setData(model: numbersModel.publicPhones[indexPath.row])
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NumberCell", for: indexPath) as! NumberCell
            cell.selectionStyle = .none
            cell.removeMargins()
            cell.setData(model: numbersModel.globalPhones[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 1 && numbersModel.publicPhones.count > 0){
            return getLocalizedStringForKey("numbers")
        }
        else if (section == 2 && numbersModel.globalPhones.count > 0){
            return getLocalizedStringForKey("general")
        }
        else{
            return ""
        }
    }
    
    

}

extension CallsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var phoneNumber: String = "tel://"
        if (indexPath.section == 1){
            phoneNumber = phoneNumber + numbersModel.publicPhones[indexPath.row].phone
        }
        else{
            phoneNumber = phoneNumber + numbersModel.globalPhones[indexPath.row].phone
        }
        let whiteSpaces: CharacterSet = CharacterSet.whitespaces
        let noEmptyStrings: NSPredicate = NSPredicate(format: "SELF != ''")
        let parts: NSArray = phoneNumber.components(separatedBy: whiteSpaces) as NSArray
        let filteredArray = parts.filtered(using: noEmptyStrings) as NSArray
        phoneNumber = filteredArray.componentsJoined(by: "")
        
        if (indexPath.section != 0){
            if let phoneCallURL: URL = URL(string: phoneNumber) {
                let application: UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.clear
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.init(hex: "bebebe")
    }
    
}
