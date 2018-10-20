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
//        coverimage.alpha = 0
////        logo.alpha = 0
//        activityIndicator.stopAnimating()
//        activityIndicator.alpha = 0
//        loadingback.alpha = 0
//        tapfavorties.alpha = 1
//        taphome.alpha = 1
//        taplibrary.alpha = 1
//        tapfilters.alpha = 1
    }
    
    @IBOutlet weak var loadingback: UILabel!
    @IBOutlet weak var coverimage: UIImageView!
    @IBOutlet weak var loadinglabel: UILabel!
    func showloading() {
        
//        coverimage.alpha = 1
//        logo.alpha = 1
//        loadingback.alpha = 1
//        activityIndicator.startAnimating()
//        activityIndicator.alpha = 1
        
//        tapfavorties.alpha = 0
//        taphome.alpha = 0
//        taplibrary.alpha = 0
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tapcta: UIButton!
    @IBOutlet weak var categorylabel: UILabel!
    @IBOutlet weak var tapfavorties: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func startTimer() {
        
        let timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.scrollToNextCell), userInfo: nil, repeats: true);
        
        
    }
    
    @IBOutlet weak var tapsettings: UIButton!
    @IBOutlet weak var taphome: UIButton!
    @IBOutlet weak var taplib: UIButton!
    @IBOutlet weak var navlabel: UILabel!
    @objc func scrollToNextCell() {
        
        
        //get cell size
        let cellSize = CGRect(x: 0, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        
        //get current content Offset of the Collection view
        let contentOffset = collectionView1.contentOffset
        
        //scroll to next cell
        collectionView1.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width - 25, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
        
        
    }
    
    func yomofucker() {
        
        
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: "Cmon", sender: self)

                        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        seemoreviews.removeAll()
        
        
        self.becomeFirstResponder() // To get shake gesture
        
//        freebackground.layer.cornerRadius = 5.0
        FBSDKAppEvents.logEvent("Discover Viewed")
//        activityIndicator.color = .white
        // Do any additional setup after loading the view.
        
        showloading()
        hideloading()
        
        backgroundlabel.layer.cornerRadius = 5.0
        backgroundlabel.clipsToBounds = true
        
//        freebackground.layer.cornerRadius = 5.0
//        freebackground.clipsToBounds = true
        if bookids.count > 0 {
            
            
        } else {
            
            removeids()
            loadids()
        }

        self.freebookimage = UIImage(named: "pp copy")!

        startTimer()
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in

            var text = "Most Popular"
            
            categorylabel.text = text.uppercased()

            purchased = false
        

//            tapcta.alpha = 1
//            tapsettings.alpha = 0
//            taphome.alpha = 0
//            taplib.alpha = 0
//            navlabel.alpha = 0
            freepressed = false
            
//            DispatchQueue.main.async {
//                
//                self.performSegue(withIdentifier: "HomeToDemo", sender: self)
//
//            }
//            queryforfreebook()
            
            
        } else {
            

            
            uid = (Auth.auth().currentUser?.uid)!

            newuser = false
            // Do any additional setup after loading the view.
            purchased = true
//            tapsettings.alpha = 1
            freepressed = false
//            taphome.alpha = 1
//            taplib.alpha = 1
//            navlabel.alpha = 1
//            queryforfreebook()

            
//            tapfilters.alpha = 1
//            queryforcompletedbookids()
//            let date = Date()
//            let calendar = Calendar.current
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MM-dd-yy"
//            todaysdate =  dateFormatter.string(from: date)
            
            if uid == "UQPiEDlHTcTL3BYdFWCMF5YIJde2" {
                
                loadgirlstuff()
            }
            

        }
        // Do any additional setup after loading the view.
        
//        collectionView3.decelerationRate  = UIScrollViewDecelerationRateFast
//        collectionView4.decelerationRate  = UIScrollViewDecelerationRateFast
//        collectionView5.decelerationRate  = UIScrollViewDecelerationRateFast
//        collectionView6.decelerationRate  = UIScrollViewDecelerationRateFast
//        collectionView7.decelerationRate  = UIScrollViewDecelerationRateFast
//        collectionView8.decelerationRate  = UIScrollViewDecelerationRateFast
//        
//        collectionView9.decelerationRate  = UIScrollViewDecelerationRateFast


    }

    @IBOutlet weak var backgroundlabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                                
