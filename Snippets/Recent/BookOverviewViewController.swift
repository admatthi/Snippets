//
//  BookOverviewViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 7/12/18.
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

var selectedviews = String()
var dailypick = Bool()

class BookOverviewViewController: UIViewController {

    @IBOutlet weak var keyinsights: UILabel!

    
    @IBAction func tapStartReading(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        if dailypick {
            
            self.performSegue(withIdentifier: "BookOverviewToRead", sender: self)

            
        } else {
            
        if didpurchase  {
            
            self.performSegue(withIdentifier: "BookOverviewToRead", sender: self)

            
        } else {
            

            self.performSegue(withIdentifier: "BookOverviewToRead", sender: self)

            
        }
    
        }
    }
    
    @IBAction func tapcopy(_ sender: Any) {
        
        UIPasteboard.general.string = "One of the best Snippets from \(selectedauthor)'s \(selectedtitle). Tag a friend who needs to hear this! #readthesnippets #book #booksarelife #bookcommunity #bookpassion #bookrecommendation #bookreview #nonfiction #love #greatreads #quotes #bookquotes #bookobsessed #alwayslearning"

    }
    @IBOutlet weak var taplib: UIButton!
    @IBAction func tapLibrary(_ sender: Any) {
        
        if didpurchase {
            
        taplib.setImage(UIImage(named: "Plus Copy"), for: .normal)

        
        if selectedimagename != "" {
            ref?.child("Snippets").child("Users").child(uid).child("Library").child("InProgress").child(selectedtitle).updateChildValues(["Name" : selectedtitle, "Author" : selectedauthor, "Image": selectedimagename, "Genre" : selectedgenre, "BookID" : selectedbookid, "Completed" : "No", "Description" : selecteddescription, "Views" : selectedviews, "AmazonURL" : selectedurl])
            
        } else {
            
            ref?.child("Snippets").child("Users").child(uid).child("Library").child("InProgress").child(selectedtitle).updateChildValues(["Name" : selectedtitle, "Author" : selectedauthor, "Image": "StockPhoto", "Genre" : selectedgenre, "BookID" : selectedbookid, "Completed" : "No", "Description" : selecteddescription, "Views" : selectedviews, "AmazonURL" : selectedurl])
        }
        
            
        } else {

                self.performSegue(withIdentifier: "BookOverviewToPurchase2", sender: self)
            }
    }
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            
        })
    }
    @IBOutlet weak var tapstart: UIButton!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var tapstartreading: UIButton!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var abouttheauthor: UILabel!
    @IBOutlet weak var reviewer3: UILabel!
    @IBOutlet weak var review3: UILabel!
    @IBOutlet weak var reviewer2: UILabel!
    @IBOutlet weak var review2: UILabel!
    @IBOutlet weak var reviewer1: UILabel!
    @IBOutlet weak var review1: UILabel!
    @IBOutlet weak var author: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        titlelabel.text = selectedtitle
        author.text = selectedauthor
        cover.image = selectedimage
        
//        keyinsights.text = selectedviews
                keyinsights.alpha = 0

        queryforreviewinfo()
        
        cover.layer.cornerRadius = 2.0
        cover.layer.masksToBounds = true
        
        FBSDKAppEvents.logEvent("Book Overview Viewed")
        
     
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapTwitter(_ sender: Any) {
        
    }
    
 
    func queryforreviewinfo() {
        
        var functioncounter = 0
        
            ref?.child("AllBooks1").child(selectedgenre).child(selectedbookid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var activityvalue2 = value?["AboutAuthor"] as? String {
                    
//                    self.abouttheauthor.text = activityvalue2
                }
                
                if var activityvalue2 = value?["AmazonURL"] as? String {
                    
                        selectedurl  = activityvalue2
//                    self.keyinsights.text = "\(activityvalue2) views"
                }
                
                var author2 = value?["Author"] as! String
                selectedauthor = author2
                var name = value?["Name"] as! String
                selectedtitle = name
//                var url = value?["Image"] as! String
//                selectedurl = url
                var description = value?["Description"] as! String
                selecteddescription = description
                self.titlelabel.text = selectedtitle
                self.author.text = selectedauthor
                self.cover.image = selectedimage
                
                self.descriptionlabel.text = selecteddescription
                
//                if let first = selecteddescription.components(separatedBy: ".").first {
                
//                    self.descriptionlabel.text = "\(first)."
                    
//                }
                
                
            })
            
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
