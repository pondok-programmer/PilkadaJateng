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
                }
            } else {
                fatalError("Cannot decode \(snapshot)")
            }
            completion()
        })
        completion()
    }
    
    /// End listening should be called in viewDidDisappear
    func endListening() {
        if let ref = refHandle {
            _channelRef.removeObserver(withHandle: ref)
        }
    }
    
    func createNew(name: String) {
        let newChannel = _channelRef.childByAutoId()
        let channelItem = [
            "name": name
        ]
        newChannel.setValue(channelItem)
    }
    
    func openChannel(at index: Int) -> (selectedChannel: Channel, channelRef: DatabaseReference){
        return (channels[index], _channelRef.child(channels[index].id))
    }
}
