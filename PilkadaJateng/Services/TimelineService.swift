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
import Kingfisher

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
    
    var timelinePosts: [TimelinePost] {
        return _timelinePosts.reversed()
    }
    
    private var _timelinePosts: [TimelinePost] = [
        TimelinePost(id: "abc",
                     image: #imageLiteral(resourceName: "downloading"),
                     caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sed lectus a nulla bibendum viverra a in mauris. Nam porta placerat maximus. Sed porttitor tortor in consequat pellentesque. Nam ultricies sodales pharetra. Ut vestibulum massa lorem, vitae rutrum nulla venenatis ut. Donec sed aliquam quam. Aenean accumsan, neque sed finibus gravida, purus tortor pharetra mauris, at varius orci arcu eget leo. Sed ornare, nunc sed ultrices rutrum, mi neque mollis mi, faucibus eleifend lacus ligula eu risus. Fusce consequat elementum eros eu tempor. Quisque porttitor, dolor ac egestas posuere, nulla purus consectetur lorem, a sodales nisl nisi ac lorem. Cras ac feugiat eros, hendrerit interdum dui. Sed vitae libero ac felis consequat aliquam.",
                     userId: "userId",
                     userName: "userName")
    ]
    
    func parseSnapshot(key: String, value: Any?, completion: @escaping (Error?) -> ()) {
        if let timelineData = value as? [String: AnyObject] {
            let id = key
            if let photoUrl = timelineData["photoUrl"] as? String,
                let caption = timelineData["caption"] as? String,
                let user = timelineData["user"] as? [String: Any],
                let userId = user["id"] as? String,
                let userName = user["name"] as? String {
                let likes = timelineData["likes"] as? [String: String] ?? [:]
                let path = photoUrl.replacingOccurrences(of: STORAGE_URL, with: "", options: NSString.CompareOptions.literal, range:nil)
                _storageRef.child(path).downloadURL(completion: { [unowned self](url, error) in
                    if let url = url?.absoluteString {
                        ImageCache.default.retrieveImage(forKey: id, options: nil) {
                            image, cacheType in
                            if let image = image {
                                self.updateTimelinePost(id: id,
                                                        imageUrl: url,
                                                        image: image,
                                                        caption: caption,
                                                        userId: userId,
                                                        userName: userName,
                                                        likes: likes)
                            } else {
                                self.updateTimelinePost(id: id,
                                                        imageUrl: url,
                                                        caption: caption,
                                                        userId: userId,
                                                        userName: userName,
                                                        likes: likes)
                            }
                            completion(nil)
                        }
                    } else {
                        completion(error)
                    }
                })
            }
        }
    }
    
    private var postFetching: DatabaseHandle?
    func fetchPosts(completion: @escaping (Error?) -> ()) {
        let timelineQuery = _timelineRef.queryLimited(toLast: 20)
        postFetching = timelineQuery.observe(.childAdded) { [unowned self](snapshot) in
            self.parseSnapshot(key: snapshot.key, value: snapshot.value, completion: completion)
        }
    }
    
    func beginListening(completion: @escaping (Error?) -> ()) {
        let timelineQuery = _timelineRef.queryLimited(toLast: 20)
        updateHandle = timelineQuery.observe(.childChanged, with: { [unowned self](snapshot) in
            self.parseSnapshot(key: snapshot.key, value: snapshot.value, completion: completion)
        })
    }
    
    func endListening() {
        if let handle = updateHandle {
            _timelineRef.removeObserver(withHandle: handle)
        }
        if let handle = postFetching {
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
                                likes: likes,
                                isLikedByCurrentUser: false)
        updatePost(caption: caption, forPostWithKey: id)
        _timelinePosts.update(post)
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
    
    func updatePost(caption: String, forPostWithKey key: String) {
        let postRef = _timelineRef.child(key)
        postRef.updateChildValues(["caption": caption])
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

