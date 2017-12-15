//
//  SubBreedCell.swift
//  Dogs Api App
//
//  Created by Mahmoud Hamad on 12/11/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit

class SubBreedCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageV.clipsToBounds = true
        imageV.layer.cornerRadius = imageV.bounds.height / 2
    }

    

}
