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
        
        
        tableView.reloadData()
        
        if favorites.count == 0 {
            
            queryforfavoriteids { () -> () in
                
                self.queryfordata()
            }
            
        } else {
            
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func queryforfavoriteids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        
        favoriteids.removeAll()
        
        ref?.child("Users").child(uid).child("Favorites").queryLimited(toFirst: 25).observeSingleEvent(of: .value, with: { (snapshot) in
            
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
            ref?.child("Users").child(uid).child("Favorites").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if thumbnail.count > 0 {
            
            return thumbnail.count
            
        } else {
            
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Fav", for: indexPath) as! FavTableViewCell
        
        cell.coverimage.layer.cornerRadius = 10.0
        cell.coverimage.layer.masksToBounds = true
        
        if favorites.count > 0 {
            
            cell.descriptionlabel.text = favorites[favoriteids[indexPath.row]]
            cell.coverimage.image = thumbnail[favoriteids[indexPath.row]]
            cell.greenlabel.alpha = 1
            
        } else {
            
            cell.descriptionlabel.text = "You don't have any favorites yet"
            cell.coverimage.image = nil
            cell.greenlabel.alpha = 0
            
        }
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
