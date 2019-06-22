//
//  SwipeViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 10/16/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FBSDKCoreKit
import UserNotifications
import AudioToolbox


class SwipeViewController: UIViewController {

    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var tapback: UIButton!
    @IBOutlet weak var tapnext: UIButton!
    @IBOutlet weak var introlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var darkbackground: UIImageView!
    @IBOutlet weak var coverimage: UIImageView!
    @IBOutlet weak var textlabel: UILabel!
    
    
    @IBAction func tapBack(_ sender: Any) {
        
        textlabel.slideInFromLeft()
        
        if counter > 0 {
            
            lastcount()
            
        }
        
        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
        bookmarktapped = false
        
    }
    @IBAction func tapNext(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        
        if quote.count > 0 {
            
            threebuttonuntapped()
            
            textlabel.slideInFromRight()
            
            
            nextcount()
            
        } else {
            
            whatthehell()
            
        }
        
        reading()
        
       
        
        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
        bookmarktapped = false
        
    }
    var ref: DatabaseReference?
    
    var bookmarktapped = Bool()
    var threetapped = Bool()
    @IBOutlet weak var threebutton: UIButton!
    @IBOutlet weak var tapbookmark: UIButton!
    @IBAction func tapBuy(_ sender: Any) {
        
        if selectedurl != "" {
            
            
            if let url = NSURL(string: "\(selectedurl)"
                ) {
                UIApplication.shared.openURL(url as URL)
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
    func showbookmark() {
        
        if bookmarktapped {
            
            tapbookmark.setImage(UIImage(named: "LightBookMark"), for: .normal)
            
        } else {
            
            tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        }
    }

    @IBOutlet weak var tapbuy: UIButton!
    func threebuttontapped() {
        
        tapbookmark.alpha = 1
        tapbuy.alpha = 1
        tapback.alpha = 1
        threebutton.setImage(UIImage(named: "3ButtonsOpen"), for: .normal)
        
        threetapped = true
    }
    
    func threebuttonuntapped() {
        
        tapbookmark.alpha = 0
        tapbuy.alpha = 0
        tapback.alpha = 0
        
        threebutton.setImage(UIImage(named: "3Buttons"), for: .normal)
        
        threetapped = false
    }
    func nextcount() {
        
        
        if counter > quote.count-2 {
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
//            ref?.child("Users").child(uid).child("Library").child("InProgress").child(selectedtitle).removeValue()
            
//            ref?.child("Users").child(uid).child("Library").child("InProgress").child(selectedtitle).updateChildValues(["Name" : selectedtitle, "Author" : selectedauthor, "Image": selectedimagename, "Genre" : selectedgenre, "BookID" : selectedbookid, "Completed" : "Yes", "Description" : selecteddescription, "Views" : selectedviews])
            
//            selectedimage = coverimage.image!
            
//            self.performSegue(withIdentifier: "ReaderToCompleted", sender: self)
            
            
        } else {
            
            counter += 1
            
            showproperquote()
            
            let progress = (Float(counter)/Float(arrayCount))
            self.progress.setProgress(Float(progress), animated:true)
        }
        
        
    }
    
    func whatthehell() {
        
        quote.removeAll()
        
        ref?.child("AllBooks1").child("Biography & Memoir").child(selectedbookid).child("Summary").child("1").observeSingleEvent(of: .value, with: { (snapshot) in
            
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
            
            self.arrayCount = quote.count
        })
        
        
    }
    
    
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
            textlabel.text = trimmedtext.capitalizingFirstLetter()
            
            
            print(counter)
            
            //        textlabel.addCharacterSpacing()
            
            //        backgroundlabel.backgroundColor = colors[counter]
            
            
        }
    }
    var arrayCount = Int()

    func reading() {
        
        views.alpha = 0
        introlabel.alpha = 0
        titlelabel.alpha = 0
        author.alpha = 0
        darkbackground.alpha = 0
        coverimage.image = UIImage(named: "Back4")
        
        textlabel.alpha = 1
        progress.alpha = 1
        tapbuy.alpha = 0
        tapbookmark.alpha = 0
        threebutton.alpha = 1
    }
    
    func observing() {
        
        views.alpha = 1
        introlabel.alpha = 1
        titlelabel.alpha = 1
        author.alpha = 1
        darkbackground.alpha = 1
        coverimage.image = selectedimage
        textlabel.alpha = 0
        progress.alpha = 0
        tapbuy.alpha = 0
        tapbookmark.alpha = 0
        threebutton.alpha = 0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coverimage.layer.cornerRadius = 10.0
        darkbackground.layer.cornerRadius = 10.0
        coverimage.layer.masksToBounds = true
        darkbackground.layer.masksToBounds = true
        
        coverimage.layer.shadowRadius = 10.0
        coverimage.layer.shadowColor = UIColor.black.cgColor

        coverimage.layer.shadowOffset = CGSize(width: -4, height: 4)

        observing()

        threebuttonuntapped()
        
        ref = Database.database().reference()
        
        queryforreviewinfo()
        
        bookmarktapped = false
        
        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    func queryforreviewinfo() {
        
        var functioncounter = 0
        
        ref?.child("AllBooks1").child("Biography & Memoir").child("9").observeSingleEvent(of: .value, with: { (snapshot) in
            
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
            self.coverimage.image = UIImage(named: "B9")
            self.introlabel.text = selecteddescription
            selectedbookid = "9"
            
            //                if let first = selecteddescription.components(separatedBy: ".").first {
            
            //                    self.descriptionlabel.text = "\(first)."
            
            //                }
            
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var counter = 0
    
    func lastcount() {
        
        
        if counter == 0 {
            
            
        } else {
            
            counter -= 1
            showproperquote()
            
            let progress = (Float(counter)/Float(arrayCount))
            self.progress.setProgress(Float(progress), animated:true)
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
                
//                ref?.child("Users").child(uid).child("Favorites").child(randomstring).removeValue()
                
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
                
                
//                ref?.child("Users").child(uid).child("Favorites").child(randomstring).updateChildValues(["Text" : trimmedtext, "Image" : selectedimagename])
                
                bookmarktapped = true
                
            }
            
        } else {
            
            if bookmarktapped {
                
//                ref?.child("Users").child(uid).child("Favorites").child(randomstring).removeValue()
                
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
                
                
//                ref?.child("Users").child(uid).child("Favorites").child(randomstring).updateChildValues(["Text" : trimmedtext, "Image" : selectedimagename])
                
                bookmarktapped = true
                
            }
            
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

}
public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
