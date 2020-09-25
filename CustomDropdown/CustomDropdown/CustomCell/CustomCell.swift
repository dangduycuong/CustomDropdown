//
//  CustomCell.swift
//  CustomDropdown
//
//  Created by Dang Duy Cuong on 9/25/20.
//  Copyright © 2020 Dang Duy Cuong. All rights reserved.
//

import UIKit

class CustomCell: DropDownCell {

    @IBOutlet weak var flagImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
