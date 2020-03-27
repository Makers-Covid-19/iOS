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
    
    var cityList : [CityModel] = []
    var districtList : [CityModel] = []
    var cityId = 0
    var districtId = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityLabel.text = getLocalizedStringForKey("select_city")
        districtLabel.text = getLocalizedStringForKey("select_district")
        
        let districtGesture = UITapGestureRecognizer(target: self, action:  #selector(self.cityAction))
        districtView.addGestureRecognizer(districtGesture)
        
        getCitiesRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.title = getLocalizedStringForKey("calls")
        
        super.viewWillAppear(animated)
    }
    
    func prepareView() {
        
    }
    
    func getCitiesRequest(){
        let request: CitiesRequest = CitiesRequest.init()
        request.APIRequest(succeed: { (responseData, message) in
            guard let responseModel = try? JSONDecoder().decode([CityModel].self, from: responseData) else { return }
            self.cityList = responseModel
            let cityGesture = UITapGestureRecognizer(target: self, action:  #selector(self.cityAction))
            self.cityView.addGestureRecognizer(cityGesture)
            self.prepareView()
        }) { (message) in }
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
            dropDown.hide()
            self.getDistrictsRequest()
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
            self.prepareView()
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
            dropDown.hide()
        }
        dropDown.show()
    }
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        print("Unwind to Root View Controller")
    }

}
