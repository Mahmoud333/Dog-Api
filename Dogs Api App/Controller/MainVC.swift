//
//  ViewController.swift
//  Dogs Api App
//
//  Created by Mahmoud Hamad on 12/10/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

//1st: All
//https://dog.ceo/api/breeds/list

//2nd: List sub breeds.
// /breed/{breed}/list


import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift
import FBSDKLoginKit

class MainVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let realm = try! Realm()    //use it for Query and Save
    
    static var allBreedss:Results<Breed>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self; collectionView.dataSource = self;

        
        if !Connectivity.isConnectedToInternet() {
            MainVC.allBreedss = realm.objects(Breed.self)
            collectionView.reloadData()
            print("SMGL: No Connection")
            
            return 
        }
        
        //In viewDidAppear
        /*
        let quered = realm.objects(Breed.self)//its like Rx it connects all breeds classes to it
        MainVC.allBreedss = quered
        try! realm.write {
            //realm.delete(quered)
        }*/
        
        //1- Get list of master breeds
        //2- get sub breed of each master breeds and check if they are more than 0
        //3- if they are more than 0, then get a random picture url of it
        //4- get the picture data of that url and store all of this
        //4.2- add the subbreeds to breeds subBreeds array
        
        //1
        Alamofire.request("https://dog.ceo/api/breeds/list").responseJSON { (response) in
            let json = JSON(response.value)
            
            let allBreedsJson = json["message"].arrayValue
            
            //2
            for b in allBreedsJson {
                
                let url = "https://dog.ceo/api/breed/\(b.stringValue)/list" //print(url)
                
                Alamofire.request(url).responseJSON { (response) in
                    //print(response.value)
                    let json = JSON(response.value)
                    
                    let allSubBreedJson = json["message"].arrayValue
                    
                    if allSubBreedJson.count > 0 {
                        
                        
                        //3
                        //get image
                        //url https://dog.ceo/api/breed/hound/images/random
                        let imageURL = "https://dog.ceo/api/breed/\(b.stringValue)/images/random"
                        Alamofire.request(imageURL).responseJSON { (response) in
                            //print(response.value)
                            let json = JSON(response.value)
                            
                            let randomImageUrl = json["message"].stringValue
                            //print(randomImageUrl)
                            
                            //4
                            let imgUrl = URL(string: randomImageUrl)

                            Alamofire.request(imgUrl!).responseData { (response) in
                                print(response)
                                
                                if let data = response.value {
                                    
                                    var breed = Breed()
                                    breed.name = b.stringValue
                                    breed.imageData = data
                                    
                                    //4.2
                                    for subBJ in allSubBreedJson{
                                        var subB = SubBreed()
                                        subB.name = subBJ.stringValue
                                        
                                        try! self.realm.write {
                                        
                                        //save it to realm
                                        self.realm.create(SubBreed.self, value: subB, update: true)
                                        //get the dog reference from the database
                                        let realmDog = self.realm.object(ofType: SubBreed.self, forPrimaryKey: subBJ.stringValue)
                                            //append realmDog to subBreads
                                            breed.subBreads.append(realmDog!)
                                        }
                                    }
                                    var thingThatExists = self.realm.object(ofType: Breed.self , forPrimaryKey: breed.name)
                                    
                                    
                                    if (thingThatExists == nil) {
                                        print("== nil")
                                        try! self.realm.write {
                                            
                                            self.realm.add(breed)
                                            
                                            //self.allBreedss.append(breed)
                                            //self.allBreedss?.realm?.add(breed)
                                            self.collectionView.reloadData()


                                        }
                                    } else { print("else not nil") }
                                }
                            }
                        }
                        
                        
                        //print(breed.name)
                        //self.allBreedss.append(breed)
                        //self.collectionView.reloadData()
                    }
                }
                
                
                /*
                var breed = Breed()
                breed.name = b.stringValue
                //print(breed.name)
                self.allBreedss.append(breed)
                 */
            }
            
            self.collectionView.reloadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let quered = realm.objects(Breed.self)//its like Rx it connects all breeds classes to it
        MainVC.allBreedss = quered
        try! realm.write {
            //realm.delete(quered)
        }
        collectionView.reloadData()
        
        //if the user is already logged in
        if FBSDKAccessToken.current() == nil {
            
            performSegue(withIdentifier: "GoToSignInVC", sender:nil)
        }
    }
    
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreedCell", for: indexPath) as? BreedCell {
            
            cell.titleLbl.text = MainVC.allBreedss![indexPath.row].name.capitalized
            let img = UIImage(data: MainVC.allBreedss![indexPath.row].imageData!)
            cell.imageV.image = img
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainVC.allBreedss?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let breed = MainVC.allBreedss![indexPath.row]
        performSegue(withIdentifier: "GoToCategoryDetails", sender: breed)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToCategoryDetails" {
            if let dvc = segue.destination as? CategoryDetailsVC {
                dvc.breed = sender as? Breed
            }
        }

        //1- custom Dismiss For SearchVC & AddAnimalVC
        if let destinationViewController = segue.destination as? SearchVC {
            destinationViewController.transitioningDelegate = self
        } else if let destinationViewController = segue.destination as? AddAnimalVC {
            destinationViewController.transitioningDelegate = self
        }
    }
}

//2- Custom Dismiss
extension MainVC: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("ViewController animationController")

        if let dismissedFrom = dismissed as? SearchVC {
            print("dismissedFrom = dismissed")
            return DismissAnimator()

        } else if let dismissedFrom = dismissed as? AddAnimalVC {
            
            print("dismissedFrom = dismissed")
            return DismissAnimator()
        }
        
        return nil
    }
    
}

