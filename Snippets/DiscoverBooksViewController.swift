//
//  DiscoverBooksViewController.swift
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
import GameplayKit

var bookids = [String]()
var booknames = [String:String]()
var bookauthors = [String:String]()
var bookcovers = [String:UIImage]()
var bookdescriptions = [String:String]()
var bookurls = [String:String]()
var bookcompleted = [String:String]()

var foryoubookids = [String]()
var foryoubooknames = [String:String]()
var foryoubookauthors = [String:String]()
var foryoubookcovers = [String:UIImage]()
var foryoudescriptions = [String:String]()
var foryouurls = [String:String]()


var purchased = Bool()

var selectedauthor = String()
var selectedimage = UIImage()
var selecteddescription = String()
var selectedurl = String()

var selectedfilter = String()

var completedbooks = [String]()

class DiscoverBooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var loadinglabeltext: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionView4: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    @IBOutlet weak var authorofquote: UILabel!
    func hideloading() {
        
//        coverimage.alpha = 0
        loadinglabeltext.alpha = 0
//        logo.alpha = 0
        activityIndicator.stopAnimating()
        activityIndicator.alpha = 0
//        tapfavorties.alpha = 1
//        taphome.alpha = 1
//        taplibrary.alpha = 1
//        tapfilters.alpha = 1
        tapcta.alpha = 0
    }
    
    @IBOutlet weak var coverimage: UIImageView!
    @IBOutlet weak var loadinglabel: UILabel!
    func showloading() {
        
//        coverimage.alpha = 1
        logo.alpha = 1
        loadinglabeltext.alpha = 1
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
//        tapfavorties.alpha = 0
//        taphome.alpha = 0
//        taplibrary.alpha = 0
        tapcta.alpha = 0
    }
    
    @IBOutlet weak var tapcta: UIButton!
    @IBOutlet weak var categorylabel: UILabel!
    @IBOutlet weak var taphome: UIButton!
    @IBOutlet weak var tapfavorties: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        self.becomeFirstResponder() // To get shake gesture
        
        FBSDKAppEvents.logEvent("Discover Viewed")

        tryingtopurchase = false
        // Do any additional setup after loading the view.
        
        showloading()
        
        backgroundlabel.layer.cornerRadius = 5.0
        backgroundlabel.clipsToBounds = true
        
        if selectedfilter == "" {
            
            selectedfilter = "Business & Money"
            
            categorylabel.text = selectedfilter.uppercased()
            
        } else {
            
            categorylabel.text = selectedfilter.uppercased()
            
        }
        

        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in

            var text = "Most Popular"
            
            categorylabel.text = text.uppercased()

            queryforallbookids { () -> () in
                
                self.queryforbookinfo()
            }

            
            purchased = false
        
            collectionView2.reloadData()
            tapsettings.alpha = 0
            tapfavorties.alpha = 0
            taphome.alpha = 0
            taplibrary.alpha = 0
            tapfilters.alpha = 0
