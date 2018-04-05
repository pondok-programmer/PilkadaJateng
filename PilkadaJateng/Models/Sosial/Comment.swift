//
//  Comment.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/4/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

struct Comment {
    let id: String
    let username: String
    let content: String
}

extension Comment: Hashable {
    var hashValue: Int {
        return id.hashValue
    }
    
    static func ==(lhs: Comment, rhs: Comment) -> Bool {
        return lhs.id == rhs.id
    }
}
