//
//  TimelineCollectionViewCell.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/29/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import Kingfisher

@IBDesignable
class TimelineCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    /// If index is odd : Gray
    /// else index is even : White
    /// - Parameter index: Index of tableviewcell
    func setColor(for index: Int) {
        if index % 2 == 0 {
            backgroundColor = .white
        } else {
            backgroundColor = UIColor(red: 222, green: 222, blue: 222, alpha: 1) // Almost gray -> white
        }
    }
    
    func setPost(_ post: TimelinePost) {
        usernameLabel.text = post.userName
        if let url = URL(string: post.imageUrl) {
            ImageDownloader.default.downloadImage(with: url, options: [], progressBlock: nil) {
                [unowned self] (image, error, url, data) in
                if let image = image {
                    self.thumbnailImageView.image = image
                    ImageCache.default.store(image, forKey: post.id)
                }
            }
        } else if let image = post.getImage() {
            thumbnailImageView.image = image
        }
        captionLabel.text = post.caption
        let likeImage = post.isLikedByCurrentUser ? #imageLiteral(resourceName: "like_filled_50") : #imageLiteral(resourceName: "like_50") // #imageLiteral
        likeButton.setImage(likeImage, for: .normal)
    }
}
