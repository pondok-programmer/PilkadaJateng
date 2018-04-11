//
//  TimelineViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/27/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Photos

class TimelineViewController: UIViewController {
    @IBOutlet weak var viewOutlets: TimelineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _timelineService.delegate = self
        _setupCollectionView()
        _setupNewPostButton()
    }
    
    private let _timelineService = TimelineService()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _timelineService.beginListening { (error) in
            if let error = error {
                print(error)
            }
            
            self.viewOutlets.collectionView.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        _timelineService.endListening()
    }
    
    func _setupNewPostButton() {
        let btn = viewOutlets.newPost!
        btn.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
    }
    
    
    let refreshControl = UIRefreshControl()
    private func _setupCollectionView() {
        let cv = viewOutlets.collectionView
        cv?.dataSource = self
        cv?.delegate = self
        
        refreshControl.addTarget(self,
                                 action: #selector(fetchPosts),
                                 for: .valueChanged)
        cv?.addSubview(refreshControl)
        
        let layout = UICollectionViewFlowLayout()
        cv?.collectionViewLayout = layout
        
        
        let nib = UINib(nibName: "TimelineCollectionViewCell", bundle: nil)
        cv?.register(nib, forCellWithReuseIdentifier: "TimelineCell")
    }
    
    @objc func pickImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func fetchPosts() {
        _timelineService.fetchPosts { [unowned self](error) in
            if let error = error {
                self.showError(title: error.localizedDescription)
            }
            self._timelineService.endPostFetching()
            self.refreshControl.endRefreshing()
        }
    }
    
    private func _sendPost(with caption: String) -> String? {
        return _timelineService.sendTimelinePost(userId: Application.shared.user!.id,
                                                 userName: Application.shared.user!.name,
                                                 caption: caption)
    }
    
    private func _setPostUrl(_ url: String, forPostWithKey key: String) {
        _timelineService.setPhotoUrl(url, forPostWithKey: key)
    }
    
    private func _editPost(image: UIImage) {
        let vc = PostEditorViewController(nibName: "PostEditorViewController", bundle: nil)
        vc.image = image
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
}

fileprivate extension Selector {
    static let pickImage = #selector(TimelineViewController.pickImage)
}

class TimelineView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newPost: UIButton!
}

extension TimelineViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _timelineService.timelinePosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimelineCell", for: indexPath) as! TimelineCollectionViewCell
        cell.setColor(for: indexPath.row)
        
        var post = _timelineService.timelinePosts[indexPath.row]
        post.resolveLike(user: Application.shared.user!)
        
        cell.setPost(post)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButton), for: .touchUpInside)
        cell.commentButton.tag = indexPath.row
        cell.commentButton.addTarget(self, action: #selector(commentButton), for: .touchUpInside)
        return cell
    }
    
    // MARK: Like
    @objc func likeButton(_ sender: UIButton) {
        let key = _timelineService.timelinePosts[sender.tag].id
        _timelineService.toggleLike(forPostWithKey: key, from: Application.shared.user!)
    }
    
    // MARK: Comment
    @objc func commentButton(_ sender: UIButton) {
        let vc = CommentViewController(nibName: nil, bundle: nil)
        let key = _timelineService.timelinePosts[sender.tag].id
        vc.setService(CommentService(postRef: _timelineService.getRef(key: key)))
        
        showFromTabBarController(vc)
    }
}

extension TimelineViewController: UICollectionViewDelegate {
    
}

extension TimelineViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = _timelineService.timelinePosts[indexPath.row].caption
        let width = collectionView.frame.size.width
        let height = heightForLabel(text: text, width: width)
        return CGSize(width: width, height: height + 500)
    }
    
    func heightForLabel(text: String, width: CGFloat) -> CGFloat {
        let frame = CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude)
        let label = UILabel(frame: frame)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}

extension TimelineViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let refUrl = info[UIImagePickerControllerReferenceURL] as? URL {
            let assets = PHAsset.fetchAssets(withALAssetURLs: [refUrl], options: nil)
            let asset = assets.firstObject
            
            if let key = _sendPost(with: "Caption") {
                asset?.requestContentEditingInput(with: nil) { [unowned self](input, info) in
                    let imageFileURL = input?.fullSizeImageURL
                    let path = "\(Application.shared.user!.id)/\(Date())/\(refUrl.lastPathComponent))"
                    
                    self._timelineService
                        .uploadPhoto(url: imageFileURL!, path: path) { [unowned self] (path, error) in
                            if let error = error {
                                print(error)
                            }
                            
                            if let path = path {
                                self._timelineService.setPhotoUrl(path, forPostWithKey: key)
                            }
                    }
                }
            }
        } else {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            self._editPost(image: image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension TimelineViewController: PostEditorDelegateViewController {
    func finishEditing(_ timelinePost: (image: UIImage, caption: String)) {
        if let key = _sendPost(with: timelinePost.caption) {
            self._timelineService.updateTimelinePost(id: key,
                                                     image: timelinePost.image,
                                                     caption: timelinePost.caption,
                                                     userId: Application.shared.user!.id,
                                                     userName: Application.shared.user!.name)
            
            let path = "\(Application.shared.user!.id)/\(Date()).jpg"
            let imageData = UIImageJPEGRepresentation(timelinePost.image, 1)!
            self._timelineService
                .uploadPhoto(with: imageData, path: path) { [unowned self] (path, error) in
                    if let error = error {
                        print(error)
                    }
                    
                    if let path = path {
                        self._timelineService.setPhotoUrl(path, forPostWithKey: key)
                    }
            }
        }
    }
}

extension TimelineViewController: TimelinePostDelegateViewController {
    func timelinePostsUpdated() {
        viewOutlets.collectionView.reloadData()
    }
}
