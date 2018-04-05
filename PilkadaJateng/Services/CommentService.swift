//
//  CommentService.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/4/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import FirebaseDatabase

class CommentService {
    private let _commentRef: DatabaseReference
    private var _refHandle: DatabaseHandle? = nil
    init(postRef: DatabaseReference) {
        _commentRef = postRef.child("comments")
    }
    
    private(set) var comments: [Comment] = []
    
    func beginListening(closure: @escaping () -> ()) {
        _refHandle = _commentRef.observe(.childAdded, with: { [unowned self] (snapshot) in
            if let commentData = snapshot.value as? [String: AnyObject] {
                let id = snapshot.key
                if let username = commentData["username"] as? String,
                    let content = commentData["content"] as? String {
                    let comment = Comment(id: id,
                                          username: username,
                                          content: content)
                    self.comments.update(comment)
                    closure()
                }
            }
        })
    }
    
    func endListening() {
        if let handle = _refHandle {
            _commentRef.removeObserver(withHandle: handle)
        }
    }
    
    func sendComment(content: String, username: String) {
        let newComment = _commentRef.childByAutoId()
        let item = [
            "username": username,
            "content": content
        ]
        
        newComment.setValue(item)
    }
}
