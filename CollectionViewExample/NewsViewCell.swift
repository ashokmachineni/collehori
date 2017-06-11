//
//  NewsViewCell.swift
//  CollectionViewExample
//
//  Created by ashok on 4/25/17.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class NewsViewCell: UICollectionViewCell {
    
    @IBOutlet var newsImages: UIImageView!
    @IBOutlet var newsLabels: UILabel!
    
    override func awakeFromNib() {
        self.setNeedsLayout()
        
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    
    
}
