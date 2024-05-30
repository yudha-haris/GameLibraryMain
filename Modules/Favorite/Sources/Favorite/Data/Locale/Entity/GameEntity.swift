//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 26/05/24.
//

import Foundation
import RealmSwift

public class GameEntity: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var rating: Float = 0.0
    @objc dynamic var image: Data?
    @objc dynamic var desc: String = ""
    
    public override class func primaryKey() -> String? {
        return "id"
    }
}
