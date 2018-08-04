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

        
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in

            var text = "Most Popular"
            
            categorylabel.text = text.uppercased()

 
            
            purchased = false
        
            tapsettings.alpha = 0
            tapfavorties.alpha = 0
            taphome.alpha = 0
            taplibrary.alpha = 0
            tapfilters.alpha = 0
//            tapcta.alpha = 1
            
            freepressed = false
            queryforfreebook()
            
        } else {
            

            
            uid = (Auth.auth().currentUser?.uid)!

            newuser = false
            // Do any additional setup after loading the view.
            purchased = true
            tapsettings.alpha = 1
            tapfavorties.alpha = 1
            taphome.alpha = 1
            taplibrary.alpha = 1
            tapfilters.alpha = 0
            
            freepressed = false
            queryforfreebook()

            
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

        oneids.append("1")
        oneids.append("2")
        oneids.append("3")
        oneids.append("4")
        oneids.append("5")
        oneids.append("6")
        oneids.append("7")
        oneids.append("8")
        oneids.append("9")
        oneids.append("10")
        onebookcovers.append(UIImage(named: "1")!)
        onebookcovers.append(UIImage(named: "2")!)
        onebookcovers.append(UIImage(named: "3")!)
        onebookcovers.append(UIImage(named: "4")!)
        onebookcovers.append(UIImage(named: "5")!)
        onebookcovers.append(UIImage(named: "6")!)
        onebookcovers.append(UIImage(named: "7")!)
        onebookcovers.append(UIImage(named: "8")!)
        onebookcovers.append(UIImage(named: "9")!)
        onebookcovers.append(UIImage(named: "10")!)
        
        twoids.append("11")
        twoids.append("12")
        twoids.append("33")
        twoids.append("14")
        twoids.append("15")
        twoids.append("16")
        twoids.append("17")
        twoids.append("18")
        twoids.append("19")
        twoids.append("20")
        twobookcovers.append(UIImage(named: "11")!)
        twobookcovers.append(UIImage(named: "12")!)
        twobookcovers.append(UIImage(named: "13")!)
        twobookcovers.append(UIImage(named: "14")!)
        twobookcovers.append(UIImage(named: "15")!)
        twobookcovers.append(UIImage(named: "16")!)
        twobookcovers.append(UIImage(named: "17")!)
        twobookcovers.append(UIImage(named: "18")!)
        twobookcovers.append(UIImage(named: "19")!)
        twobookcovers.append(UIImage(named: "20")!)
        
        threeids.append("21")
        threeids.append("22")
        threeids.append("23")
        threeids.append("24")
        threeids.append("25")
        threeids.append("26")
        threeids.append("27")
        threeids.append("28")
        threeids.append("29")
        threeids.append("30")
        threebookcovers.append(UIImage(named: "21")!)
        threebookcovers.append(UIImage(named: "22")!)
        threebookcovers.append(UIImage(named: "23")!)
        threebookcovers.append(UIImage(named: "24")!)
        threebookcovers.append(UIImage(named: "25")!)
        threebookcovers.append(UIImage(named: "26")!)
        threebookcovers.append(UIImage(named: "27")!)
        threebookcovers.append(UIImage(named: "28")!)
        threebookcovers.append(UIImage(named: "29")!)
        threebookcovers.append(UIImage(named: "30")!)
        
        fourids.append("31")
        fourids.append("32")
        fourids.append("33")
        fourids.append("34")
        fourids.append("35")
        fourids.append("36")
        fourids.append("37")
        fourids.append("38")
        fourids.append("39")
        fourids.append("40")
        fourbookcovers.append(UIImage(named: "31")!)
        fourbookcovers.append(UIImage(named: "32")!)
        fourbookcovers.append(UIImage(named: "33")!)
        fourbookcovers.append(UIImage(named: "34")!)
        fourbookcovers.append(UIImage(named: "35")!)
        fourbookcovers.append(UIImage(named: "36")!)
        fourbookcovers.append(UIImage(named: "37")!)
        fourbookcovers.append(UIImage(named: "38")!)
        fourbookcovers.append(UIImage(named: "39")!)
        fourbookcovers.append(UIImage(named: "40")!)
        
        fiveids.append("41")
        fiveids.append("42")
        fiveids.append("43")
        fiveids.append("44")
        fiveids.append("45")
        fiveids.append("46")
        fiveids.append("47")
        fiveids.append("48")
        fiveids.append("49")
        fiveids.append("50")
        fivebookcovers.append(UIImage(named: "41")!)
        fivebookcovers.append(UIImage(named: "42")!)
        fivebookcovers.append(UIImage(named: "43")!)
        fivebookcovers.append(UIImage(named: "44")!)
        fivebookcovers.append(UIImage(named: "45")!)
        fivebookcovers.append(UIImage(named: "46")!)
        fivebookcovers.append(UIImage(named: "47")!)
        fivebookcovers.append(UIImage(named: "48")!)
        fivebookcovers.append(UIImage(named: "49")!)
        fivebookcovers.append(UIImage(named: "50")!)
        

//
        sixids.append("51")
        sixids.append("52")
        sixids.append("53")
        sixids.append("54")
        sixids.append("55")
        sixids.append("56")
        sixids.append("57")
        sixids.append("58")
        sixids.append("59")
        sixids.append("60")
        sixbookcovers.append(UIImage(named: "51")!)
        sixbookcovers.append(UIImage(named: "52")!)
        sixbookcovers.append(UIImage(named: "53")!)
        sixbookcovers.append(UIImage(named: "54")!)
        sixbookcovers.append(UIImage(named: "55")!)
        sixbookcovers.append(UIImage(named: "56")!)
        sixbookcovers.append(UIImage(named: "57")!)
        sixbookcovers.append(UIImage(named: "58")!)
        sixbookcovers.append(UIImage(named: "59")!)
        sixbookcovers.append(UIImage(named: "60")!)

        sevenids.append("61")
        sevenids.append("62")
        sevenids.append("63")
        sevenids.append("64")
        sevenids.append("65")
        sevenids.append("66")
        sevenids.append("67")
        sevenids.append("68")
        sevenids.append("69")
        sevenids.append("70")
        sevenbookcovers.append(UIImage(named: "61")!)
        sevenbookcovers.append(UIImage(named: "62")!)
        sevenbookcovers.append(UIImage(named: "63")!)
        sevenbookcovers.append(UIImage(named: "64")!)
        sevenbookcovers.append(UIImage(named: "65")!)
        sevenbookcovers.append(UIImage(named: "66")!)
        sevenbookcovers.append(UIImage(named: "67")!)
        sevenbookcovers.append(UIImage(named: "68")!)
        sevenbookcovers.append(UIImage(named: "69")!)
        sevenbookcovers.append(UIImage(named: "70")!)

        eightids.append("71")
        eightids.append("72")
        eightids.append("73")
        eightids.append("74")
        eightids.append("75")
        eightids.append("76")
        eightids.append("77")
        eightids.append("78")
        eightids.append("79")
        eightids.append("80")
        eightbookcovers.append(UIImage(named: "71")!)
        eightbookcovers.append(UIImage(named: "72")!)
        eightbookcovers.append(UIImage(named: "73")!)
        eightbookcovers.append(UIImage(named: "74")!)
        eightbookcovers.append(UIImage(named: "75")!)
        eightbookcovers.append(UIImage(named: "76")!)
        eightbookcovers.append(UIImage(named: "77")!)
        eightbookcovers.append(UIImage(named: "78")!)
        eightbookcovers.append(UIImage(named: "79")!)
        eightbookcovers.append(UIImage(named: "80")!)

        nineids.append("81")
        nineids.append("82")
        nineids.append("83")
        nineids.append("84")
        nineids.append("85")
        nineids.append("86")
        nineids.append("87")
        nineids.append("88")
        nineids.append("89")
        nineids.append("90")
        nineids.append("129")
        ninebookcovers.append(UIImage(named: "81")!)
        ninebookcovers.append(UIImage(named: "82")!)
        ninebookcovers.append(UIImage(named: "83")!)
        ninebookcovers.append(UIImage(named: "84")!)
        ninebookcovers.append(UIImage(named: "85")!)
        ninebookcovers.append(UIImage(named: "86")!)
        ninebookcovers.append(UIImage(named: "87")!)
        ninebookcovers.append(UIImage(named: "88")!)
        ninebookcovers.append(UIImage(named: "89")!)
        ninebookcovers.append(UIImage(named: "90")!)
        ninebookcovers.append(UIImage(named: "129")!)

        
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
                        
                        return threeids.count
                        
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
        
        cell.bookauthor.alpha = 0
        
        if purchased {
            
            
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
                
                    if indexPath.row == 0 {
                        
                        cell.lockimage.image = UIImage(named: "Tester")
                        
                    } else {
                        
                        
                    }
                
            }
            
        }
        
        if collectionView.tag == 2 {
            
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

                    
                    self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                    
                } else {
                    
                    if collectionView.tag == 3 {
                        selectedbookid = threeids[indexPath.row]
       
                        selectedimage = threebookcovers[indexPath.row]
                     
                        
                        self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                        
                    } else {
                        
                        if collectionView.tag == 4 {
                            
                            selectedbookid = fourids[indexPath.row]

                            selectedimage = fourbookcovers[indexPath.row]
                     
                            
                            self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                            
                        } else {
                            
                            if collectionView.tag == 5 {
                                
                                selectedbookid = fiveids[indexPath.row]

                                selectedimage = fivebookcovers[indexPath.row]
       
                                
                                self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                
                            } else {
                                
                                if collectionView.tag == 6 {
                                    
                                    selectedbookid = sixids[indexPath.row]
                                    selectedimage = sixbookcovers[indexPath.row]

                                    self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                    
                                } else {
                                    
                                    if collectionView.tag == 7 {
                                        
                                        selectedbookid = sevenids[indexPath.row]
 
                                        selectedimage = sevenbookcovers[indexPath.row]

                                        
                                        self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                        
                                    } else {
                                        
                                        if collectionView.tag == 8 {
                                            
                                            selectedbookid = eightids[indexPath.row]
                                            selectedimage = eightbookcovers[indexPath.row]
                                            
                                            self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                            
                                        } else {
                                            
                                            if collectionView.tag == 9 {
                                                
                                                selectedbookid = nineids[indexPath.row]

                                                selectedimage = ninebookcovers[indexPath.row]

                                                
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
