//
//  CustomNavigationVC.swift
//  CurrencyConverter
//
//  Created by Mahmoud Hamad on 11/23/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit

class CustomNavigationVC: UINavigationController {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        
        /*
        let backButton = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Chalkduster", size: 30)], for: .normal)
        self.navigationItem.backBarButtonItem = backButton
        self.navigationBar.ba
        self.navigationBar.backItem = backButton*/
        
        
        //@nd
        //custom font
        let customFont = UIFont(name: "Chalkduster", size: 24)!  //note we're force unwrapping here,"Chalkduster"
        
        //navigation bar coloring:
        UINavigationBar.appearance().tintColor = UIColor.lightGray
        UINavigationBar.appearance().barTintColor = UIColor.blue


        
        
        //unique text style
        var fontAttributes: [NSAttributedStringKey: Any]
        fontAttributes = [NSAttributedStringKey.foregroundColor: UIColor.init(white: 1.0, alpha: 1.0), NSAttributedStringKey.font: customFont]
        //NSAttributedStringKey.backgroundColor: UIColor.init(white: 0.8, alpha: 0.1
        
        
        //navigation bar & navigation buttons font style:
        UINavigationBar.appearance().titleTextAttributes = fontAttributes
        UIBarButtonItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
    }
    

    
}
