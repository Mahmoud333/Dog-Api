//
//  SearchVC.swift
//  Dogs Api App
//
//  Created by Mahmoud Hamad on 12/12/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import RealmSwift

class SearchVC: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var animals = [SearchSaved]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        //tableView.register(BasicTableCell.self, forCellReuseIdentifier: "BasicTableCell")
        
        searchBar.delegate = self

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        animals.removeAll()
        if searchText == nil || searchText == " " {
            self.view.endEditing(true)         //will make keyboard disappear
            
        }
        
        if searchText != nil {
            print("searchText != nil ")
            
            for breed in MainVC.allBreedss! {
                print("searching")
                
                print("\(breed.name) == \(searchText.lowercased())")
                if breed.name.lowercased().contains(searchText.lowercased()) {
                    let save = SearchSaved()
                    save.imgData = breed.imageData ?? Data()
                    save.name = breed.name
                    
                    animals.append(save)
                    print("Found breed")
                }
                
                for subBreed in breed.subBreads {
                    
                    print("\(subBreed.name) == \(searchText.lowercased())")

                    if subBreed.name.lowercased().contains(searchText.lowercased()) {
                        let save = SearchSaved()
                        save.imgData = subBreed.imageData ?? Data()
                        save.name = subBreed.name
                        
                        animals.append(save)
                        print("Found subbreed")

                    }
                }
                tableView.reloadData()

            }

            
        }
    }
    @IBAction func cancelTapped(_ sender: Any) {
        //dismissFrom(from: .FromTop)
        dismiss(animated: true, completion: nil)
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BasicTableCell", for: indexPath) as? BasicTableCell {
        
            print(cell.titleLbl)
            cell.titleLbl.text = animals[indexPath.row].name
            cell.imageV.image = UIImage(data: animals[indexPath.row].imgData)
            
            
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.text = animals[indexPath.row].name
    }
}

class BasicTableCell: UITableViewCell {
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageV.layer.cornerRadius = imageV.frame.height / 2
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class SearchSaved {
    var name: String!
    var imgData: Data!
}
