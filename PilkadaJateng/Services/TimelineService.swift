//
//  TimelineService.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/29/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import MessageKit

fileprivate let URL_NOT_SET = "URL_NOT_SET"
fileprivate let STORAGE_URL = "gs://pilkada-jateng-ios.appspot.com/"

protocol TimelinePostDelegateViewController: class {
    func timelinePostsUpdated()
}

class TimelineService {
    private lazy var _timelineRef = Database.database().reference().child("timelines")
    private lazy var _storageRef = Storage.storage().reference(forURL: STORAGE_URL)
    private var updateHandle: DatabaseHandle?
    
    weak var delegate: TimelinePostDelegateViewController?
    
    init() {}
    
    var timelinePosts: [TimelinePost] = [
        TimelinePost(id: "abc",
                     image: #imageLiteral(resourceName: "chat_50"),
                     caption: "caption",
                     userId: "userId",
                     userName: "userName")
    ]
    
    func beginListening(completion: @escaping (Error?) -> ()) {
        print(("Muhammad's iPhone/2018-04-02 07:06:23 +0000.jpg" as NSString).lastPathComponent)
        
        let timelineQuery = _timelineRef.queryLimited(toLast: 20)
        updateHandle = timelineQuery.observe(.childChanged, with: { [unowned self](snapshot) in
            if let timelineData = snapshot.value as? [String: AnyObject] {
                let id = snapshot.key
                if let photoUrl = timelineData["photoUrl"] as? String,
                    let caption = timelineData["caption"] as? String,
                    let user = timelineData["user"] as? [String: Any],
                    let userId = user["id"] as? String,
                    let userName = user["name"] as? String {
                    
                    self._storageRef.child("\(UIDevice.current.name)/\((photoUrl as NSString).lastPathComponent)").downloadURL(completion: { (url, error) in
                        if let url = url?.absoluteString {
                            let likes = timelineData["likes"] as? [String: String] ?? [:]
                            self.updateTimelinePost(id: id,
                                                    imageUrl: url,
                                                    caption: caption,
                                                    userId: userId,
                                                    userName: userName,
                                                    likes: likes)
                            completion(error)
                        }
                    })
                }
            }
        })
    }
    
    func endListening() {
        if let handle = updateHandle {
            _timelineRef.removeObserver(withHandle: handle)
        }
    }
    
    func updateTimelinePost(id: String,
                            imageUrl: String = "",
                            image: UIImage? = nil,
                            caption: String,
                            userId: String,
                            userName: String,
                            likes: [String: String] = [:]) {
        let post = TimelinePost(id: id,
                                imageUrl: imageUrl,
                                image: image,
                                caption: caption,
                                userId: userId,
                                userName: userName,
                                isLikedByCurrentUser: false)
        timelinePosts.update(post)
        delegate?.timelinePostsUpdated()
    }
    
    func sendTimelinePost(userId: String, userName: String, caption: String) -> String? {
        let newPostRef = _timelineRef.childByAutoId()
        
        let item: [String: Any] = [
            "photoUrl": URL_NOT_SET,
            "user": [
                "id": userId,
                "name": userName
            ],
            "caption": caption,
            "likes": [:]
        ]
        
        newPostRef.setValue(item)
        return newPostRef.key
    }
    
    
    func setPhotoUrl(_ url: String, forPostWithKey key: String) {
        let postRef = _timelineRef.child(key)
        postRef.updateChildValues(["photoUrl": url])
    }
    
    
    /// Menambah jumlah like dengan memasukkan ID user ke dalam array like
    ///
    /// - Parameters:
    ///   - key: Post yang disukai
    ///   - user: User yang menyukai
    func toggleLike(forPostWithKey key: String, from user: User) {
        _timelineRef.child(key).observeSingleEvent(of: .value) { [unowned self](snapshot) in
            if let post = snapshot.value as? [String: AnyObject] {
                if var likes = post["likes"] as? [String: String] {
                    if likes.contains(where: {$0.key == user.id }) {
                        likes.removeValue(forKey: user.id)
                    } else {
                        likes[user.id] = user.name
                    }
                    self._timelineRef.child(key).updateChildValues(["likes": likes])
                } else {
                    let firstLike = [
                        user.id:user.name
                    ]
                    self._timelineRef.child("\(key)/likes").setValue(firstLike)
                }
            }
        }
    }
    
    func updatePost(_ url: String, caption: String, forPostWithKey key: String) {
        let postRef = _timelineRef.child(key)
        postRef.updateChildValues(["photoUrl": url,
                                   "caption": caption])
    }
    
    func uploadPhoto(url: URL,
                     path: String,
                     completion: @escaping (String? ,Error?) -> ()) {
        _storageRef
            .child(path)
            .putFile(from: url, metadata: nil) { (metadata, error) in
                let path = self._storageRef.child((metadata?.path)!).description
                completion(path, error)
        }
    }
    
    func uploadPhoto(with imageData: Data,
                     path: String,
                     completion: @escaping (String? ,Error?) -> ()) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _storageRef
            .child(path)
            .putData(imageData, metadata: metadata) { (metadata, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                let path = self._storageRef.child((metadata?.path)!).description
                completion(path, error)
        }
    }
    
    func fetchPhoto(url: String, completion: @escaping (UIImage?, Error?)->()) {
        guard url.hasPrefix("gs://") ||
            url.hasPrefix("https://") ||
            url.hasPrefix("http://") else { return }
        
        let storageRef = Storage.storage().reference(forURL: url)
        storageRef.getData(maxSize: Int64.max) { (data, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            storageRef.getMetadata(completion: { (metadata, metadataErr) in
                if let error = metadataErr {
                    completion(nil, error)
                    return
                }
                
                if metadata?.contentType == "image/jpeg" {
                    let image = UIImage(data: data!)
                    completion(image, nil)
                }
            })
        }
    }
    
    func getRef(key: String) -> DatabaseReference {
        return _timelineRef.child(key)
    }
}

