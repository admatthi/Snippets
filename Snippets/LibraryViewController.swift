//
//  LibraryViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 7/18/18.
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

var librarycovers = [String:UIImage]()
var librarytitles = [String:String]()
var libraryauthors = [String:String]()
var librarybookids = [String]()

class LibraryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

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
    
    @IBOutlet weak var coverimage: UIImageView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        nobooks.alpha = 0

        ref = Database.database().reference()

        queryforbookids { () -> () in
            
            self.queryforbookinfo()
            
        }
        
        showloading()
        
        backgroundlabel.layer.cornerRadius = 5.0
        backgroundlabel.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func queryforbookids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        librarybookids.removeAll()
        librarycovers.removeAll()
        libraryauthors.removeAll()
        librarytitles.removeAll()
        
        ref?.child("Users").child(uid).child("Library").queryLimited(toFirst: 10).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    librarybookids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
        
        
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loadinglabel: UILabel!
    func queryforbookinfo() {
        
        var functioncounter = 0
        
        librarybookids = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: librarybookids) as! [String]
        
        for each in librarybookids  {
            
            ref?.child("AllBooks1").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
                if var activityvalue = value?["Name"] as? String {
                    
                    librarytitles[each] = activityvalue
                    
                }
                
                if var activityvalue = value?["Author"] as? String {
                    
                    libraryauthors[each] = activityvalue
                    
                }
                
                
                if var productimagee = value?["Image"] as? String {
                    
                    if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                        
                        let url = URL(string: productimagee)
                        
                        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                        
                        if data != nil {
                            
                            let productphoto = UIImage(data: (data)!)
                            
                            //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                            let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                            
                            librarycovers[each] = productphoto
                            
                            functioncounter += 1
                            
                            
                        }
                        
                        
                    }
                }
                
                if functioncounter == librarybookids.count  {
                    
                    self.showloading()
                    self.collectionView.reloadData()
                }
                
            })
            
        }
        
    }
    @IBOutlet weak var nobooks: UILabel!
    @IBOutlet weak var backgroundlabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        if librarytitles.count > 0 {
            
            nobooks.alpha = 0
            return librarytitles.count

        } else {
            
            nobooks.alpha = 1

            hideloading()
            
            return 0
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Books", for: indexPath) as! BooksCollectionViewCell
        cell.bookcover.layer.cornerRadius = 10.0
        cell.bookcover.layer.masksToBounds = true
        
        cell.dark.layer.cornerRadius = 10.0
        cell.dark.layer.masksToBounds = true
        
        cell.bookcover.image = librarycovers[librarybookids[indexPath.row]]
        cell.bookauthor.text = libraryauthors[librarybookids[indexPath.row]]
        cell.booktitle.text = librarytitles[librarybookids[indexPath.row]]
        
        hideloading()
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedbookid = librarybookids[indexPath.row]
        selectedtitle = librarytitles[librarybookids[indexPath.row]]!
        selectedauthor = libraryauthors[librarybookids[indexPath.row]]!
        selectedimage = librarycovers[librarybookids[indexPath.row]]!
        
        self.performSegue(withIdentifier: "LibraryToReader", sender: self)
        
    }
    
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
