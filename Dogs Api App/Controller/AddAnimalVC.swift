//
//  AddAnimalVC.swift
//  Dogs Api App
//
//  Created by Mahmoud Hamad on 12/11/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import RealmSwift
import Photos

class AddAnimalVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var categoryImageV: UIImageView!
    @IBOutlet weak var animalImageV: UIImageView!
    @IBOutlet weak var nameTextF: UITextField!
    @IBOutlet weak var categoryTextF: UITextField!
    
    lazy var imagePicker = UIImagePickerController()
    
    lazy var realm = try! Realm()    //use it for Query and Save

    enum CategoryOrAnimal {
        case AnimalImage
        case CategoryImage
        case None
    }
    var imageVMode: CategoryOrAnimal = .None
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let location = CLLocationManager()
        
        MAAuthorizations.instance.checkPhotoLibraryPermission()

    }

    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //get the image, array have original, edited & other info
        if let choosenImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            if imageVMode == .AnimalImage {
                animalImageV.image = choosenImage
            } else if imageVMode == .CategoryImage {
                categoryImageV.image = choosenImage
            }
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addImageTappedGes(_ sender: Any) { //Category  //Gesture Recognizer
        imageVMode = .CategoryImage
        
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addAnimalImageTappedGes(_ sender: Any) { //Animal //Gesture Recognizer
        imageVMode = .AnimalImage
        
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        guard categoryImageV.image != UIImage(named: "placeholder"), let category = categoryTextF.text,
            animalImageV.image != UIImage(named: "placeholder") , let name = nameTextF.text
             else {
                let ac = UIAlertController(title: "Sorry", message: "Sorry please fill all info", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(ac, animated: true, completion: nil)

            return
        }
        
        let breed = Breed()
        breed.name = category
        breed.imageData = UIImageJPEGRepresentation(categoryImageV.image!, 0.7)
        
        let subBreed = SubBreed()
        subBreed.name = name
        subBreed.imageData = UIImageJPEGRepresentation(animalImageV.image!, 0.7)
        
        breed.subBreads.append(subBreed)
        
        var thingThatExists = self.realm.object(ofType: Breed.self , forPrimaryKey: breed.name)

        if thingThatExists == nil {

            try! self.realm.write {
                self.realm.add(breed)
                dismiss(animated: true, completion: nil)

            }
        } else {
            print("Sorry This Category Exist")
            
            var thingThatExists2 = self.realm.object(ofType: SubBreed.self , forPrimaryKey: subBreed.name)

            if thingThatExists2 == nil {
            
                try! self.realm.write {
                    
                    var filtered = MainVC.allBreedss?.filter({ (categ) -> Bool in
                        categ.name == category
                    }).first
                    
                    filtered?.subBreads.append(subBreed)
                    
                    //save it to realm
                    self.realm.create(Breed.self, value: filtered, update: true)
                    
                }
                dismiss(animated: true, completion: nil)

            } else {
                let ac = UIAlertController(title: "Sorry", message: "Sorry this Category and animal Name alread exists", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(ac, animated: true, completion: nil)
            }
        }
        
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
