//
//  CollectionViewTableViewCell.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 27/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var phoneList : [Phone] = []
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(phoneList : [Phone]){
        self.phoneList = phoneList
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
}

extension CollectionViewTableViewCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return phoneList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.setData(model: phoneList[indexPath.row])
        return cell
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var phoneNumber: String = "tel://"
        phoneNumber = phoneNumber + phoneList[indexPath.row].phone
        let whiteSpaces: CharacterSet = CharacterSet.whitespaces
        let noEmptyStrings: NSPredicate = NSPredicate(format: "SELF != ''")
        let parts: NSArray = phoneNumber.components(separatedBy: whiteSpaces) as NSArray
        let filteredArray = parts.filtered(using: noEmptyStrings) as NSArray
        phoneNumber = filteredArray.componentsJoined(by: "")
        if let phoneCallURL: URL = URL(string: phoneNumber) {
            let application: UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2.1, height: 191)
    }
}
