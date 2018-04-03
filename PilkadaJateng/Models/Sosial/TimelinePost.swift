//
//  TimelinePost.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/29/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

struct TimelinePost {
    let id: String
    let image: UIImage
    let title: String
    let caption: String
    let senderId: String
}

extension TimelinePost: Hashable {
    var hashValue: Int {
        return id.hashValue
    }
    
    static func ==(lhs: TimelinePost, rhs: TimelinePost) -> Bool {
        return lhs.id == rhs.id
    }
}
