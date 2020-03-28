//
//  CollectionViewCell.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 27/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var icon: UIImageView!    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    let images : [String] = ["all_needs_icon","grocery_icon","bills_icon","shopping_icon","coordincation_icon","psy_support_icon"]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(model : Phone){
        phoneLabel.text = model.phone
        descLabel.text = model.name
        categoryLabel.text = model.category.name
        icon.image = UIImage(named: images[model.category.id])
    }
    
}
