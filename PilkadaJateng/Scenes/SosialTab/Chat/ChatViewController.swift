//
//  ChatViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/27/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import MessageKit
import IQKeyboardManagerSwift
import DZNEmptyDataSet

class ChatViewController: MessagesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMessageViewControllerOnDidLoad()
        setupDZNDataSet()
    }
    
    var chatService: ChatService!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        chatService.beginListening { [unowned self] in
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToBottom()
        }
        IQKeyboardManager.sharedManager().enable = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        chatService.endListening()
        IQKeyboardManager.sharedManager().enable = true
    }
    
    var channel: Channel? {
        didSet {
            title = channel!.name
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

extension ChatViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func setupDZNDataSet() {
        self.messagesCollectionView.emptyDataSetSource = self
        self.messagesCollectionView.emptyDataSetDelegate = self
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Belum Ada Percakapan"
        let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Ketika ada pesan, kamu akan melihatnya di sini."
        let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "message_green_100")
    }
}

