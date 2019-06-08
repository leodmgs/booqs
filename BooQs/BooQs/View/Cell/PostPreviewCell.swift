//
//  PostPreviewCell.swift
//  BooQs
//
//  Created by Leonardo Domingues on 6/8/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import UIKit

class PostPreviewCell: UICollectionViewCell {

    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var postTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postImageView.layer.masksToBounds = true
        postImageView.layer.cornerRadius = 5
    }

}
