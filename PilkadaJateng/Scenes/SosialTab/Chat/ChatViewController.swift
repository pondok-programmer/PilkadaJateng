//
//  ChatViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/27/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import MessageKit

class ChatViewController: MessagesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMessageViewControllerOnDidLoad()
    }
    
    var chatService: ChatService!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        chatService.beginListening { [unowned self] in
            self.messagesCollectionView.reloadDataAndKeepOffset()
            self.messagesCollectionView.scrollToBottom()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        chatService.endListening()
    }
    
    var channel: Channel! {
        didSet {
            title = channel.name
        }
    }
    
    var messageList: [DiskusiMessage]  {
        return chatService.messages
    }
    
    func currentSender() -> Sender {
        return Application.shared.sender!
    }
    
    func newMessage(_ message: DiskusiMessage) {
        chatService.newMessage(message)
    }
}

