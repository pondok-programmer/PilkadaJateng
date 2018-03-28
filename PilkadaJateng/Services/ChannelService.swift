//
//  ChannelService.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/28/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import Firebase

class ChannelService {
    private lazy var _channelRef = Database.database().reference().child("channels")
    private var refHandle: DatabaseHandle?
    
    var channels: [Channel] = []
    
    init() {
    }
    
    /// Begin listening should be called in viewWillAppear
    func beginListening(completion: @escaping () -> ()) {
        refHandle = _channelRef.observe(.childAdded, with: { [unowned self](snapshot) in
            if let channelData = snapshot.value as? [String: AnyObject] {
                let id = snapshot.key
                if let name = channelData["name"] as? String {
                    self.channels.update(Channel(id: id, name: name))
                    completion()
                }
            } else {
                fatalError("Cannot decode \(snapshot)")
            }
        })
    }
    
    /// End listening should be called in viewDidDisappear
    func endListening() {
        if let ref = refHandle {
            _channelRef.removeObserver(withHandle: ref)
        }
    }
    
    func createNew(closure: @escaping (DatabaseReference) -> ()) {
        closure(_channelRef)
    }
}
