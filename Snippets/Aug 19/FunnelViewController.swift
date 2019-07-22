//
//  FunnelViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 10/30/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit
import Purchases

var demoimages = [String]()
var ideas = [String]()

class FunnelViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        loaddictionary()
        
        // Do any additional setup after loading the view.
    }
    
    func loaddictionary() {
        
        demoimages.append("B1")
        demoimages.append("B2")
        demoimages.append("B3")
        demoimages.append("B4")
        demoimages.append("B5")
        demoimages.append("B6")
        demoimages.append("B7")
        demoimages.append("B8")
        demoimages.append("B9")
        
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return demoimages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Books", for: indexPath) as! BooksCollectionViewCell
            cell.bookcover.layer.cornerRadius = 2.0
            cell.bookcover.layer.masksToBounds = true
            cell.lockimage.alpha = 0
            cell.views.alpha =  1
            
            cell.dark.alpha = 1
            cell.views.text = ideas[indexPath.row]
        
            cell.bookcover.image = UIImage(named: "\(demoimages[indexPath.row])")
        
            return cell
//            cell.views.text = nineviews[indexPath.row]
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
}
