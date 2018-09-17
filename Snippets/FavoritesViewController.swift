//
//  FavoritesViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 7/16/18.
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

var favoriteids = [String]()
var favorites = [String:String]()
var thumbnail = [String:UIImage]()

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    func hideloading() {
        
        loadinglabel.alpha = 0
        activityIndicator.stopAnimating()
        activityIndicator.alpha = 0
        
    }
    
    func showloading() {
        
        loadinglabel.alpha = 1
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        ref = Database.database().reference()


        hideloading()
        tableView.reloadData()
        
        if favorites.count == 0 {
            
            favorites.removeAll()
            favoriteids.removeAll()
            
            queryforfavoriteids { () -> () in
                
                self.queryfordata()
            }
            
        } else {
            
            
        }
        
        backgroundlabel.layer.cornerRadius = 5.0
        backgroundlabel.clipsToBounds = true
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tapsettings: UIButton!
    func queryforfavoriteids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        
        ref?.child("Users").child(uid).child("Favorites").queryLimited(toFirst: 10).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    self.showloading()

                    
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
            
            if var productimagee = value?["Image"] as? String {
                                
                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                    
                    let url = URL(string: productimagee)
                    
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    
                    if data != nil {
                        
                        let productphoto = UIImage(data: (data)!)
                        
                        //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                        let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                        
                        thumbnail[each] = productphoto
                        
                        functioncounter += 1
                        
                        
                    }
                    
                    
                }
            }
            
            if functioncounter == favoriteids.count {
                
                self.tableView.reloadData()
            }
            
            })
            
            

        }
    }
    @IBOutlet weak var backgroundlabel: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if favorites.count > 0 {
            
            return favorites.count

        } else {
            
            return 1
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Favorites", for: indexPath) as! FavoritesTableViewCell
        
        if favorites.count > indexPath.row {
            
            hideloading()

            cell.imagecover.alpha = 1
            
            cell.favoritelabel.text = favorites[favoriteids[indexPath.row]]
            cell.imagecover.image = thumbnail[favoriteids[indexPath.row]]
            cell.imagecover.layer.cornerRadius = 5.0
            cell.imagecover.layer.masksToBounds = true
            
        } else {
            
            cell.favoritelabel.text = "You have no favorites"
            cell.imagecover.alpha = 0
        }
                
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedtext = favorites[favoriteids[indexPath.row]]!
        
        self.performSegue(withIdentifier: "FavoritesToFullText", sender: self)
    }
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
        ref?.child("Users").child(uid).child("Favorites").child(favoriteids[indexPath.row]).removeValue()

            favorites.removeValue(forKey: favoriteids[indexPath.row])
            thumbnail.removeValue(forKey: favoriteids[indexPath.row])
            favoriteids.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .fade)
        
            self.tableView.reloadData()
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadinglabel: UILabel!
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            
            takeScreenshot(true)
            showalert()
            
        }
    }
    
    
    func showalert() {
        
        let alert = UIAlertController(title: "Shake To Report", message: "Please report any issues you found!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Send Feedback", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Feedback") as! FeedbackViewController
                self.present(vc, animated: true, completion: nil)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    open func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = screenshotImage, shouldSave {
            
            screenshot = image
            
        }
        return screenshotImage
    }

}
