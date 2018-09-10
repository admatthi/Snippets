//
//  ReaderViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 7/10/18.
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

var quote = [String]()
var selectedtitle = String()
var thischaptertitle = String()
var selectedbookid = String()

let gred = UIColor(red:0.95, green:0.09, blue:0.35, alpha:1.0)

let bblue = UIColor(red:0.01, green:0.61, blue:0.87, alpha:1.0)
let yyellow = UIColor(red:1.00, green:0.73, blue:0.00, alpha:1.0)
let lblue = UIColor(red:0.00, green:0.78, blue:0.83, alpha:1.0)
let oorange = UIColor(red:1.00, green:0.40, blue:0.08, alpha:1.0)


var colors = [UIColor]()

class ReaderViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func tapBuy(_ sender: Any) {
        
        if selectedurl != "" {
            
            FBSDKAppEvents.logEvent("Buy Tapped")

            if let url = NSURL(string: "\(selectedurl)"
                ) {
                UIApplication.shared.openURL(url as URL)
            }
            
        }
    }
    @IBAction func tapPrevious(_ sender: Any) {
        
        quotetext.slideInFromLeft()

        if counter > 0 {
            
            lastcount()

        }
        
//        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
        bookmarktapped = false
    }
    @IBAction func tapNext(_ sender: Any) {
        
        quotetext.slideInFromRight()

        
        nextcount()
        
//        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
        bookmarktapped = false
    }
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference?
    var category = String()
    
    var bookmarktapped = Bool()
    
    func showbookmark() {
        
//        if bookmarktapped {
//
//            tapbookmark.setImage(UIImage(named: "LightBookMark"), for: .normal)
//
//        } else {
//
//            tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
//        }
    }
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    
    var arrayCount = Int()

    @IBOutlet weak var tapbuy: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        
        if freepressed {
            
            tapbuy.alpha = 0
            
            
        } else {
            
           tapbuy.alpha = 1

        }
        
//        whitelabel.layer.cornerRadius = 10.0
//        whitelabel.layer.masksToBounds = true
        
        titlelabel.text = selectedtitle
        authorlabel.text = selectedauthor
        cover.image = selectedimage
        cover.layer.cornerRadius = 5.0
        cover.layer.masksToBounds = true
        
        bookmarktapped = false
        
        FBSDKAppEvents.logEvent("Read Book Viewed")
//        wtf()
        
            whatthehell()

                // Do any additional setup after loading the view.
        
  
        tapanywhere.alpha = 1
    }
    
    @IBOutlet weak var counterbutton: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var quotetext: UILabel!
    
    @IBOutlet weak var backgroundlabel: UILabel!
    

    
    var counter = 0
    
    func lastcount() {
        
        
        if counter == 0 {
            
            
        } else {
            
            counter -= 1
            showproperquote()
            
            let progress = (Float(counter)/Float(arrayCount))
            self.progressView.setProgress(Float(progress), animated:true)
        }
        
        bookmarktapped = true
//        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
    }
    
    var randomstring = String()
    
//    @IBAction func tapBookMark(_ sender: Any) {
//        favorites.removeAll()
//        randomstring = UUID().uuidString
//
//        if counter > 0  {
//
//
//            if bookmarktapped {
//
//                ref?.child("Users").child(uid).child("Favorites").child(randomstring).removeValue()
//
//                tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
//
//                bookmarktapped = false
//
//            } else {
//
//                tapbookmark.setImage(UIImage(named: "LightBookMark"), for: .normal)
//                ref?.child("Users").child(uid).child("Favorites").child(randomstring).updateChildValues(["Text" : quote[counter], "Image" : selectedurl, "Author" : selectedauthor, "Name" : selectedtitle])
//
//                bookmarktapped = true
//
//            }
//
//        } else {
//
//            if bookmarktapped {
//
//                ref?.child("Users").child(uid).child("Favorites").child(randomstring).removeValue()
//
//                tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
//
//                bookmarktapped = false
//
//            } else {
//
//                tapbookmark.setImage(UIImage(named: "LightBookMark"), for: .normal)
//                ref?.child("Users").child(uid).child("Favorites").child(randomstring).updateChildValues(["Text" : quote[counter], "Image" : selectedurl, "Author" : selectedauthor, "Name" : selectedtitle])
//
//                bookmarktapped = true
//
//            }
//
//        }
//
//        }
//
    @IBOutlet weak var tapanywhere: UILabel!
    @IBOutlet weak var tapbookmark: UIButton!
    func nextcount() {
        

        if counter > (quote.count-1) {
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
            if freepressed {
                
                
            } else {
                
        ref?.child("Users").child(uid).child("Completed").child(selectedbookid).updateChildValues(["Text" : "Wow"])

            }
            FBSDKAppEvents.logEvent("Book Completed")

            self.performSegue(withIdentifier: "ReaderToDiscover", sender: self)

            
        } else {

            counter += 1

            showproperquote()
            
            let progress = (Float(counter)/Float(arrayCount))
            self.progressView.setProgress(Float(progress), animated:true)
        }
        
        tapanywhere.alpha = 0

    }
    @IBOutlet weak var whitelabel: UILabel!
    func whatthehell() {
        
        quote.removeAll()
        
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

            
            self.counter = 0

            self.showproperquote()
            
            self.arrayCount = quote.count
        })
        
        
    }
    

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
        
        if counter < quote.count {
            
        quotetext.text = quote[counter]
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

extension UILabel {
    func addCharacterSpacing() {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: 1.2, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
