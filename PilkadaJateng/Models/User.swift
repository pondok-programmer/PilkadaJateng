 //
//  User.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import UIKit

 struct User {
    var id: String
    var name: String
    var photo: UIImage?
    init(id: String, name: String, photo: UIImage? = nil) {
        self.id = id
        self.name = name
        self.photo = photo
    }
 }
