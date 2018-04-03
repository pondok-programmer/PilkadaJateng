//
//  Channel.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/28/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

struct Channel {
    let id: String
    let name: String
}

extension Channel: Hashable {
    var hashValue: Int {
        return id.hashValue
    }
    
    static func ==(lhs: Channel, rhs: Channel) -> Bool {
        return lhs.id == rhs.id
    }
}
