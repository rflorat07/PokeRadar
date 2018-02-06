//
//  Pokemon.swift
//  PokeRadar
//
//  Created by Roger Florat on 06/02/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class Pokemon: NSObject {
    
    var id : Int
    var name : String
    var image : UIImage
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        self.image = UIImage(named: "\(id).png")!
    }
    
}
