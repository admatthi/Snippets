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
var freepressed = Bool()


var purchased = Bool()

var selectedauthor = String()
var selectedimage = UIImage()
var selecteddescription = String()
var selectedurl = String()

var selectedfilter = String()

var completedbooks = [String]()
var bookinsights = [String:String]()

var onebooknames = [String:String]()
var onebookauthors = [String:String]()
var onebookcovers = [UIImage]()
var onebookdescriptions = [String:String]()
var onebookurls = [String:String]()
var onebookcompleted = [String:String]()
var onebookinsights = [String:String]()

var testerselected = Bool()


class DiscoverBooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var loadinglabeltext: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var authorofquote: UILabel!
    @IBOutlet weak var loadingimage: UIImageView!
    func hideloading() {
        coverimage.alpha = 0
//        logo.alpha = 0
        activityIndicator.stopAnimating()
        activityIndicator.alpha = 0
        loadingback.alpha = 0
//        tapfavorties.alpha = 1
//        taphome.alpha = 1
//        taplibrary.alpha = 1
//        tapfilters.alpha = 1
    }
    
    @IBOutlet weak var loadingback: UILabel!
    @IBOutlet weak var coverimage: UIImageView!
    @IBOutlet weak var loadinglabel: UILabel!
    func showloading() {
        
        coverimage.alpha = 1
        logo.alpha = 1
        loadingback.alpha = 1
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        
//        tapfavorties.alpha = 0
//        taphome.alpha = 0
//        taplibrary.alpha = 0
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
        
        freebackground.layer.cornerRadius = 5.0
        FBSDKAppEvents.logEvent("Discover Viewed")
        activityIndicator.color = .white
        
        tryingtopurchase = false
        // Do any additional setup after loading the view.
        
        showloading()
        hideloading()
        
        backgroundlabel.layer.cornerRadius = 5.0
        backgroundlabel.clipsToBounds = true
        
        freebackground.layer.cornerRadius = 5.0
        freebackground.clipsToBounds = true
        if bookids.count > 0 {
            
            
        } else {
            
            removeids()
            loadids()
        }

        self.freebookimage = UIImage(named: "pp copy")!

        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in

            var text = "Most Popular"
            
            categorylabel.text = text.uppercased()

            purchased = false
        
            tapfavorties.alpha = 0
            taphome.alpha = 0
            taplibrary.alpha = 0
            tapfilters.alpha = 0
//            tapcta.alpha = 1
            
            freepressed = false
//            queryforfreebook()
            
        } else {
            

            
            uid = (Auth.auth().currentUser?.uid)!

            newuser = false
            // Do any additional setup after loading the view.
            purchased = true
            tapfavorties.alpha = 1
            taphome.alpha = 1
            taplibrary.alpha = 1
            tapfilters.alpha = 0
            
            freepressed = false
//            queryforfreebook()

            
//            tapfilters.alpha = 1
//            queryforcompletedbookids()
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
                                
//                                self.collectionView1.reloadData()
                                
                            }
                        }
                        
                    }
                    
                    
                }
                
            }
            
        })
        
        
    }
    
    @IBOutlet weak var tapfilters: UIButton!
    
    var testbookcovers = [UIImage]()
    
    var testids = [String]()
    
    func removeids() {
        
        oneids.removeAll()
        onebookcovers.removeAll()
        twoids.removeAll()
        twobookcovers.removeAll()
        threeids.removeAll()
        threebookcovers.removeAll()
        fourids.removeAll()
        fourbookcovers.removeAll()
        fiveids.removeAll()
        fivebookcovers.removeAll()
        sixids.removeAll()
        sixbookcovers.removeAll()
        sevenids.removeAll()
        sevenbookcovers.removeAll()
        eightids.removeAll()
        eightbookcovers.removeAll()
        nineids.removeAll()
        ninebookcovers.removeAll()
    }
    
    func loadids() {

        
        twoids.append("1")
        twoids.append("2")
        twoids.append("3")
        twoids.append("4")
        twoids.append("5")
        twoids.append("6")
        twoids.append("7")
        twoids.append("8")
        twoids.append("9")
        twoids.append("10")
        
        twobookcovers.append(UIImage(named: "M1")!)
        twobookcovers.append(UIImage(named: "M2")!)
        twobookcovers.append(UIImage(named: "M3")!)
        twobookcovers.append(UIImage(named: "M4")!)
        twobookcovers.append(UIImage(named: "M5")!)
        twobookcovers.append(UIImage(named: "M6")!)
        twobookcovers.append(UIImage(named: "M7")!)
        twobookcovers.append(UIImage(named: "M8")!)
        twobookcovers.append(UIImage(named: "M9")!)
        twobookcovers.append(UIImage(named: "M10")!)
        
        threeids.append("1")
        threeids.append("2")
        threeids.append("3")
        threeids.append("4")
        threeids.append("5")
        threeids.append("6")
        threeids.append("7")
        threeids.append("8")
        threeids.append("9")
        threeids.append("10")
        
        threebookcovers.append(UIImage(named: "F1")!)
        threebookcovers.append(UIImage(named: "F2")!)
        threebookcovers.append(UIImage(named: "F3")!)
        threebookcovers.append(UIImage(named: "F4")!)
        threebookcovers.append(UIImage(named: "F5")!)
        threebookcovers.append(UIImage(named: "F6")!)
        threebookcovers.append(UIImage(named: "F7")!)
        threebookcovers.append(UIImage(named: "F8")!)
        threebookcovers.append(UIImage(named: "F9")!)
        threebookcovers.append(UIImage(named: "F10")!)
        
        fourids.append("2")
        fourids.append("3")
        fourids.append("4")
        
        fourbookcovers.append(UIImage(named: "H1")!)
        fourbookcovers.append(UIImage(named: "H2")!)
        fourbookcovers.append(UIImage(named: "H3")!)
 
        
        fiveids.append("1")
        fiveids.append("2")
        fiveids.append("3")
        fiveids.append("4")
        fiveids.append("5")
        fiveids.append("6")
        fiveids.append("7")
        fiveids.append("8")
        fiveids.append("9")
        fiveids.append("10")
        fiveids.append("11")
        fiveids.append("12")
        fiveids.append("13")
        fiveids.append("14")
        fiveids.append("15")
        fiveids.append("16")
        fiveids.append("17")
        fiveids.append("18")
        fiveids.append("19")

        
        fivebookcovers.append(UIImage(named: "B1")!)
        fivebookcovers.append(UIImage(named: "B2")!)
        fivebookcovers.append(UIImage(named: "B3")!)
        fivebookcovers.append(UIImage(named: "B4")!)
        fivebookcovers.append(UIImage(named: "B5")!)
        fivebookcovers.append(UIImage(named: "B6")!)
        fivebookcovers.append(UIImage(named: "B7")!)
        fivebookcovers.append(UIImage(named: "B8")!)
        fivebookcovers.append(UIImage(named: "B9")!)
        fivebookcovers.append(UIImage(named: "B10")!)
        fivebookcovers.append(UIImage(named: "B11")!)
        fivebookcovers.append(UIImage(named: "B12")!)
        fivebookcovers.append(UIImage(named: "B13")!)
        fivebookcovers.append(UIImage(named: "B14")!)
        fivebookcovers.append(UIImage(named: "B15")!)
        fivebookcovers.append(UIImage(named: "B16")!)
        fivebookcovers.append(UIImage(named: "B17")!)
        fivebookcovers.append(UIImage(named: "B18")!)
        fivebookcovers.append(UIImage(named: "B19")!)

        

        sixids.append("1")
        sixids.append("2")
        sixids.append("3")
        sixids.append("4")

        
        sixbookcovers.append(UIImage(named: "S1")!)
        sixbookcovers.append(UIImage(named: "S2")!)
        sixbookcovers.append(UIImage(named: "S3")!)
        sixbookcovers.append(UIImage(named: "S4")!)


        sevenids.append("1")
        sevenids.append("2")
        sevenids.append("3")
        sevenids.append("4")
        sevenids.append("5")
        sevenids.append("6")
        sevenids.append("7")
        sevenids.append("8")
        sevenids.append("9")
        sevenids.append("10")
        
        sevenbookcovers.append(UIImage(named: "PR1")!)
        sevenbookcovers.append(UIImage(named: "PR2")!)
        sevenbookcovers.append(UIImage(named: "PR3")!)
        sevenbookcovers.append(UIImage(named: "PR4")!)
        sevenbookcovers.append(UIImage(named: "PR5")!)
        sevenbookcovers.append(UIImage(named: "PR6")!)
        sevenbookcovers.append(UIImage(named: "PR7")!)
        sevenbookcovers.append(UIImage(named: "PR8")!)
        
        
        eightids.append("1")
        eightids.append("2")
        eightids.append("3")
        eightids.append("4")
        eightids.append("5")
        eightids.append("6")
        eightids.append("7")
        eightids.append("8")
        eightids.append("9")
        eightids.append("10")
        
        eightbookcovers.append(UIImage(named: "MH1")!)
        eightbookcovers.append(UIImage(named: "MH2")!)
        eightbookcovers.append(UIImage(named: "MH3")!)
        eightbookcovers.append(UIImage(named: "MH4")!)
        eightbookcovers.append(UIImage(named: "MH5")!)
        eightbookcovers.append(UIImage(named: "MH6")!)
        eightbookcovers.append(UIImage(named: "MH7")!)
        eightbookcovers.append(UIImage(named: "MH8")!)
        eightbookcovers.append(UIImage(named: "MH9")!)
        eightbookcovers.append(UIImage(named: "MH10")!)

        nineids.append("1")
        nineids.append("2")
        nineids.append("3")
        nineids.append("4")
        nineids.append("5")
        nineids.append("6")
        nineids.append("7")
        nineids.append("8")
        nineids.append("9")
        nineids.append("10")
        nineids.append("11")
        nineids.append("12")
        nineids.append("13")
        nineids.append("14")
        nineids.append("15")
        nineids.append("16")
        nineids.append("17")
        nineids.append("18")
        nineids.append("19")
        nineids.append("20")
        
        ninebookcovers.append(UIImage(named: "PS1")!)
        ninebookcovers.append(UIImage(named: "PS2")!)
        ninebookcovers.append(UIImage(named: "PS3")!)
        ninebookcovers.append(UIImage(named: "PS4")!)
        ninebookcovers.append(UIImage(named: "PS5")!)
        ninebookcovers.append(UIImage(named: "PS6")!)
        ninebookcovers.append(UIImage(named: "PS7")!)
        ninebookcovers.append(UIImage(named: "PS8")!)
        ninebookcovers.append(UIImage(named: "PS9")!)
        ninebookcovers.append(UIImage(named: "PS10")!)
        ninebookcovers.append(UIImage(named: "PS11")!)
        ninebookcovers.append(UIImage(named: "PS12")!)
        ninebookcovers.append(UIImage(named: "PS13")!)
        ninebookcovers.append(UIImage(named: "PS14")!)
        ninebookcovers.append(UIImage(named: "PS15")!)
        ninebookcovers.append(UIImage(named: "PS16")!)
        ninebookcovers.append(UIImage(named: "PS17")!)
        ninebookcovers.append(UIImage(named: "PS18")!)
        ninebookcovers.append(UIImage(named: "PS19")!)
        ninebookcovers.append(UIImage(named: "PS20")!)
        ninebookcovers.append(UIImage(named: "PS21")!)
        ninebookcovers.append(UIImage(named: "PS21")!)

        
//        collectionView1.reloadData()
//        collectionView2.reloadData()
        collectionView3.reloadData()
        collectionView4.reloadData()
        collectionView5.reloadData()
        collectionView6.reloadData()
        collectionView7.reloadData()
        collectionView8.reloadData()
        collectionView9.reloadData()
        
    }
    
