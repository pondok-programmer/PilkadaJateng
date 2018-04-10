//
//  CommentViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/4/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    @IBOutlet weak var viewOutlets: CommentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Komentar"
        
        _setupTableView()
        _setupSendButton()
    }
    
    private var _commentService: CommentService! = nil
    
    func setService(_ commentService: CommentService) {
        _commentService = commentService
    }
    
    private func _setupTableView() {
        let tv = viewOutlets.tableView
        tv?.dataSource = self
        tv?.separatorStyle = .none
        
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tv?.register(nib, forCellReuseIdentifier: "CommentCell")
    }
    
    private func _setupSendButton() {
        let sendBtn = viewOutlets.sendButton
        sendBtn?.addTarget(self, action: #selector(sendComment), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _commentService.beginListening { [unowned self] in
            DispatchQueue.main.async {
                self.viewOutlets.tableView.reloadData()
                let indexPath = IndexPath(row: self._commentService.comments.count - 1,
                                          section: 0)
                
                UIView.animate(withDuration: 0.1, animations: {
                    self.viewOutlets.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                })
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        _commentService.endListening()
    }
    
    @objc func sendComment() {
        if let content = viewOutlets.textField.text,
            !content.isEmpty {
            _commentService.sendComment(content: content, username: Application.shared.user!.name)
        }
    }
    
    @objc func doneComment() {
        dismiss(animated: true, completion: nil)
    }
}

class CommentView: UIView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
}

extension CommentViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _commentService.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        let comment = _commentService.comments[indexPath.row]
        let formattedText = NSMutableAttributedString()
        formattedText
            .bold(comment.username)
            .normal(" ")
            .normal(comment.content)
        
        cell.label.attributedText = formattedText
        return cell
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String, size: CGFloat = 17) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "Arial-BoldMT", size: size)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}