//                                self.collectionView1.reloadData()
                                
                            }
                        }
                        
                    }
                    
                    
                }
                
            }
            
        })
        
        
    }
    
    
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
        oneviews.removeAll()
        twoviews.removeAll()
        threeviews.removeAll()
        fourviews.removeAll()
        fiveviews.removeAll()
        sixviews.removeAll()
        sevenviews.removeAll()
        eightviews.removeAll()
        nineviews.removeAll()
    }
    
    @IBOutlet weak var psychologylabel: UILabel!
    func loadids() {

        onebookcovers.append(UIImage(named: "BS1")!)
        onebookcovers.append(UIImage(named: "BS2")!)
        onebookcovers.append(UIImage(named: "BS3")!)
        onebookcovers.append(UIImage(named: "BS5")!)
        onebookcovers.append(UIImage(named: "BS6")!)
        onebookcovers.append(UIImage(named: "BS7")!)
        onebookcovers.append(UIImage(named: "BS9")!)
        
        oneids.append("1")
        oneids.append("2")
        oneids.append("3")
        oneids.append("4")
        oneids.append("5")
        oneids.append("6")
        oneids.append("7")

        
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

        twoauthors.append("Mindy Kaling")
        twoauthors.append("Phil Knight")
        twoauthors.append("Viktor E. Frankl")
        twoauthors.append("Randy Pausch")
        twoauthors.append("Susan Orlean")
        twoauthors.append("Paul Kalanithi")
        twoauthors.append("Ashlee Vance")
        twoauthors.append("Ron Chernow")
        twoauthors.append("Arnold Schwarzenegger")
        twoauthors.append("Ray Dalio")
        twotitles.append("Is Everyone Hanging Out Without Me?")
        twotitles.append("Shoe Dog")
        twotitles.append("Man's Search for Meaning")
        twotitles.append("The Last Lecture")
        twotitles.append("The Orchid Thief")
        twotitles.append("When Breath Becomes Air")
        twotitles.append("Elon Musk")
        twotitles.append("Titan")
        twotitles.append("Total Recall")
        twotitles.append("Principles: Life and Work")
        

        
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
        
        fourids.append("1")
        fourids.append("2")
        fourids.append("3")
        fourids.append("4")
        fourids.append("5")
        fourids.append("6")
        fourids.append("7")

        fourbookcovers.append(UIImage(named: "H1")!)
        fourbookcovers.append(UIImage(named: "H2")!)
        fourbookcovers.append(UIImage(named: "H3")!)
        fourbookcovers.append(UIImage(named: "H4")!)
        fourbookcovers.append(UIImage(named: "H5")!)
        fourbookcovers.append(UIImage(named: "H6")!)
        fourbookcovers.append(UIImage(named: "H7")!)

        
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
        sixids.append("5")
        sixids.append("6")

        sixbookcovers.append(UIImage(named: "S1")!)
        sixbookcovers.append(UIImage(named: "S2")!)
        sixbookcovers.append(UIImage(named: "S3")!)
        sixbookcovers.append(UIImage(named: "S4")!)
        sixbookcovers.append(UIImage(named: "S5")!)
        sixbookcovers.append(UIImage(named: "S6")!)


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
        sevenbookcovers.append(UIImage(named: "PR9")!)

        
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
        eightids.append("11")

        eightids.append("12")

        eightids.append("13")

        
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
        eightbookcovers.append(UIImage(named: "MH11")!)
        eightbookcovers.append(UIImage(named: "MH12")!)
        eightbookcovers.append(UIImage(named: "MH13")!)

        
        
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
        nineids.append("21")
        nineids.append("22")
        nineids.append("23")
        nineids.append("24")
        nineids.append("25")
        nineids.append("26")
        
        
        
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
        ninebookcovers.append(UIImage(named: "PS22")!)
        ninebookcovers.append(UIImage(named: "PS23")!)
        ninebookcovers.append(UIImage(named: "PS24")!)
        ninebookcovers.append(UIImage(named: "PS25")!)
        ninebookcovers.append(UIImage(named: "PS26")!)

        oneviews.append("233K views")
        oneviews.append("492K views")
        oneviews.append("432K views")
        oneviews.append("589K views")
        oneviews.append("2.4M views")
        oneviews.append("2M views")
        oneviews.append("1.3M views")
        oneviews.append("1.9M views")
        oneviews.append("887K views")
        oneviews.append("145K views")
        
        twoviews.append("343K views")
        twoviews.append("466.9K views")
        twoviews.append("957.6K views")
        twoviews.append("377.9K views")
        twoviews.append("3.4M views")
        twoviews.append("2.1M views")
        twoviews.append("1.6M views")
        twoviews.append("1.2M views")
        twoviews.append("87K views")
        twoviews.append("123.5K views")

        threeviews.append("377.9K views")
        threeviews.append("3.4M views")
        threeviews.append("933.6K views")
        threeviews.append("395.8K views")
        threeviews.append("82K views")
        threeviews.append("5.1M views")
        threeviews.append("2.6M views")
        threeviews.append("1.3M views")
        threeviews.append("2M views")
        threeviews.append("1.2M views")
        
        fourviews.append("264.9K views")
        fourviews.append("1.4M views")
        fourviews.append("321.2K views")
        fourviews.append("452.3K views")
        fourviews.append("115K views")
        fourviews.append("3.2M views")
        fourviews.append("6.2M views")
        fourviews.append("3.8M views")
        fourviews.append("1.1M views")
        fourviews.append("1.5M views")
        
        fiveviews.append("255.4K views")
        fiveviews.append("1.5M views")
        fiveviews.append("321K views")
        fiveviews.append("455K views")
        fiveviews.append("321K views")
        fiveviews.append("4.3M views")
        fiveviews.append("2.1M views")
        fiveviews.append("1.8M views")
        fiveviews.append("2.5M views")
        fiveviews.append("26K views")
        fiveviews.append("37K views")
        fiveviews.append("39K views")
        fiveviews.append("321.6K views")
        fiveviews.append("342.8K views")
        fiveviews.append("821K views")
        fiveviews.append("4.2M views")
        fiveviews.append("1.9M views")
        fiveviews.append("2.2M views")
        fiveviews.append("3.7M views")
        fiveviews.append("1M views")
        
        sixviews.append("450K views")
        sixviews.append("2.8M views")
        sixviews.append("321K views")
        sixviews.append("892K views")
        sixviews.append("801K views")
        sixviews.append("4M views")
        sixviews.append("1.2M views")
        sixviews.append("1M views")
        sixviews.append("2.4M views")
        sixviews.append("2.9M views")
        
        sevenviews.append("1.8M views")
        sevenviews.append("2.5M views")
        sevenviews.append("26K views")
        sevenviews.append("37K views")
        sevenviews.append("39K views")
        sevenviews.append("321.6K views")
        sevenviews.append("342.8K views")
        sevenviews.append("821K views")
        sevenviews.append("4.2M views")
        sevenviews.append("39K views")
        sevenviews.append("321.6K views")
        sevenviews.append("342.8K views")
        sevenviews.append("821K views")
        sevenviews.append("1.8M views")
        sevenviews.append("2.5M views")
        sevenviews.append("26K views")
        sevenviews.append("37K views")
        sevenviews.append("39K views")
        sevenviews.append("321.6K views")
        sevenviews.append("342.8K views")
        sevenviews.append("821K views")
        sevenviews.append("4.2M views")
        sevenviews.append("39K views")
        sevenviews.append("321.6K views")
        sevenviews.append("342.8K views")
        sevenviews.append("821K views")
        sevenviews.append("1.8M views")
        sevenviews.append("2.5M views")
        sevenviews.append("26K views")
        sevenviews.append("37K views")
        sevenviews.append("39K views")
        sevenviews.append("321.6K views")
        sevenviews.append("342.8K views")
        sevenviews.append("821K views")
        sevenviews.append("4.2M views")
        sevenviews.append("39K views")
        sevenviews.append("321.6K views")
        sevenviews.append("342.8K views")
        sevenviews.append("821K views")
        sevenviews.append("1.8M views")
        sevenviews.append("2.5M views")
        sevenviews.append("26K views")
        sevenviews.append("37K views")
        sevenviews.append("39K views")
        sevenviews.append("321.6K views")
        sevenviews.append("342.8K views")
        sevenviews.append("821K views")
        sevenviews.append("4.2M views")
        sevenviews.append("39K views")
        sevenviews.append("321.6K views")
        sevenviews.append("342.8K views")
        sevenviews.append("821K views")

        eightviews.append("377.9K views")
        eightviews.append("3.4M views")
        eightviews.append("933.6K views")
        eightviews.append("395.8K views")
        eightviews.append("82K views")
        eightviews.append("5.1M views")
        eightviews.append("2.6M views")
        eightviews.append("1.3M views")
        eightviews.append("2M views")
        eightviews.append("1.2M views")
        eightviews.append("1.3M views")
        eightviews.append("2M views")
        eightviews.append("1.2M views")
        
        nineviews.append("832K views")
        nineviews.append("3M views")
        nineviews.append("123K views")
        nineviews.append("23K views")
        nineviews.append("984K views")
        nineviews.append("4.1M views")
        nineviews.append("1.4M views")
        nineviews.append("3.8M views")
        nineviews.append("2M views")
        nineviews.append("1.2M views")
        nineviews.append("832K views")
        nineviews.append("3M views")
        nineviews.append("123K views")
        nineviews.append("23K views")
        nineviews.append("984K views")
        nineviews.append("4.1M views")
        nineviews.append("1.4M views")
        nineviews.append("3.8M views")
        nineviews.append("2M views")
        nineviews.append("1.2M views")
        nineviews.append("832K views")
        nineviews.append("3M views")
        nineviews.append("123K views")
        nineviews.append("23K views")
        nineviews.append("984K views")
        nineviews.append("4.1M views")
        nineviews.append("1.4M views")
        nineviews.append("23K views")
        nineviews.append("984K views")
        nineviews.append("4.1M views")
        nineviews.append("1.4M views")
        nineviews.append("3.8M views")
        nineviews.append("2M views")
        nineviews.append("1.2M views")
  
//        addstaticbooks()


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
    
    func loadgirlstuff() {
        
        psychologylabel.text = "For Diana"
        ninebookcovers.removeAll()
        nineids.removeAll()

        ninebookcovers.append(UIImage(named: "R10")!)
        ninebookcovers.append(UIImage(named: "R3")!)
        ninebookcovers.append(UIImage(named: "R2")!)
        ninebookcovers.append(UIImage(named: "PS25")!)
        ninebookcovers.append(UIImage(named: "MH7")!)
        ninebookcovers.append(UIImage(named: "MH2")!)
        ninebookcovers.append(UIImage(named: "M1")!)
        ninebookcovers.append(UIImage(named: "M5")!)
        ninebookcovers.append(UIImage(named: "M4")!)
  
        nineids.append("1")
        nineids.append("2")
        nineids.append("3")
        nineids.append("4")
        nineids.append("5")
        nineids.append("6")
        nineids.append("7")
        nineids.append("8")
        nineids.append("9")
        

        
        collectionView9.reloadData()
        
    }
    
    @IBAction func tapSeeMoreBM(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            self.performSegue(withIdentifier: "HomeToPurchase", sender: self)
            
        } else {
            
            selectedgenre = "Biography & Memoir"
            
            self.performSegue(withIdentifier: "DiscoverToSeeMore", sender: self)
        }
        
     
        
    }
    
    @IBAction func tapSeeMoreRF(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        FBSDKAppEvents.logEvent("For You Tapped")

        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            self.performSegue(withIdentifier: "HomeToPurchase", sender: self)
            
        } else {
            
            selectedgenre = "For You"
            
            
            self.performSegue(withIdentifier: "DiscoverToSeeMore", sender: self)
        }
        
       
        
    }
    
    @IBAction func tapSeeMoreHealth(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        FBSDKAppEvents.logEvent("Health, Fitness, & Dieting Tapped")

        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            self.performSegue(withIdentifier: "HomeToPurchase", sender: self)
            
        } else {
            
            selectedgenre = "Health, Fitness, & Dieting"
            
            
            self.performSegue(withIdentifier: "DiscoverToSeeMore", sender: self)
        }
        
  
        
    }
    
    @IBAction func tapSeeMoreB(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        FBSDKAppEvents.logEvent("Business & Investing Tapped")

        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            self.performSegue(withIdentifier: "HomeToPurchase", sender: self)
            
        } else {
            
            selectedgenre = "Business & Investing"
            
            
            self.performSegue(withIdentifier: "DiscoverToSeeMore", sender: self)
        }
        
      
        
    }
    
    @IBAction func tapSeeMoreSex(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        FBSDKAppEvents.logEvent("Sex & Relationships Tapped")

        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            self.performSegue(withIdentifier: "HomeToPurchase", sender: self)
            
        } else {
            
            selectedgenre = "Sex & Relationships"
            
            
            self.performSegue(withIdentifier: "DiscoverToSeeMore", sender: self)
        }
     
        
    }
    
    @IBAction func tapSeeMoreP(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        FBSDKAppEvents.logEvent("Productivity Tapped")

        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            self.performSegue(withIdentifier: "HomeToPurchase", sender: self)
            
        } else {
            
            selectedgenre = "Productivity"
            
            
            self.performSegue(withIdentifier: "DiscoverToSeeMore", sender: self)
        }
      
        
    }
    
    @IBAction func tapSeeMoreMH(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        FBSDKAppEvents.logEvent("Mental Health Tapped")

        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            self.performSegue(withIdentifier: "HomeToPurchase", sender: self)
            
        } else {
            
            selectedgenre = "Mental Health"
            
            
            self.performSegue(withIdentifier: "DiscoverToSeeMore", sender: self)
            
        }
        
     
        
    }
    
    @IBAction func tapSeeMorePS(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        FBSDKAppEvents.logEvent("Psychology Tapped")

        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            self.performSegue(withIdentifier: "HomeToPurchase", sender: self)
            
        } else {
            
            selectedgenre = "Psychology"
            
            
            self.performSegue(withIdentifier: "DiscoverToSeeMore", sender: self)
            
            
        }
        

    }
    
    @IBOutlet weak var collectionView1: UICollectionView!
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
                
            return onebookcovers.count

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
                                
                                return sevenids.count
                                
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
    
    @IBOutlet weak var mainviews: UILabel!
    var twoauthors = [String]()
    var twoviews = [String]()
    var twotitles = [String]()
    
    @IBOutlet weak var freebackground: UIImageView!
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Books", for: indexPath) as! BooksCollectionViewCell
        cell.bookcover.layer.cornerRadius = 10.0
        cell.bookcover.layer.masksToBounds = true
