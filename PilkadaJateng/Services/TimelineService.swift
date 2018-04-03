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
    
    var timelinePosts: [TimelinePost] = []
    
    func beginListening(completion: @escaping (Error?) -> ()) {
        let timelineQuery = _timelineRef.queryLimited(toLast: 20)
        updateHandle = timelineQuery.observe(.childChanged, with: { [unowned self](snapshot) in
            if let timelineData = snapshot.value as? [String: AnyObject] {
                let id = snapshot.key
                if let photoUrl = timelineData["photoUrl"] as? String,
                    let senderId = timelineData["senderId"] as? String,
                    let title = timelineData["title"] as? String,
                    let caption = timelineData["caption"] as? String {
                    self.fetchPhoto(url: photoUrl, completion: { (image, error) in
                        if let image = image {
                            self.updateTimelinePost(id: id,
                                                    image: image,
                                                    title: title,
                                                    caption: caption,
                                                    senderId: senderId)
                        }
                        completion(error)
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
                            image: UIImage,
                            title: String,
                            caption: String,
                            senderId: String) {
        let post = TimelinePost(id: id,
                                image: image,
                                title: title,
                                caption: caption,
                                senderId: senderId)
        timelinePosts.update(post)
        delegate?.timelinePostsUpdated()
    }
    
    func sendTimelinePost(senderId: String) -> String? {
        let newPostRef = _timelineRef.childByAutoId()
        
        let item = [
            "photoUrl": URL_NOT_SET,
            "senderId": senderId,
            "title": "MyTytile",
            "caption": "MyCaption"
        ]
        
        newPostRef.setValue(item)
        return newPostRef.key
    }
    
    
    func setPhotoUrl(_ url: String, forPostWithKey key: String) {
        let postRef = _timelineRef.child(key)
        postRef.updateChildValues(["photoUrl": url])
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
}

