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
        navigationController?.navigationBar.isTranslucent = false
        
        _setupTableView()
        _setupSendButton()
        _setupDoneButton()
    }
    
    private var _commentService: CommentService! = nil
    
    func setService(_ commentService: CommentService) {
        _commentService = commentService
    }
    
    private func _setupTableView() {
        let tv = viewOutlets.tableView
        tv?.dataSource = self
        
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tv?.register(nib, forCellReuseIdentifier: "CommentCell")
    }
    
    private func _setupSendButton() {
        let sendBtn = viewOutlets.sendButton
        sendBtn?.addTarget(self, action: #selector(sendComment), for: .touchUpInside)
    }
    
    private func _setupDoneButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Selesai",
                                                           style: .done, target: self,
                                                           action: #selector(doneComment))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _commentService.beginListening { [unowned self] in
            self.viewOutlets.tableView.reloadData()
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
        cell.usernameLabel.text = comment.username
        cell.commentLabel.text = comment.content
        return cell
    }
}
