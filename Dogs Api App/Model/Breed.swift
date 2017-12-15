//
//  Breed.swift
//  Dogs Api App
//
//  Created by Mahmoud Hamad on 12/10/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import Foundation
import RealmSwift


class Breed: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var imageData: Data? = nil
    var subBreads = List<SubBreed>()
    
    override class func primaryKey() -> String {
        return "name"
    }
}

class SubBreed: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var imageData: Data? = nil

    override class func primaryKey() -> String {
        return "name"
    }
}