//    func queryforbookinfo() {
//
//            var functioncounter = 0
//
//            bookids = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: bookids) as! [String]
//
//            for each in bookids  {
//
//                bookcompleted[each] = "False"
//
//                ref?.child("AllBooks1").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
//
//                    var value = snapshot.value as? NSDictionary
//
//                            if var productimagee = value?["Image"] as? String {
//
//                                ninebookurls[each] = productimagee
//
//                        }
//
//
//                })
//        }
//
//}
//
    
    
    

  
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
            if collectionView.tag == 1 {
                
            return oneids.count

            } else {
                
                if collectionView.tag == 2 {
                    
                    return twoids.count
                    
                } else {
                    
                    if collectionView.tag == 3 {
                        
                        return threebookcovers.count
                        
                    } else {
                        
                        if collectionView.tag == 4 {
                            
                            return fourids.count
                            
                        } else {
                            
                            if collectionView.tag == 5 {
                                
                                return fiveids.count
                                
                            } else {
                                
                                if collectionView.tag == 6 {
                                    
                                    return sixids.count
                                    
                                } else {
                                    
                                    if collectionView.tag == 7 {
                                        
                                        return sevenids.count
                                        
                                    } else {
                                        
                                        if collectionView.tag == 8 {
                                            
                                            return eightids.count
                                            
                                        } else {
                                            
                                            if collectionView.tag == 9 {
                                                
                                                return nineids.count
                                                
                                            } else {
                                                
                                                return 0
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                }
            }
    
    func queryforfreebook() {
        
        var functioncounter = 0
        
        ref?.child("AllBooks1").child("Free").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var productimagee = value?["Image"] as? String {
                
                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                    
                    let url = URL(string: productimagee)
                    
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    
                    if data != nil {
                        
                        let productphoto = UIImage(data: (data)!)
                        
                        //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                        let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                        
                        self.freebookimage = productphoto!
                        
                        self.freebackground.image = productphoto
                        
                        functioncounter += 1
                        
                        
                    }
                    
                    
                }
            }
            
        })
        
    }
    
    var freebookimage = UIImage()
    
    @IBAction func tapFree(_ sender: Any) {
        
        selectedgenre = "Free"
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        selectedbookid = "Free"
        selectedimage = freebookimage
        
        freepressed = true
        
        self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
        
    }
    
    
    @IBOutlet weak var freebackground: UIImageView!
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Books", for: indexPath) as! BooksCollectionViewCell
        cell.bookcover.layer.cornerRadius = 10.0
        cell.bookcover.layer.masksToBounds = true
        
        cell.dark.layer.cornerRadius = 10.0
        cell.dark.layer.masksToBounds = true
        
        
        if purchased {
            
            cell.lockimage.alpha = 0

            
        } else {
            
            
            cell.lockimage.alpha = 1
            
        }
        
        
            if collectionView.tag == 9 {
                
                if ninebookcovers.count > indexPath.row {

                cell.bookcover.image = ninebookcovers[indexPath.row]
                
                hideloading()
                    
                }
                
            }
        
        if collectionView.tag == 1 {
            
            if onebookcovers.count > indexPath.row {
                
//                cell.bookauthor.text = "\(onebookinsights[oneids[indexPath.row]]!) views"
                cell.bookcover.image = onebookcovers[indexPath.row]
                cell.lockimage.alpha = 1
                    if indexPath.row == 0 {
                        
                        cell.lockimage.image = UIImage(named: "Tester")
                        
                    } else {
                        
                        
                    }
                
            }
            
        }
        
        if collectionView.tag == 2 {
            
            cell.lockimage.alpha = 1
            
            if twobookcovers.count > indexPath.row {
                
                cell.bookcover.image = twobookcovers[indexPath.row]
                
                
            }
            
        }
        
        if collectionView.tag == 3 {
            
            if threebookcovers.count > indexPath.row {
                
                cell.bookcover.image = threebookcovers[indexPath.row]
                
            }
            
        }
        
        if collectionView.tag == 4 {
            
            if fourbookcovers.count > indexPath.row {
                
                cell.bookcover.image = fourbookcovers[indexPath.row]
                
                
            }
            
        }
        
        if collectionView.tag == 5 {
            
            if fivebookcovers.count > indexPath.row {
                
                cell.bookcover.image = fivebookcovers[indexPath.row]
                
                
            }
            
        }
        
        if collectionView.tag == 6 {
            
            if sixbookcovers.count > indexPath.row {
                
                cell.bookcover.image = sixbookcovers[indexPath.row]
                
                
            }
            
        }
        
        if collectionView.tag == 7 {
            
            if sevenbookcovers.count > indexPath.row {
                
                cell.bookcover.image = sevenbookcovers[indexPath.row]
                
                
            }
            
        }
        
        if collectionView.tag == 8 {
            
            if eightbookcovers.count > indexPath.row {
                
                cell.bookcover.image = eightbookcovers[indexPath.row]
                
                
            }
            
        }
        

                

            
//            if bookcompleted[bookids[indexPath.row]] == "True" {
//
//                cell.lockimage.alpha = 0
//
//            } else {
//
//                cell.lockimage.alpha = 1
//
//                }
//
        return cell

            }

        
    
    
    @IBOutlet weak var whitelabel: UILabel!
    
    @IBOutlet weak var collectionView9: UICollectionView!
    @IBOutlet weak var collectionView8: UICollectionView!
    @IBOutlet weak var collectionView7: UICollectionView!
    @IBOutlet weak var collectionView6: UICollectionView!
    @IBOutlet weak var collectionView5: UICollectionView!
    @IBOutlet weak var collectionView4: UICollectionView!
    @IBOutlet weak var collectionView1: UICollectionView!
//    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
            if collectionView.tag == 1 {
                
                selectedbookid = oneids[indexPath.row]
                selectedimage = onebookcovers[indexPath.row]
                self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)

                
            } else {
                
                if collectionView.tag == 2 {

                    selectedbookid = twoids[indexPath.row]
                    selectedimage = twobookcovers[indexPath.row]
                    
                    
                    selectedgenre = "Biography & Memoir"
                    FBSDKAppEvents.logEvent("Biography Tapped")

                    self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                    
                } else {
                    
                    if collectionView.tag == 3 {
                        selectedbookid = threeids[indexPath.row]
       
                        selectedimage = threebookcovers[indexPath.row]
                     selectedgenre = "For You"
                        FBSDKAppEvents.logEvent("For You Tapped")
                        self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                        
                    } else {
                        
                        if collectionView.tag == 4 {
                            
                            selectedbookid = fourids[indexPath.row]
                            selectedgenre = "Health, Fitness, & Dieting"
                            selectedimage = fourbookcovers[indexPath.row]
                     
                            FBSDKAppEvents.logEvent("Health, Fitness, & Dieting Tapped")
                            self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                            
                        } else {
                            
                            if collectionView.tag == 5 {
                                
                                selectedbookid = fiveids[indexPath.row]
                                selectedgenre = "Business & Investing"
                                selectedimage = fivebookcovers[indexPath.row]
       
                                FBSDKAppEvents.logEvent("Business & Investing Tapped")
                                self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                
                            } else {
                                
                                if collectionView.tag == 6 {
                                    
                                    selectedbookid = sixids[indexPath.row]
                                    selectedimage = sixbookcovers[indexPath.row]
                                    selectedgenre = "Sex & Relationships"
                                    FBSDKAppEvents.logEvent("Sex & Relationships Tapped")
                                    self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                    
                                } else {
                                    
                                    if collectionView.tag == 7 {
                                        
                                        selectedbookid = sevenids[indexPath.row]
 
                                        selectedimage = sevenbookcovers[indexPath.row]
                                        selectedgenre = "Productivity"
                                        FBSDKAppEvents.logEvent("Productivity Tapped")
                                        self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                        
                                    } else {
                                        
                                        if collectionView.tag == 8 {
                                            
                                            selectedbookid = eightids[indexPath.row]
                                            selectedimage = eightbookcovers[indexPath.row]
                                            selectedgenre = "Mental Health"
                                            FBSDKAppEvents.logEvent("Mental Health Tapped")
                                            self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                            
                                        } else {
                                            
                                            if collectionView.tag == 9 {
                                                
                                                selectedbookid = nineids[indexPath.row]

                                                selectedimage = ninebookcovers[indexPath.row]
                                                selectedgenre = "Psychology"

                                                FBSDKAppEvents.logEvent("Psychology Tapped")
                                                
                                                self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                                
                                            } else {
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
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
        
        let alert = UIAlertController(title: "Shake To Report", message: "Please report any issues you found! Feedback is greatly appreciated :)", preferredStyle: UIAlertControllerStyle.alert)
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
        
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 5
        subview.backgroundColor = .white
        
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

var twobooknames = [String:String]()
var twobookauthors = [String:String]()
var twobookcovers = [UIImage]()
var twobookdescriptions = [String:String]()
var twobookurls = [String:String]()
var twobookcompleted = [String:String]()
var twobookinsights = [String:String]()

var threebooknames = [String:String]()
var threebookauthors = [String:String]()
var threebookcovers = [UIImage]()
var threebookdescriptions = [String:String]()
var threebookurls = [String:String]()
var threebookcompleted = [String:String]()
var threebookinsights = [String:String]()

var fourbooknames = [String:String]()
var fourbookauthors = [String:String]()
var fourbookcovers = [UIImage]()
var fourbookdescriptions = [String:String]()
var fourbookurls = [String:String]()
var fourbookcompleted = [String:String]()
var fourbookinsights = [String:String]()

var fivebooknames = [String:String]()
var fivebookauthors = [String:String]()
var fivebookcovers = [UIImage]()
var fivebookdescriptions = [String:String]()
var fivebookurls = [String:String]()
var fivebookcompleted = [String:String]()
var fivebookinsights = [String:String]()

var sixbooknames = [String:String]()
var sixbookauthors = [String:String]()
var sixbookcovers = [UIImage]()
var sixbookdescriptions = [String:String]()
var sixbookurls = [String:String]()
var sixbookcompleted = [String:String]()
var sixbookinsights = [String:String]()

var sevenbooknames = [String:String]()
var sevenbookauthors = [String:String]()
var sevenbookcovers = [UIImage]()
var sevenbookdescriptions = [String:String]()
var sevenbookurls = [String:String]()
var sevenbookcompleted = [String:String]()
var sevenbookinsights = [String:String]()

var eightbooknames = [String:String]()
var eightbookauthors = [String:String]()
var eightbookcovers = [UIImage]()
var eightbookdescriptions = [String:String]()
var eightbookurls = [String:String]()
var eightbookcompleted = [String:String]()
var eightbookinsights = [String:String]()

var ninebooknames = [String:String]()
var ninebookauthors = [String:String]()
var ninebookcovers = [UIImage]()
var ninebookdescriptions = [String:String]()
var ninebookurls = [String:String]()
var ninebookcompleted = [String:String]()
var ninebookinsights = [String:String]()

var oneids = [String]()
var twoids = [String]()
var threeids = [String]()
var fourids = [String]()
var fiveids = [String]()
var sixids = [String]()
var sevenids = [String]()
var eightids = [String]()
var nineids = [String]()

var bookcompleted = [String:String]()
//
//if var activityvalue = value?["Author"] as? String {
//
//    bookauthors[each] = activityvalue
//
//}
//
//if var activityvalue2 = value?["Name"] as? String {
//
//    booknames[each] = activityvalue2
//}
//
//if var activityvalue2 = value?["Description"] as? String {
//
//    bookdescriptions[each] = activityvalue2
//
//} else {
//
//    bookdescriptions[each] = "Dummy"
//
//    bookcompleted[each] = "Dummy"
//
//}
//
//if var activityvalue2 = value?["Insights"] as? String {
//
//    bookinsights[each] = activityvalue2
//}
//
//if var productimagee = value?["Image"] as? String {
//
//    bookurls[each] = productimagee
//
//    if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
//
//        let url = URL(string: productimagee)
//
//        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//
//        if data != nil {
//
//            let productphoto = UIImage(data: (data)!)
//
//            //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
//            let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
//
//            bookcovers[each] = productphoto
//
//            functioncounter += 1
//
//
//        }
//
//    }
//
//}

var selectedgenre = String()
