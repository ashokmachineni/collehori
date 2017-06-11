//
//  ViewController.swift
//  CollectionViewExample
//
//  Created by ashok on 4/24/17.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var jsondata = [JsonData]()
    var array_News = [JsonData]()
    var array_Sports = [JsonData]()
    var array_Movies = [JsonData]()
    var dataImage: UIImage!
    var storedOffsets = [Int: CGFloat]()
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.separatorStyle = .none
        
        let url=URL(string:"http://thecodeeasy.com/test/swiftjson.json")
        do {
            let allContactsData = try Data(contentsOf: url!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            if let arrJSON = allContacts["actors"] {
            
            for index in 0...arrJSON.count-1 {
                
                let aObject = arrJSON[index] as! [String : AnyObject]
                //print(aObject)
                let data = JsonData()
                data.json_imageUrl = aObject["image"] as! String
                data.json_title = aObject["title"] as! String
                data.json_category = aObject["category"] as! String
                jsondata.append(data)
            }
        }
    }
    catch {
        print("error")
    }
        
    for index in 0...jsondata.count - 1 {
            
        if jsondata[index].json_category == "News" {
            array_News.append(jsondata[index])
        }
        if jsondata[index].json_category == "Sports" {
            array_Sports.append(jsondata[index])
        }
        if jsondata[index].json_category == "Indian" {
            array_Movies.append(jsondata[index])
        }
    }
    print("news.count is \(array_News.count)")
    print("Sports.count is \(array_Sports.count)")
 }
    
    func ConvertImages(image: String) -> UIImage {
        
        if let url = NSURL(string: image) {
            let imageData = NSData(contentsOf: url as URL)
            if imageData != nil {
                if imageData?.length != 0 {
                    let str64 = imageData?.base64EncodedData(options: .lineLength64Characters)
                    let data: NSData = NSData(base64Encoded: str64!, options: .ignoreUnknownCharacters)!
                    dataImage = UIImage(data: data as Data)!
                    return dataImage
                }
            }else {
                dataImage = UIImage(named: "Xcode.jpg")
                return dataImage
            }
        }
        return dataImage

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    //Tableview delegate method.
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? TableViewCell else {
            return
        }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        
        switch indexPath.row {
        case 0:
            tableViewCell.newsCollectionViewOffset = storedOffsets[indexPath.row] ?? 0
            break
        case 1:
            tableViewCell.sportsCollectionViewOffset = storedOffsets[indexPath.row] ?? 0
            break
        case 2:
            tableViewCell.moviesCollectionViewOffset = storedOffsets[indexPath.row] ?? 0
            break
        default:
            break
            
        }
    }

}

//UICollectionView delegate mehtod.
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.restorationIdentifier == "news" {
            return array_News.count
        }
        else if collectionView.restorationIdentifier == "sports" {
            return array_Sports.count
        }else {
            return array_Movies.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.restorationIdentifier == "news" {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsViewCell
            
            collectionView.tag = 0
            cell.newsImages.contentMode = .scaleAspectFit
            cell.newsImages.contentMode = .scaleToFill
            cell.newsLabels.text = array_News[indexPath.row].json_title
            let tempImages = self.ConvertImages(image: array_News[indexPath.row].json_imageUrl)
            cell.newsImages.image = tempImages
            return cell
        }
        else if collectionView.restorationIdentifier == "sports" {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportsCell", for: indexPath) as! SportsViewCell
            
            collectionView.tag = 1
            cell.sportsImages.contentMode = .scaleAspectFit
            cell.sportsImages.contentMode = .scaleToFill
            cell.sportsLabels.text = array_Sports[indexPath.row].json_title
            let tempImages = self.ConvertImages(image: array_Sports[indexPath.row].json_imageUrl)
            cell.sportsImages.image = tempImages
            return cell
        }
        else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCell", for: indexPath) as! MoviesViewCell
            
            collectionView.tag = 2
            cell.moviesImages.contentMode = .scaleAspectFit
            cell.moviesImages.contentMode = .scaleToFill
            
            cell.moviesLabels.text = array_Movies[indexPath.row].json_title
            let tempImages = self.ConvertImages(image: array_Movies[indexPath.row].json_imageUrl)
            cell.moviesImages.image = tempImages
            return cell
            
        }
        
    }
    
    private func hideMenu() {
        UIView .animate(withDuration: 0.3, animations: { () -> Void in
            //self.tableViewHeightConstraint.constant = 0
            self.tableView.layoutIfNeeded()
        });
    }
    
    private func showMenu() {
        UIView .animate(withDuration: 0.3, animations: { () -> Void in
            _ = self.tableView.rowHeight * CGFloat(self.tableView.numberOfRows(inSection: 0))
            //self.tableViewHeightConstraint.constant = totalHeight
            self.tableView.layoutIfNeeded()
        });
    }

}


