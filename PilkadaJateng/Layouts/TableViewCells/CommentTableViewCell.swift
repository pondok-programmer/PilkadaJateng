//
//  CommentTableViewCell.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/5/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    
    /// Assign to UILabel attributedText
    /// bold : username
    /// normal : comment
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
