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

class ReaderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func tapBack(_ sender: Any) {
        
        selectedtext = trimmedtext
        
        takeScreenshot(true)

        self.performSegue(withIdentifier: "ReaderToThree", sender: self)
//        self.dismiss(animated: true, completion: {
//
//        })
    }
    @IBAction func tapBuy(_ sender: Any) {
        
        if selectedurl != "" {
            
            FBSDKAppEvents.logEvent("Buy Tapped")

            if let url = NSURL(string: "\(selectedurl)"
                ) {
                UIApplication.shared.openURL(url as URL)
            }
            
        }
    }
    @IBAction func tapPrevious(_ sender: AnyObject?) {
        
//        quotetext.slideInFromLeft()

        if counter > 0 {
            
            lastcount()

        }
        
//        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
//        bookmarktapped = false
    }
    @IBAction func tapNext(_ sender: AnyObject?) {
        
//        threebuttonuntapped()
        
//        quotetext.slideInFromRight()

        
        nextcount()
        
//        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
        bookmarktapped = false
    }
    
    @IBAction func goodBye(_ sender: AnyObject?) {
        
      self.dismiss(animated: true, completion: nil)
        
    }
    var ref: DatabaseReference?
    var category = String()
    
    var bookmarktapped = Bool()
    
    func showbookmark() {
        
        if bookmarktapped {

            tapbookmark.setImage(UIImage(named: "LightBookMark"), for: .normal)

        } else {

            tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        }
    }
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    
    var arrayCount = Int()

    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    
    @objc func swipeR() {
        
        

        self.tapPrevious(nil)

    }
    
    @objc func swipeL() {
        

        self.tapNext(nil)

    }
    @IBOutlet weak var tapbuy: UIButton!
    
    var switched = Bool()
    var formerquotes = [String]()
    
    @IBAction func tapSwitch(_ sender: Any) {
        counter = 0

        if switched {
            tapswitch.setImage(UIImage(named: "Summary"), for: .normal)
            topquote.alpha = 1
            quote = formerquotes
            progressView.alpha = 0
            
            showproperquote()
            switched = false
            
            
        } else {
            
            progressView.alpha = 1
            tapswitch.setImage(UIImage(named: "Quotes"), for: .normal)
            
            formerquotes = quote
            quote = explanation
            
            topquote.alpha = 0
            showproperquote()

            switched = true
            
        }
    }
    @IBOutlet weak var topquote: UIImageView!
    @IBOutlet weak var tapswitch: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        explanation.removeAll()
        
        view.bringSubview(toFront: tapanywhere)

        switched = false
        
        ref = Database.database().reference()
        
        favorites.removeAll()
        
        uid = (Auth.auth().currentUser?.uid)!
      
    ref?.child("Snippets").child("Users").child(uid).child("Library").child("InProgress").child(selectedtitle).updateChildValues(["Name" : selectedtitle, "Author" : selectedauthor, "Image": selectedimagename, "Genre" : selectedgenre, "BookID" : selectedbookid, "Completed" : "No", "Description" : selecteddescription, "Views" : selectedviews])
        
        titlelabel.text = selectedtitle
        authorlabel.text = selectedauthor
        cover.image = selectedimage
        cover.layer.cornerRadius = 5.0
        cover.layer.masksToBounds = true
        
        bookmarktapped = false
        

        
        FBSDKAppEvents.logEvent("Read Book Viewed")
//        wtf()
        
        
        whatthehell()
        
