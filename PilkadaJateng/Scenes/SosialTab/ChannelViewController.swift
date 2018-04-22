//
//  ChannelViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/28/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import PKHUD
import DZNEmptyDataSet

class ChannelListViewController: UIViewController {
    @IBOutlet weak var viewOutlets: ChannelListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupTableView()
        setupDZNDataSet()
        _setupNewChannelButton()
        setupSearchBar()
    }
    
    private let _channelService = ChannelService()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if _channelService.channels.isEmpty {
            HUD.show(.labeledProgress(title: nil, subtitle: nil))
        }
        _channelService.beginListening { [unowned self] in
            HUD.hide()
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
    
    // MARK: Search Bar
    var searchActive = false
    var searchResult: [Channel] = []
}

class ChannelListView: UIView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newChannel: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
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
        if searchActive {
            return searchResult.count
        }
        return _channelService.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell",for: indexPath) as! ChannelTableViewCell
        
        var data: [Channel] {
            if searchActive {
                return searchResult
            } else {
                return _channelService.channels
            }
        }
        
        cell.channelNameLabel.text = data[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ChannelListViewController: UISearchBarDelegate {
    func setupSearchBar() {
        viewOutlets.searchBar.delegate = self
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResult = _channelService.channels
            .filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        
        if searchResult.count == 0 {
            searchActive = false
        } else {
            searchActive = true
        }
        viewOutlets.tableView.reloadData()
    }
}

extension ChannelListViewController: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func setupDZNDataSet() {
        viewOutlets.tableView.emptyDataSetSource = self
        viewOutlets.tableView.emptyDataSetDelegate = self
        viewOutlets.tableView.tableFooterView = UIView()
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Halo"
        let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Ayo buat grup baru untuk berdiskusi tentang Pilkada Jateng 2018."
        let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView?) -> UIImage? {
        return UIImage(named: "discussion_red_100")
    }
}


