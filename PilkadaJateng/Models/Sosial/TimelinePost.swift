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
    let imageUrl: String
    let image: UIImage?
    let caption: String
    let userId: String
    let userName: String
    let likes: [String: String] 
    
    init(id: String, imageUrl: String = "", image: UIImage? = nil, caption: String, userId: String, userName: String, likes: [String:String] = [:], isLikedByCurrentUser: Bool = false) {
        self.id = id
        self.imageUrl = imageUrl
        self.image = image
        self.caption = caption
        self.userId = userId
        self.userName = userName
        self.likes = likes
        self.isLikedByCurrentUser = isLikedByCurrentUser
    }
    
    private(set) var isLikedByCurrentUser: Bool
    mutating func resolveLike(user: User) {
        isLikedByCurrentUser = likes.contains(where: { $0.key == user.id })
    }
}

extension TimelinePost: Hashable {
    var hashValue: Int {
        return id.hashValue
    }
    
    static func ==(lhs: TimelinePost, rhs: TimelinePost) -> Bool {
        return lhs.id == rhs.id
    }
}