//        cell.bookauthor.alpha = 0
        cell.dark.layer.cornerRadius = 10.0
        cell.dark.layer.masksToBounds = true
        
        
        if purchased {
            
            cell.lockimage.alpha = 0

            
        } else {
            
            
            cell.lockimage.alpha = 0
            
        }
        
        
            if collectionView.tag == 9 {
                
                if ninebookcovers.count > indexPath.row {

                cell.bookcover.image = ninebookcovers[indexPath.row]
                
                hideloading()
                    
                }
                
            }
        
        if collectionView.tag == 1 {
            
            if onebookcovers.count > indexPath.row {
                
                cell.bookcover.layer.cornerRadius = 0.0
                cell.bookcover.layer.masksToBounds = false
                cell.dark.layer.cornerRadius = 0.0
                cell.dark.layer.masksToBounds = false
//                cell.bookauthor.text = "\(onebookinsights[oneids[indexPath.row]]!) views"
                cell.bookcover.image = onebookcovers[indexPath.row]
                cell.views.text = oneviews[indexPath.row]

                cell.lockimage.alpha = 0
                
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
                cell.views.text = twoviews[indexPath.row]
//                cell.author.text = twoauthors[indexPath.row]
//                cell.booktitle.text = twotitles[indexPath.row]
                
            }
            
        }
        
        if collectionView.tag == 3 {
            
            if threebookcovers.count > indexPath.row {
                cell.views.text = threeviews[indexPath.row]

                cell.bookcover.image = threebookcovers[indexPath.row]
                
            }
            
        }
        
        if collectionView.tag == 4 {
            
            if fourbookcovers.count > indexPath.row {
                cell.views.text = fourviews[indexPath.row]

                cell.bookcover.image = fourbookcovers[indexPath.row]
                
                
            }
            
        }
        
        if collectionView.tag == 5 {
            
            if fivebookcovers.count > indexPath.row {
                cell.views.text = fiveviews[indexPath.row]

                cell.bookcover.image = fivebookcovers[indexPath.row]
                
                
            }
            
        }
        
        if collectionView.tag == 6 {
            
            if sixbookcovers.count > indexPath.row {
                cell.views.text = sixviews[indexPath.row]

                cell.bookcover.image = sixbookcovers[indexPath.row]
                
                
            }
            
        }
        
        if collectionView.tag == 7 {
            
            if sevenbookcovers.count > indexPath.row {
                cell.views.text = sevenviews[indexPath.row]

                cell.bookcover.image = sevenbookcovers[indexPath.row]
                
                
            }
            
        }
        
        if collectionView.tag == 8 {
            
            if eightbookcovers.count > indexPath.row {
                cell.views.text = eightviews[indexPath.row]

                cell.bookcover.image = eightbookcovers[indexPath.row]
                
                
            }
            
        }
        
        if collectionView.tag == 9 {
            
            if ninebookcovers.count > indexPath.row {
                cell.views.text = nineviews[indexPath.row]
                
                cell.bookcover.image = ninebookcovers[indexPath.row]
                
                
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
//    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    
    func addstaticbooks() {
        
    selectedgenre = "Productivity"
        
    var counter2 = 7
        
        while counter2 < 35 {
    
//            ref?.child("AllBooks2").child(selectedgenre).child("\(counter2)").updateChildValues(["Author" : "Jordan B. Peterson", "BookID" : "\(counter2)", "Description" : "What does everyone in the modern world need to know? Renowned psychologist Jordan B. Peterson's answer to this most difficult of questions uniquely combines the hard-won truths of ancient tradition with the stunning revelations of cutting-edge scientific research.", "Genre" : "\(selectedgenre)", "Image" : "F\(counter2)", "Name" : "12 Rules for Life", "Completed" : "No", "Views" : "x"])
            
//    ref?.child("AllBooks2").child(selectedgenre).child("\(counter2)").updateChildValues([ "Views" : "\(sevenviews[counter2])"])

    ref?.child("AllBooks2").child(selectedgenre).child("\(counter2)").child("Summary").child("1").updateChildValues(["1" : "x", "2" : "x", "3" : "x", "4" : "x", "5" : "x", "6" : "x","7" : "x", "8" : "x","9" : "x","10" : "x","11" : "x", "12" : "x", "13" : "x", "14" : "x", "15" : "x", "16" : "x", "17" : "x", "18" : "x", "19" : "x", "20" : "x", "Title" : "x"])

            
            counter2 += 1
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
            if collectionView.tag == 1 {
                
                selectedbookid = oneids[indexPath.row]
                selectedimage = onebookcovers[indexPath.row]
                selectedviews = oneviews[indexPath.row]
                selectedgenre = "Top Sellers"
                FBSDKAppEvents.logEvent("Top Sellers Tapped")
                selectedimagename = "BS\(indexPath.row+1)"

                self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)

                
            } else {
                
                if collectionView.tag == 2 {

                    selectedbookid = twoids[indexPath.row]
                    selectedimage = twobookcovers[indexPath.row]
                    
                    selectedviews = twoviews[indexPath.row]
                    selectedgenre = "Biography & Memoir"
                    FBSDKAppEvents.logEvent("Biography Tapped")
                    selectedimagename = "M\(indexPath.row+1)"

                    self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                    
                } else {
                    
                    if collectionView.tag == 3 {
                        selectedbookid = threeids[indexPath.row]
       
                        selectedimage = threebookcovers[indexPath.row]
                     selectedgenre = "For You"
                        FBSDKAppEvents.logEvent("For You Tapped")
                        selectedimagename = "F\(indexPath.row+1)"

                        selectedviews = threeviews[indexPath.row]
                        self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                        
                    } else {
                        
                        if collectionView.tag == 4 {
                            
                            selectedbookid = fourids[indexPath.row]
                            selectedgenre = "Health, Fitness, & Dieting"
                            selectedimage = fourbookcovers[indexPath.row]
                     selectedviews = fourviews[indexPath.row]
                            FBSDKAppEvents.logEvent("Health, Fitness, & Dieting Tapped")
                            selectedimagename = "H\(indexPath.row+1)"

                            self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                            
                        } else {
                            
                            if collectionView.tag == 5 {
                                
                                selectedbookid = fiveids[indexPath.row]
                                selectedgenre = "Business & Investing"
                                selectedimage = fivebookcovers[indexPath.row]
       selectedviews = fiveviews[indexPath.row]
                                FBSDKAppEvents.logEvent("Business & Investing Tapped")
                                selectedimagename = "B\(indexPath.row+1)"
                                self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                
                            } else {
                                
                                if collectionView.tag == 6 {
                                    
                                    selectedbookid = sixids[indexPath.row]
                                    selectedimage = sixbookcovers[indexPath.row]
                                    selectedgenre = "Sex & Relationships"
                                    FBSDKAppEvents.logEvent("Sex & Relationships Tapped")
                                    selectedimagename = "S\(indexPath.row+1)"

                                    selectedviews = sixviews[indexPath.row]
                                    self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                    
                                } else {
                                    
                                    if collectionView.tag == 7 {
                                        
                                        selectedbookid = sevenids[indexPath.row]
 
                                        selectedimage = sevenbookcovers[indexPath.row]
                                        selectedgenre = "Productivity"
                                        FBSDKAppEvents.logEvent("Productivity Tapped")
                                        selectedimagename = "PR\(indexPath.row+1)"

                                        selectedviews = sevenviews[indexPath.row]
                                        self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                        
                                    } else {
                                        
                                        if collectionView.tag == 8 {
                                            
                                            selectedbookid = eightids[indexPath.row]
                                            selectedimage = eightbookcovers[indexPath.row]
                                            selectedgenre = "Mental Health"
                                            FBSDKAppEvents.logEvent("Mental Health Tapped")
                                            selectedimagename = "MH\(indexPath.row+1)"

                                            selectedviews = eightviews[indexPath.row]
                                            self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                            
                                        } else {
                                            
                                            if collectionView.tag == 9 {
                                                
                                                selectedbookid = nineids[indexPath.row]

                                                selectedimage = ninebookcovers[indexPath.row]
                                                selectedgenre = "Psychology"
                                                selectedviews = nineviews[indexPath.row]
                                                FBSDKAppEvents.logEvent("Psychology Tapped")
                                                selectedimagename = "PS\(indexPath.row+1)"
                                                if psychologylabel.text == "For Diana" {
                                                    
                                                    selectedgenre = "Diana"
                                                    
                                                }
                                                
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

var ninebooknames = [String]()
var ninebookauthors = [String]()
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

var oneviews = [String]()
var twoviews = [String]()
var threeviews = [String]()
var fourviews = [String]()
var fiveviews = [String]()
var sixviews = [String]()
var sevenviews = [String]()
var eightviews = [String]()
var nineviews = [String]()

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

var selectedimagename = String()
var selectedgenre = String()


