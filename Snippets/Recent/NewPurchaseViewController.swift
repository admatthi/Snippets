//
//  NewPurchaseViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 10/29/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import UserNotifications
import StoreKit
import FBSDKCoreKit
import UserNotifications
import Purchases

class NewPurchaseViewController: UIViewController {
    
    var attrs = [
        NSAttributedStringKey.foregroundColor : UIColor.black,
        NSAttributedStringKey.underlineStyle : 1] as [NSAttributedStringKey : Any]
    
    var attrs2 = [NSAttributedStringKey.font : UIFont(name: "AvenirNext-Bold", size: 17.0),
                  NSAttributedStringKey.foregroundColor : UIColor.black] as [NSAttributedStringKey : Any]
    
    var attributedString = NSMutableAttributedString(string:"")
    var attributedString2 = NSMutableAttributedString(string:"")

    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            
        })
    }
    
    var purchases = RCPurchases(apiKey: "RDlbQdhQOSZKZUtWvzWnfocZNPLbDFfw")

    @IBAction func tapLogin(_ sender: Any) {
    }
    @IBAction func tapBuy(_ sender: Any) {
        
        FBSDKAppEvents.logEvent("Yearly Pressed")
        
        //        purchase(purchase: threedaytrial)
        
        //        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        purchases.entitlements { entitlements in
            guard let pro = entitlements?["Subscriptions"] else { return }
            guard let monthly = pro.offerings["Weekly"] else { return }
            guard let product = monthly.activeProduct else { return }
            self.purchases.makePurchase(product)
            
            
        }
    }

 
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference?
    var category = String()
    
    var bookmarktapped = Bool()
    
  
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    
    @IBAction func tapTerms(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.mysnippetsapp.weebly.com/privacy-policy.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    
    @IBOutlet weak var tapterms: UIButton!
    @IBOutlet weak var tapbuy: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        tapterms.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left

        let buttonTitleStr = NSMutableAttributedString(string:"By continuing, you accept our Terms of Use & Privacy Policy", attributes:attrs)
        attributedString.append(buttonTitleStr)
        tapterms.setAttributedTitle(attributedString, for: .normal)
        tapterms.setTitleColor(.black, for: .normal)
        
  
        tapterms.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center

        //        whitelabel.layer.cornerRadius = 10.0
        //        whitelabel.layer.masksToBounds = true
        
        titlelabel.text = selectedtitle
        authorlabel.text = selectedauthor
        cover.image = selectedimage
        cover.layer.cornerRadius = 5.0
        cover.layer.masksToBounds = true
        

        whatthehell()

    }
    
    @IBOutlet weak var counterbutton: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var quotetext: UILabel!
    
    @IBOutlet weak var backgroundlabel: UILabel!
    
    
    
    var counter = 0
 
    
    var randomstring = String()
    
    var threetapped = Bool()


    func whatthehell() {
        
        quote.removeAll()
        
        if selectedgenre != "" && selectedbookid != "" {
        ref?.child("AllBooks1").child(selectedgenre).child(selectedbookid).child("Summary").child("1").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            
            
            if var activityvalue2 = value?["1"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["2"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["3"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["4"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["5"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["6"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["7"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["8"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["9"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["10"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["11"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["12"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["13"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["14"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["15"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["16"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["17"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["18"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["19"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["20"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["21"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["22"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["23"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["24"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["25"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["26"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["26"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["27"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["28"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["29"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["30"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["31"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["32"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["33"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["34"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["35"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["36"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["37"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["38"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["39"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["40"] as? String {
                
                quote.append(activityvalue2)
            }
            
            
            
            self.showproperquote()
            
        })
        
        } else {
            
            titlelabel.text = "The Millionaire Fastlane"
            authorlabel.text = "MJ DeMarco"
            cover.image = UIImage(named: "B18")
            quotetext.text = "Extraordinary wealth will require extraordinary beliefs. Scale creates millionaires. Magnitude creates millionaires. Scale and magnitude creates billionaires. "
        }
    }
    
    
    
   
    
    //    func handleSwipe(sender: UISwipeGestureRecognizer) {
    //        print(sender.direction)
    //    }
    //
    //    func addSwipe() {
    //        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left, .up, .down]
    //        for direction in directions {
    //            let gesture = UISwipeGestureRecognizer(target: self, action: Selector(self.handleSwipe(<#T##UISwipeGestureRecognizer#>))))
    //                    var swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(gesture:)))
    //
    //            gesture.direction = direction
    //            self.addGestureRecognizer(gesture)
    //        }
    //    }
    
    
    
    @IBOutlet weak var two: UIImageView!
    @IBOutlet weak var one: UIImageView!
    @IBOutlet weak var three: UIImageView!
    @IBOutlet weak var four: UIImageView!
    @IBOutlet weak var five: UIImageView!
    @IBOutlet weak var six: UIImageView!
    @IBOutlet weak var seven: UIImageView!
    @IBOutlet weak var eight: UIImageView!
    @IBOutlet weak var nine: UIImageView!
    @IBOutlet weak var ten: UIImageView!
    @IBOutlet weak var eleven: UIImageView!
    @IBOutlet weak var twelve: UIImageView!
    @IBOutlet weak var thirteen: UIImageView!
    @IBOutlet weak var fourteen: UIImageView!
    @IBOutlet weak var fifteen: UIImageView!
    
    
    func showproperquote() {
        
        var trimmedtext = String()
        
        if counter < quote.count {
            
            
            trimmedtext = quote[counter]
            
            trimmedtext = trimmedtext.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            trimmedtext = trimmedtext.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            //        trimmedtext = trimmedtext.replacingOccurrences(of: "\'", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            trimmedtext = trimmedtext.replacingOccurrences(of: "“", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            trimmedtext = trimmedtext.replacingOccurrences(of: "”", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            print(trimmedtext)
            quotetext.text = trimmedtext.capitalizingFirstLetter()
            
            
            print(counter)
            
            //        quotetext.addCharacterSpacing()
            
            //        backgroundlabel.backgroundColor = colors[counter]
            
            
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

