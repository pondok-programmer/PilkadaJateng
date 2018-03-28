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
        _setupNavigationItem()
    }
    
    var chatService: ChatService!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        chatService.beginListening { [unowned self] in
            self.messagesCollectionView.reloadDataAndKeepOffset()
            self.messagesCollectionView.scrollToBottom()
        }
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
    
    private lazy var _sender: Sender = {
        return Sender(id: UUID().uuidString, displayName: "MName \(arc4random() % 16)")
    }()
    
    func currentSender() -> Sender {
        return _sender
    }
    
    func newMessage(_ message: DiskusiMessage) {
        chatService.newMessage(message)
    }
    
    private func _setupNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: .dismiss)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}

fileprivate extension Selector {
    static let dismiss = #selector(ChatViewController.dismissViewController)
}
