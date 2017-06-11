//
//  TableViewCell.swift
//  CollectionViewExample
//
//  Created by ashok on 4/25/17.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    @IBOutlet weak var sportsLabel: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var moviesLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if self.tag == 0 {
            
            // pickCollection initialization.
            newsLabel.text = "News"
            //newsCollectionView.frame = self.bounds
            newsCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        else if self.tag == 1 {
            
            // popularCollection initialization.
            sportsLabel.text = "Sports"
            //sportsCollectionView.frame = self.bounds
            sportsCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        else if self.tag == 2 {
            
            // publishCollection initialization.
            moviesLabel.text = "Indian"
            //moviesCollectionView.frame = self.bounds
            moviesCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        
        if self.tag == 0 {
            
            // pickCollection
            newsCollectionView.delegate = dataSourceDelegate
            newsCollectionView.dataSource = dataSourceDelegate
            newsCollectionView.tag = row
            newsCollectionView.reloadData()
        }
        else if self.tag == 1 {
            
            // popularCollection
            sportsCollectionView.delegate = dataSourceDelegate
            sportsCollectionView.dataSource = dataSourceDelegate
            sportsCollectionView.tag = row
            sportsCollectionView.reloadData()
        }
        else if self.tag == 2 {
            
            // publishCollection
            moviesCollectionView.delegate = dataSourceDelegate
            moviesCollectionView.dataSource = dataSourceDelegate
            moviesCollectionView.tag = row
            moviesCollectionView.reloadData()
        }
        
    }
    
    var newsCollectionViewOffset: CGFloat {
        
        get {
            return newsCollectionView.contentOffset.x
        }
        
        set {
            newsCollectionView.contentOffset.x = newValue
        }
    }
    var sportsCollectionViewOffset: CGFloat {
        
        get {
            return sportsCollectionView.contentOffset.x
        }
        set {
            sportsCollectionView.contentOffset.x = newValue
        }
    }
    var moviesCollectionViewOffset: CGFloat {
        
        get {
            return moviesCollectionView.contentOffset.x
        }
        set {
            moviesCollectionView.contentOffset.x = newValue
        }
    }
    
}
