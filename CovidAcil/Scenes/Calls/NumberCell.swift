//
//  NumberCell.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 27/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import UIKit

class NumberCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(model : Phone){
        titleLabel.text = model.name
        descLabel.text = model.category.name
        phoneLabel.text = model.phone
    }
}
