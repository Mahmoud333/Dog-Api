//
//  MAView.swift
//  Dogs Api App
//
//  Created by Mahmoud Hamad on 12/11/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit

@IBDesignable
class MAView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.white {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 3.0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: -3.0) {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
