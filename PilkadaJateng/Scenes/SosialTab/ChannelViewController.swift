//
//  ChannelViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/28/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import Firebase
import PKHUD

class ChannelListViewController: UIViewController {
    @IBOutlet weak var viewOutlets: ChannelListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupTableView()
        _setupNewChannelButton()
    }
    
    private let _channelService = ChannelService()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _channelService.beginListening { [unowned self] in
            self.viewOutlets.tableView.reloadData()
        }
    }
    
    func _setupNewChannelButton() {
        let btn = viewOutlets.newChannel!
        btn.addTarget(self, action: #selector(createChannel), for: .touchUpInside)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        _channelService.endListening()
    }
    
    private func _setupTableView() {
        let tv = viewOutlets.tableView
        tv?.dataSource = self
        tv?.delegate = self
        
        let nib = UINib(nibName: "ChannelTableViewCell", bundle: nil)
        tv?.register(nib, forCellReuseIdentifier: "ChannelCell")
    }
    
    @objc func createChannel() {
        let alertVC = UIAlertController(title: "Grup Baru", message: nil, preferredStyle: .alert)
        alertVC.addTextField { (textField) in
            textField.placeholder = "Nama Grup"
        }
        let cancelAction = UIAlertAction(title: "Batal", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { [unowned self](_) in
            if let name = alertVC.textFields?[0].text, !name.isEmpty {
                self._channelService.createNew(name: name)
                self.hudSuccessAddGroup(withName: name)
            } else {
                self._channelService.createNew(name: "Grup Baru")
                self.hudSuccessAddGroup(withName: "Grup Baru")
            }
        }
        
        alertVC.addAction(okAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func hudSuccessAddGroup(withName name: String) {
        let pkhudView = PKHUDSuccessView(title: "\(name) Ditambahkan", subtitle: nil)
        PKHUD.sharedHUD.contentView = pkhudView
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: 1)
    }
}

class ChannelListView: UIView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newChannel: UIButton!
}

extension ChannelListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = _channelService.openChannel(at: indexPath.row)
        let cVC = ChatViewController(nibName: "ChatViewController", bundle: nil)
        cVC.chatService = ChatService(channelRef: data.channelRef)
        cVC.channel = data.selectedChannel
        
        showFromTabBarController(cVC)
    }
}

extension ChannelListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _channelService.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell",for: indexPath) as! ChannelTableViewCell
        cell.channelNameLabel.text = _channelService.channels[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
