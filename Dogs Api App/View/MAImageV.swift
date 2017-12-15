//
//  MAImageV.swift
//  Dogs Api App
//
//  Created by Mahmoud Hamad on 12/11/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit

@IBDesignable
class MAImageV: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
