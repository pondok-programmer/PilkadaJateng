//
//  ChatService.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/28/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import Firebase
import MessageKit

fileprivate let dateFormat = "dd-MM-yyyy hh:mm:ss"

class ChatService {
    private let _channelRef: DatabaseReference
    private lazy var _messagesRef = self._channelRef.child("messages")
    private var refHandle: DatabaseHandle?
    
    var messages: [DiskusiMessage] = []
    
    init(channelRef: DatabaseReference) {
        _channelRef = channelRef
    }
    
    /// Begin listening should be called in viewWillAppear
    func beginListening(completion: @escaping () -> ()) {
        let messageQuery = _messagesRef.queryLimited(toLast: 25)
        refHandle = messageQuery.observe(.childAdded, with: { (snapshot) in
            if let messageData = snapshot.value as? [String: AnyObject] {
                let id = snapshot.key
                if let text = messageData["text"] as? String,
                let senderName = messageData["senderName"] as? String,
                let senderId = messageData["senderId"] as? String,
                    let date = (messageData["date"] as? String)?
                        .toDate(format: dateFormat) {
                    let sender = Sender(id: senderId, displayName: senderName)
                    let attributedText = NSAttributedString(string: text,
                                                            attributes: [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.blue])
                    
                    let message = DiskusiMessage(attributedText: attributedText,
                                                 sender: sender,
                                                 messageId: id,
                                                 date: date)
                    self.messages.update(message)
                    completion()
                } else {
                    print("Message Data is \(messageData)")
                }
            } else {
                print("Cannot decode \(snapshot)")
            }
        })
    }
    
    /// End listening should be called in viewDidDisappear
    func endListening() {
        if let ref = refHandle {
            _messagesRef.removeObserver(withHandle: ref)
        }
    }
    
    func newMessage(_ message: DiskusiMessage) {
        let newMessage = _messagesRef.childByAutoId()
        let sender = message.sender
        let date = message.sentDate
        
        switch message.data {
        case let .text(text):
            let messageItem = [
                "text": text,
                "senderName": sender.displayName,
                "senderId": sender.id,
                "date": date.toString(format: dateFormat)
            ]
            
            newMessage.setValue(messageItem)
        case let .attributedText(value):
            let messageItem = [
                "text": value.string,
                "senderName": sender.displayName,
                "senderId": sender.id,
                "date": date.toString(format: dateFormat)
            ]
            
            newMessage.setValue(messageItem)
        default:
            fatalError("Not yet implemented!")
        }
    }
}
