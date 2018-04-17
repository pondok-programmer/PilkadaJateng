//
//  CustomFirebaseRef.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/17/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import FirebaseDatabase


/// Create top level child
///
/// - Parameter path: key for reference path
/// - Returns: a Firebase Database Reference object
func FirebaseRefMake(withPath path: String) -> DatabaseReference {
    return Database.database().reference().child(path)
}
