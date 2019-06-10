//
//  FavViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 9/10/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit
import UserNotifications
import AudioToolbox
import GameplayKit

class FavViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        view.bringSubview(toFront: emptylabel)
        FBSDKAppEvents.logEvent("Favorites Viewed")
        
        tableView.reloadData()
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            tableView.reloadData()
            
        } else {
            
            
                queryforfavoriteids { () -> () in
                    
                    self.queryfordata()
                }
            
            refreshControl.attributedTitle = NSAttributedString(string: "")
            refreshControl.addTarget(self, action: #selector(FavViewController.refresh), for: UIControlEvents.valueChanged)
            refreshControl.tintColor  = mygreen
            tableView.addSubview(refreshControl)
                
        }
        

        // Do any additional setup after loading the view.
    }
    
    @objc func refresh() {
        // Code to refresh table view
        
        favorites.removeAll()
        thumbnail.removeAll()
        
        queryforfavoriteids { () -> () in
            
            self.queryfordata()
        }
    }

    var refreshControl = UIRefreshControl()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func queryforfavoriteids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        
        favoriteids.removeAll()
         ref?.child("Snippets").child("Users").child(uid).child("Favorites").queryLimited(toFirst: 25).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    favoriteids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
        
        
    }
    
    func queryfordata() {
        
        var functioncounter = 0
        
        favorites.removeAll()
        thumbnail.removeAll()
        
        for each in favoriteids {
            
            ref?.child("Snippets").child("Users").child(uid).child("Favorites").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
                if var activityvalue = value?["Text"] as? String {
                    
                    favorites[each] = activityvalue
                    
                }
                
                
                if var activityvalue3 = value?["Image"] as? String {
                    
                    thumbnail[each] = UIImage(named: "\(activityvalue3)")
                    
                    functioncounter += 1
                    
                }
                
                if functioncounter == favoriteids.count {
                    
                    self.tableView.reloadData()
                }
                
            })
            
            
            
        }
    }
    
    @IBOutlet weak var tapsettings: UIButton!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        if favorites.count > 0 {
            
            selectedtext = favorites[favoriteids[indexPath.row]]!
            self.performSegue(withIdentifier: "QuoteToExpanded", sender: self)
            
        } else {
            
           
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if thumbnail.count > 0 {
            
            emptylabel.alpha = 0
            return thumbnail.count
            
        } else {
            
            emptylabel.alpha = 1
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Fav", for: indexPath) as! FavTableViewCell
        
        cell.coverimage.layer.cornerRadius = 10.0
        cell.coverimage.layer.masksToBounds = true
        cell.selectionStyle = .none
        
        if thumbnail.count > indexPath.row && favorites.count > indexPath.row {
            
            refreshControl.endRefreshing()

            cell.descriptionlabel.text = favorites[favoriteids[indexPath.row]]
            cell.coverimage.image = thumbnail[favoriteids[indexPath.row]]

            
        } else {
            
          
            
        }
        
        

        return cell
    }
 
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            ref?.child("Snippets").child("Users").child(uid).child("Favorites").child(favoriteids[indexPath.row]).removeValue()
            
            favorites.removeValue(forKey: favoriteids[indexPath.row])
            thumbnail.removeValue(forKey: favoriteids[indexPath.row])
            
            favoriteids.remove(at: indexPath.row)
                        
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            self.tableView.reloadData()
        }
        
    }
    

    @IBOutlet weak var emptylabel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