//            tapcta.alpha = 1
            
        } else {
            
            queryforbookids { () -> () in
                
                self.queryforbookinfo()
                
            }
            
            uid = (Auth.auth().currentUser?.uid)!

            newuser = false
            // Do any additional setup after loading the view.
            purchased = true
            tapsettings.alpha = 1
            tapfavorties.alpha = 1
            taphome.alpha = 1
            taplibrary.alpha = 1
            tapfilters.alpha = 1
            tapcta.alpha = 0
            collectionView2.reloadData()
            queryforcompletedbookids()
//            let date = Date()
//            let calendar = Calendar.current
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MM-dd-yy"
//            todaysdate =  dateFormatter.string(from: date)
            
            
            
        }
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var taplibrary: UIButton!
    @IBOutlet weak var backgroundlabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tapsettings: UIButton!
    func queryforbookids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        bookids.removeAll()
        bookcovers.removeAll()
        bookauthors.removeAll()
        booknames.removeAll()
        bookdescriptions.removeAll()
        bookurls.removeAll()
     
        
        ref?.child("AllBooks").queryOrdered(byChild: "Genre").queryEqual(toValue: selectedfilter).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    bookids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
        
        
    }
    
    func queryforallbookids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        bookids.removeAll()
        bookcovers.removeAll()
        bookauthors.removeAll()
        booknames.removeAll()
        bookdescriptions.removeAll()
        bookurls.removeAll()
        
        
        ref?.child("AllBooks").queryLimited(toFirst: 50).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    bookids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
        
        
    }
    
    func queryforcompletedbookids() {
        
        var functioncounter = 0
        
        completedbooks.removeAll()
      
        ref?.child("Users").child(uid).child("Completed").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    completedbooks.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        for each in completedbooks {
                            
                            if bookids.contains(each) {
                                
                                bookcompleted[each] = "True"
                                
                                self.collectionView2.reloadData()
                                
                            }
                        }
                        
                    }
                    
                    
                }
                
            }
            
        })
        
        
    }
    
    @IBOutlet weak var tapfilters: UIButton!
    func queryforbookinfo() {
            
            var functioncounter = 0
            
            bookids = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: bookids) as! [String]

            for each in bookids  {
                
                bookcompleted[each] = "False"

                ref?.child("AllBooks").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    var value = snapshot.value as? NSDictionary
                    

                    if var activityvalue = value?["Author"] as? String {
                                
                    bookauthors[each] = activityvalue
                    
                    }
                            
                    if var activityvalue2 = value?["Name"] as? String {
                        
                        booknames[each] = activityvalue2
                    }
                    
                    if var activityvalue2 = value?["Description"] as? String {
                        
                        bookdescriptions[each] = activityvalue2
                        
                    } else {
                        
                        bookdescriptions[each] = "Dummy"

                        bookcompleted[each] = "Dummy"
                        
                    }
                            
                    if var productimagee = value?["Image"] as? String {
                                
                                bookurls[each] = productimagee
                                
                                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                                    
                                    let url = URL(string: productimagee)
                                    
                                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                    
                                    if data != nil {
                                        
                                        let productphoto = UIImage(data: (data)!)
                                        
                                        //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                                        let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                                        
                                        bookcovers[each] = productphoto
                                        
                                        functioncounter += 1
                                        
                                        
                                    }
                                    
                                }
                                
                        }

                    
                    if functioncounter == bookids.count {

                        self.collectionView2.reloadData()
//                        self.collectionView.reloadData()
                        
                    }
                })
                
            }
            
    }
    

  
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
            if collectionView.tag == 2 {
                
                if booknames.count > 0 {
                    
                    return booknames.count
                    
                } else {
                    
                    return 1
                }
                
            } else {
              
                return 1
                
                }
            }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Books", for: indexPath) as! BooksCollectionViewCell
        cell.bookcover.layer.cornerRadius = 10.0
        cell.bookcover.layer.masksToBounds = true
        
        cell.dark.layer.cornerRadius = 10.0
        cell.dark.layer.masksToBounds = true
        
        if purchased {
            
            cell.lockimage.image = UIImage(named: "PurpleOval")
            
        } else {
            
            cell.lockimage.image = UIImage(named: "Lock")
        }
        if bookauthors.count > indexPath.row {
                
                cell.bookauthor.text = bookauthors[bookids[indexPath.row]]
                cell.bookcover.image = bookcovers[bookids[indexPath.row]]
                cell.booktitle.text = booknames[bookids[indexPath.row]]
            
                hideloading()
            
            if bookcompleted[bookids[indexPath.row]] == "True" {
                
                cell.lockimage.alpha = 0

            } else {
                
                cell.lockimage.alpha = 1

            }
            
            if purchased {
                
//                tapcta.alpha = 0

            } else {
                
                cell.lockimage.alpha = 1
                cell.lockimage.image = UIImage(named: "PurpleOval")
//                tapcta.alpha = 1

            }
                
            }
        
        if indexPath.row == bookauthors.count - 5 {
            
            
        }
        
        return cell
    }
    
    @IBOutlet weak var whitelabel: UILabel!
    
    @IBOutlet weak var collectionView2: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        if purchased {
            
            selectedbookid = bookids[indexPath.row]
            selectedtitle = booknames[bookids[indexPath.row]]!
            selectedauthor = bookauthors[bookids[indexPath.row]]!
            selectedimage = bookcovers[bookids[indexPath.row]]!
            selecteddescription = bookdescriptions[bookids[indexPath.row]]!
            selectedurl = bookurls[bookids[indexPath.row]]!
            
            
            if bookcompleted[bookids[indexPath.row]] == "Dummy" {
                
                
            } else {
                
                self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)

            }
            
        } else {
            
            selectedbookid = bookids[indexPath.row]
            selectedtitle = booknames[bookids[indexPath.row]]!
            selectedauthor = bookauthors[bookids[indexPath.row]]!
            selectedimage = bookcovers[bookids[indexPath.row]]!
            selecteddescription = bookdescriptions[bookids[indexPath.row]]!
            selectedurl = bookurls[bookids[indexPath.row]]!
            
            
            if bookcompleted[bookids[indexPath.row]] == "Dummy" {
                
                
            } else {
                
                self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                
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

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}


