//
//  AnimalDetailsVC.swift
//  Dogs Api App
//
//  Created by Mahmoud Hamad on 12/11/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import RealmSwift

class AnimalDetailsVC: UIViewController {
    
    @IBOutlet weak var BGImageV: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var categoryImgV: UIImageView!
    
    var breed: Breed?
    var selectedSubBreed: SubBreed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        categoryLbl.text = "Category: \(breed?.name.capitalized ?? "")"
        //categoryImgV.image = UIImage(data: breed?.imageData ?? Data())
        categoryImgV.image = UIImage(data: selectedSubBreed?.imageData ?? Data())

        
        nameLbl.text = "Name: \(selectedSubBreed?.name.capitalized ?? "")"
        //BGImageV.image = UIImage(data: selectedSubBreed?.imageData ?? Data())
        BGImageV.image = UIImage(data: breed?.imageData ?? Data())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func backTapped(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
        
        
        self.dismiss(animated: true, completion: nil)
    }

}
