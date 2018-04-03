//
//  DiskusiMessage.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/28/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import MessageKit

struct DiskusiMessage: MessageType {
    var sender: Sender
    
    var messageId: String
    
    var sentDate: Date
    
    var data: MessageData
    
    init(data: MessageData, sender: Sender, messageId: String, date: Date) {
        self.data = data
        self.sender = sender
        self.messageId = messageId
        self.sentDate = date
    }
    
    init(text: String, sender: Sender, messageId: String, date: Date) {
        self.init(data: .text(text), sender: sender, messageId: messageId, date: date)
    }
    
    init(attributedText: NSAttributedString, sender: Sender, messageId: String, date: Date) {
        self.init(data: .attributedText(attributedText), sender: sender, messageId: messageId, date: date)
    }
    
    init(image: UIImage, sender: Sender, messageId: String, date: Date) {
        self.init(data: .photo(image), sender: sender, messageId: messageId, date: date)
    }
}

extension DiskusiMessage: Hashable {
    var hashValue: Int {
        return messageId.hashValue
    }
    
    static func ==(lhs: DiskusiMessage, rhs: DiskusiMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }
}