//        showbookmark()
        tapanywhere.alpha = 1
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
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
            
            
        }
        
        bookmarktapped = true
        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
    }
    
    var randomstring = String()
    

    @IBAction func tapBookMark(_ sender: Any) {
        favorites.removeAll()
        randomstring = UUID().uuidString

        if counter > 0  {


            if bookmarktapped {

                ref?.child("Users").child(uid).child("Favorites").child(randomstring).removeValue()

                tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)

                bookmarktapped = false

            } else {

                tapbookmark.setImage(UIImage(named: "LightBookMark"), for: .normal)
               
                var trimmedtext = String()
                
                    
                    trimmedtext = quote[counter]
                    
                    trimmedtext = trimmedtext.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
                    
                    trimmedtext = trimmedtext.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
                    
                    trimmedtext = trimmedtext.replacingOccurrences(of: "\'", with: "", options: NSString.CompareOptions.literal, range: nil)
                    
                    trimmedtext = trimmedtext.replacingOccurrences(of: "“", with: "", options: NSString.CompareOptions.literal, range: nil)
                    
                    trimmedtext = trimmedtext.replacingOccurrences(of: "”", with: "", options: NSString.CompareOptions.literal, range: nil)
                    

                    ref?.child("Snippets").child("Users").child(uid).child("Favorites").child(randomstring).updateChildValues(["Text" : trimmedtext, "Image" : selectedimagename])

                bookmarktapped = true

            }

        } else {

            if bookmarktapped {

                ref?.child("Users").child(uid).child("Favorites").child(randomstring).removeValue()

                tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)

                bookmarktapped = false

            } else {

                tapbookmark.setImage(UIImage(named: "LightBookMark"), for: .normal)
               
                var trimmedtext = String()
                
                
                trimmedtext = quote[counter]
                
                trimmedtext = trimmedtext.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
                
                trimmedtext = trimmedtext.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
                
                trimmedtext = trimmedtext.replacingOccurrences(of: "\'", with: "", options: NSString.CompareOptions.literal, range: nil)
                
                trimmedtext = trimmedtext.replacingOccurrences(of: "“", with: "", options: NSString.CompareOptions.literal, range: nil)
                
                trimmedtext = trimmedtext.replacingOccurrences(of: "”", with: "", options: NSString.CompareOptions.literal, range: nil)
                
                
                ref?.child("Snippets").child("Users").child(uid).child("Favorites").child(randomstring).updateChildValues(["Text" : trimmedtext, "Image" : selectedimagename])

                bookmarktapped = true

            }

        }

        }
    @IBAction func tapThree(_ sender: Any) {
        
        if threetapped {
            
            threebuttonuntapped()
            
            threetapped = false

        } else {
            
            threebuttontapped()
            
            threetapped = true
        }
    }
    
    var threetapped = Bool()
    @IBOutlet weak var tapback: UIButton!
    @IBOutlet weak var threebutton: UIButton!
    @IBOutlet weak var tapanywhere: UILabel!
    @IBOutlet weak var tapbookmark: UIButton!
    
    func threebuttontapped() {
        
//        tapbookmark.alpha = 1
        tapbuy.alpha = 1
        tapback.alpha = 1
        threebutton.setImage(UIImage(named: "3ButtonsOpen"), for: .normal)
        
        threetapped = true
    }
    
    func threebuttonuntapped() {
        
        tapbookmark.alpha = 0
        tapbuy.alpha = 0
        tapback.alpha = 0
     
//        threebutton.setImage(UIImage(named: "3Buttons"), for: .normal)
        
        threetapped = false
    }
    func nextcount() {
        

        if counter > quote.count-2 {
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
            if freepressed {
                
                
            } else {
                
        

            }
            
        ref?.child("Users").child(uid).child("Library").child("InProgress").child(selectedtitle).removeValue()

            ref?.child("Snippets").child("Users").child(uid).child("Library").child("InProgress").child(selectedtitle).updateChildValues(["Name" : selectedtitle, "Author" : selectedauthor, "Image": selectedimagename, "Genre" : selectedgenre, "BookID" : selectedbookid, "Completed" : "Yes", "Description" : selecteddescription, "Views" : selectedviews])

            selectedimage = cover.image!
            FBSDKAppEvents.logEvent("Book Completed")

            self.performSegue(withIdentifier: "ReaderToCompleted", sender: self)

            
        } else {

            counter += 1

            showproperquote()
            
           
        }
        
        tapanywhere.alpha = 0

    }
    @IBOutlet weak var whitelabel: UILabel!
    func whatthehell() {
        
        quote.removeAll()
        
        ref?.child("AllBooks1").child(selectedgenre).child(selectedbookid).child("Summary").child("1").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            
            if var activityvalue2 = value?["Explanation1"] as? String {
                
//                self.tapswitch.alpha = 1
//                self.tapswitch.setImage(UIImage(named: "Quotes"), for: .normal)
//
//
//
//                self.topquote.alpha = 0
//
//                self.switched = true
//                self.explanation.append(activityvalue2)
                
            } else {
                
//                self.tapswitch.alpha = 0
            }
            
            if var activityvalue2 = value?["Explanation2"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation3"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation4"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation5"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation6"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation7"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation8"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation9"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation10"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation11"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation12"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation13"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation14"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation15"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation16"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation17"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation18"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation19"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
            if var activityvalue2 = value?["Explanation20"] as? String {
                
//                self.tapswitch.alpha = 1
                self.explanation.append(activityvalue2)
                
            }
            
         
          
            
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

            self.formerquotes = quote

            if self.explanation.count > 0 {
                
                quote = self.explanation
            }

            self.counter = 0
            self.showproperquote()
            
            self.arrayCount = quote.count
        })
        
        
    }
    
    var explanation = [String]()
    
    
     @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                self.tapNext(nil)
            case UISwipeGestureRecognizerDirection.down:
                self.goodBye(nil)
            case UISwipeGestureRecognizerDirection.left:
                self.tapPrevious(nil)
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
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

    @IBAction func tapTwitter(_ sender: Any) {
        
             UIPasteboard.general.string = "\(quote[counter]) #readthesnippets #book #booksarelife #bookcommunity #bookpassion #bookrecommendation #bookreview #nonfiction #love #greatreads #quotes #bookquotes #bookobsessed #alwayslearning"
        
    }
    var trimmedtext = String()

    func showproperquote() {
        
        if counter == 0 {
            
            self.progressView.setProgress(0.0, animated:false)

        } else {
            let progress = (Float(counter)/Float(arrayCount))
            self.progressView.setProgress(Float(progress), animated:true)
        }
        
        if counter < quote.count {
            
        
        trimmedtext = quote[counter]
            
        trimmedtext = trimmedtext.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)

        trimmedtext = trimmedtext.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
            
//        trimmedtext = trimmedtext.replacingOccurrences(of: "\'", with: "", options: NSString.CompareOptions.literal, range: nil)

        trimmedtext = trimmedtext.replacingOccurrences(of: "“", with: "", options: NSString.CompareOptions.literal, range: nil)

        trimmedtext = trimmedtext.replacingOccurrences(of: "”", with: "", options: NSString.CompareOptions.literal, range: nil)

        print(trimmedtext)
//        quotetext.text = trimmedtext.capitalizingFirstLetter()
    
        tableView.reloadData()

        print(counter)
       
//        quotetext.addCharacterSpacing()

//        backgroundlabel.backgroundColor = colors[counter]
        

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if explanation.count > counter {
        
        if explanation[counter] != "" {
            
            return 1

        } else {
            
            return 1
            
            }
            
            
        
        } else {
            
            return 1

        }
        
    }
//
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {


        if trimmedtext.count > 400 {
            
            return UITableViewAutomaticDimension
            
        } else {
            
            return 625

        }

        } else {
            
            return UITableViewAutomaticDimension

            
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reader", for: indexPath) as! ReaderTableViewCell
        

        cell.maintext.text = trimmedtext.capitalizingFirstLetter()
        cell.selectionStyle = .none
        cell.center = self.view.center
        cell.tapright.addTarget(self, action: #selector(ReaderViewController.tapNext(_:)), for: UIControlEvents.touchUpInside)
        cell.tapleft.addTarget(self, action: #selector(ReaderViewController.tapPrevious(_:)), for: UIControlEvents.touchUpInside)
        
        if indexPath.row == 0 {
            
            if explanation.count > counter {
                
                cell.arrow.alpha = 0

            } else {
                
                
                cell.arrow.alpha = 0

            }
            
        } else {
            
            if explanation.count > 0 {
            
                
                cell.maintext.font = UIFont(name:"Avenir-Next", size: 11.0)


                cell.maintext.text = explanation[counter]
                
            } else {
                
                
            }
            
            tapanywhere.alpha = 0
            cell.arrow.alpha = 0
            
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

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
