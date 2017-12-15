//
//  CategoryDetailsVC.swift
//  Dogs Api App
//
//  Created by Mahmoud Hamad on 12/11/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class CategoryDetailsVC: UIViewController {

    @IBOutlet weak var categoryImageV: UIImageView!
    @IBOutlet weak var cateogryTitleLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var breed: Breed?
    
    let realm = try! Realm()    //use it for Query and Save

    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryImageV.image = UIImage(data: breed?.imageData ?? Data())
        cateogryTitleLbl.text = breed?.name.capitalized ?? ""
        
        tableView.delegate = self; tableView.dataSource = self
        
/*
        let url = "https://dog.ceo/api/breed/\(breed?.name ?? "")/list"
        //print(url)
        Alamofire.request(url).responseJSON { (response) in
            //print(response.value)
            let json = JSON(response.value)
            
            let allSubBreedJson = json["message"].arrayValue
        }
*/
        //1- for loop breed
        //2- get url for random image for every subbread
        //3- get imageData for every subbread
        //4- save it to realm and reload collection
        
        //1
        for i in 0..<breed!.subBreads.count {
            
            if breed?.subBreads[i].imageData == nil  {
            
            //2
            //Image //https://dog.ceo/api/breed/hound/afghan/images/random
            let RanImgUrl = URL(string: "https://dog.ceo/api/breed/\(breed?.name.replacingOccurrences(of:  " ", with: "") ?? "")/\(breed?.subBreads[i].name.replacingOccurrences(of:  " ", with: "") ?? "")/images/random")

            Alamofire.request(RanImgUrl!).responseJSON { (response) in
                //print(response.value)
                let json = JSON(response.value)
                
                let imgUrl = json["message"].stringValue
                
                //3
                Alamofire.request(imgUrl).responseData { (response) in
                    print("CategoryDetailsVC \(response)")
                    
                    if let data = response.value {
                        
                        try! self.realm.write {
                            
                            self.breed?.subBreads[i].imageData = data
                            
                            //save it to realm
                            self.realm.create(SubBreed.self, value: self.breed?.subBreads[i], update: true)
                            //get the dog reference from the database
                            let realmDog = self.realm.object(ofType: SubBreed.self, forPrimaryKey: self.breed?.subBreads[i].name)
                            
                            //make our breed subbreeds[i] equal to realmDog
                            //breed.subBreads.append(realmDog!)
                            self.breed?.subBreads[i] = realmDog ?? SubBreed()
                            
                            self.tableView.reloadData()
                            print("reload tableView")
                        }
                    }
                }
            }
            }
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {

        self.dismissFrom(from: .FromLeft)
        self.dismiss(animated: false, completion: nil)

    }
    
}

extension CategoryDetailsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SubBreedCell", for: indexPath) as? SubBreedCell {
            cell.titleLbl.text = breed?.subBreads[indexPath.row].name.capitalized
            cell.imageV.image = UIImage(data: breed?.subBreads[indexPath.row].imageData ?? Data())
            print("cellForRowAt")
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(94)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breed?.subBreads.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToAnimalDetailsVC", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToAnimalDetailsVC" {
            if let dvc = segue.destination as? AnimalDetailsVC {
                dvc.breed = breed
                dvc.selectedSubBreed = breed?.subBreads[sender as? Int ?? 0]
            }
        }
    }
}
