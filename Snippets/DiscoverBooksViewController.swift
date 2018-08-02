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
var onebookcovers = [String:UIImage]()
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
        
        FBSDKAppEvents.logEvent("Discover Viewed")
        activityIndicator.color = .white
        
        tryingtopurchase = false
        // Do any additional setup after loading the view.
        
        showloading()
        
        backgroundlabel.layer.cornerRadius = 5.0
        backgroundlabel.clipsToBounds = true
        

        

        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in

            var text = "Most Popular"
            
            categorylabel.text = text.uppercased()

            if bookids.count == 0 {
                
                queryforallbookids { () -> () in
                    
                    self.queryforbookinfo()
                }

                
            } else {
                
                
            }

            
            purchased = false
        
            tapsettings.alpha = 0
            tapfavorties.alpha = 0
            taphome.alpha = 0
            taplibrary.alpha = 0
            tapfilters.alpha = 0
//            tapcta.alpha = 1
            
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

            if bookids.count == 0 {
                
                queryforallbookids { () -> () in
                    
                    self.queryforbookinfo()
                }
                
                
            } else {
                
                
            }
            
//            tapfilters.alpha = 1
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

     
        onebookcovers.removeAll()
        onebookauthors.removeAll()
        onebooknames.removeAll()
        onebookdescriptions.removeAll()
        onebookurls.removeAll()
        onebookinsights.removeAll()
        twobookcovers.removeAll()
        twobookauthors.removeAll()
        twobooknames.removeAll()
        twobookdescriptions.removeAll()
        twobookurls.removeAll()
        twobookinsights.removeAll()
        threebookcovers.removeAll()
        threebookauthors.removeAll()
        threebooknames.removeAll()
        threebookdescriptions.removeAll()
        threebookurls.removeAll()
        threebookinsights.removeAll()
        fourbookcovers.removeAll()
        fourbookauthors.removeAll()
        fourbooknames.removeAll()
        fourbookdescriptions.removeAll()
        fourbookurls.removeAll()
        fourbookinsights.removeAll()
        fivebookcovers.removeAll()
        fivebookauthors.removeAll()
        fivebooknames.removeAll()
        fivebookdescriptions.removeAll()
        fivebookurls.removeAll()
        fivebookinsights.removeAll()
        sixbookcovers.removeAll()
        sixbookauthors.removeAll()
        sixbooknames.removeAll()
        sixbookdescriptions.removeAll()
        sixbookurls.removeAll()
        sixbookinsights.removeAll()
        sevenbookcovers.removeAll()
        sevenbookauthors.removeAll()
        sevenbooknames.removeAll()
        sevenbookdescriptions.removeAll()
        sevenbookurls.removeAll()
        sevenbookinsights.removeAll()
        eightbookcovers.removeAll()
        eightbookauthors.removeAll()
        eightbooknames.removeAll()
        eightbookdescriptions.removeAll()
        eightbookurls.removeAll()
        eightbookinsights.removeAll()
        ninebookcovers.removeAll()
        ninebookauthors.removeAll()
        ninebooknames.removeAll()
        ninebookdescriptions.removeAll()
        ninebookurls.removeAll()
        ninebookinsights.removeAll()
        oneids.removeAll()
        twoids.removeAll()
        threeids.removeAll()
        fourids.removeAll()
        fiveids.removeAll()
        sixids.removeAll()
        sevenids.removeAll()
        eightids.removeAll()
        nineids.removeAll()
    
        
        ref?.child("AllBooks1").observeSingleEvent(of: .value, with: { (snapshot) in
            
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
        

        
        ref?.child("AllBooks1").observeSingleEvent(of: .value, with: { (snapshot) in
            
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
                                
//                                self.collectionView1.reloadData()
                                
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

                ref?.child("AllBooks1").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    var value = snapshot.value as? NSDictionary
                    
                    if var selectedgenre = value?["Genre"] as? String {
                        
                        if selectedgenre == "Most Popular" {
                            
                            
                            oneids.append(each)
                            var author = value?["Author"] as! String
                            onebookauthors[each] = author
                            var name = value?["Name"] as! String
                            onebooknames[each] = name
                            var description = value?["Description"] as! String
                            onebookdescriptions[each] = description
                            var insight = value?["Insights"] as! String
                            onebookinsights[each] = insight
                            
                                                                    functioncounter += 1

                            if var productimagee = value?["Image"] as? String {
                                
                                onebookurls[each] = productimagee
                                
                                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                                    
                                    let url = URL(string: productimagee)
                                    
                                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                    
                                    if data != nil {
                                        
                                        let productphoto = UIImage(data: (data)!)
                                        
                                        //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                                        let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                                        
                                        onebookcovers[each] = productphoto
                                        
//                                        functioncounter += 1
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
//                                functioncounter += 1
                                
                            }
                            
                        }
                            
                        
                        
                        if selectedgenre == "For You" {
                            
                            
                            twoids.append(each)
                            var author = value?["Author"] as! String
                            twobookauthors[each] = author
                            var name = value?["Name"] as! String
                            twobooknames[each] = name
                            var description = value?["Description"] as! String
                            twobookdescriptions[each] = description
                            var insight = value?["Insights"] as! String
                            twobookinsights[each] = insight
                            functioncounter += 1

                            if var productimagee = value?["Image"] as? String {
                                
                                twobookurls[each] = productimagee
                                
                                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                                    
                                    let url = URL(string: productimagee)
                                    
                                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                    
                                    if data != nil {
                                        
                                        let productphoto = UIImage(data: (data)!)
                                        
                                        //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                                        let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                                        
                                        twobookcovers[each] = productphoto
                                        
//                                        functioncounter += 1
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
//                                functioncounter += 1
                                
                            }
                            
                        }
                    
                        
                        if selectedgenre == "Personal Growth & Self Improvement" {
                            
                            
                            threeids.append(each)
                            var author = value?["Author"] as! String
                            threebookauthors[each] = author
                            var name = value?["Name"] as! String
                            threebooknames[each] = name
                            var description = value?["Description"] as! String
                            threebookdescriptions[each] = description
                            var insight = value?["Insights"] as! String
                            threebookinsights[each] = insight
                            functioncounter += 1

                            if var productimagee = value?["Image"] as? String {
                                
                                threebookurls[each] = productimagee
                                
                                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                                    
                                    let url = URL(string: productimagee)
                                    
                                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                    
                                    if data != nil {
                                        
                                        let productphoto = UIImage(data: (data)!)
                                        
                                        //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                                        let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                                        
                                        threebookcovers[each] = productphoto
                                        
//                                        functioncounter += 1
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
//                                functioncounter += 1
                                
                            }
                            
                        }
                            
                    
                        
                        if selectedgenre == "Psychology" {
                            
                            
                            fourids.append(each)
                            var author = value?["Author"] as! String
                            fourbookauthors[each] = author
                            var name = value?["Name"] as! String
                            fourbooknames[each] = name
                            var description = value?["Description"] as! String
                            fourbookdescriptions[each] = description
                            var insight = value?["Insights"] as! String
                            fourbookinsights[each] = insight
                            functioncounter += 1

                            if var productimagee = value?["Image"] as? String {
                                
                                fourbookurls[each] = productimagee
                                
                                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                                    
                                    let url = URL(string: productimagee)
                                    
                                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                    
                                    if data != nil {
                                        
                                        let productphoto = UIImage(data: (data)!)
                                        
                                        //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                                        let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                                        
                                        fourbookcovers[each] = productphoto
                                        
//                                        functioncounter += 1
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
//                                functioncounter += 1
                                
                            }
                            
                        }
                            
        
                        
                        if selectedgenre == "Productivity & Time Management" {
                            
                            
                            fiveids.append(each)
                            var author = value?["Author"] as! String
                            fivebookauthors[each] = author
                            var name = value?["Name"] as! String
                            fivebooknames[each] = name
                            var description = value?["Description"] as! String
                            fivebookdescriptions[each] = description
                            var insight = value?["Insights"] as! String
                            fivebookinsights[each] = insight
                            functioncounter += 1

                            if var productimagee = value?["Image"] as? String {
                                
                                fivebookurls[each] = productimagee
                                
                                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                                    
                                    let url = URL(string: productimagee)
                                    
                                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                    
                                    if data != nil {
                                        
                                        let productphoto = UIImage(data: (data)!)
                                        
                                        //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                                        let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                                        
                                        fivebookcovers[each] = productphoto
                                        
//                                        functioncounter += 1
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
//                                functioncounter += 1
                                
                            }
                            
                            
                        }
                            
    
                        
                        if selectedgenre == "Mindfulness & Happiness" {
                            
                            
                            sixids.append(each)
                            var author = value?["Author"] as! String
                            sixbookauthors[each] = author
                            var name = value?["Name"] as! String
                            sixbooknames[each] = name
                            var description = value?["Description"] as! String
                            sixbookdescriptions[each] = description
                            var insight = value?["Insights"] as! String
                            sixbookinsights[each] = insight
                            functioncounter += 1

                            if var productimagee = value?["Image"] as? String {
                                
                                sixbookurls[each] = productimagee
                                
                                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                                    
                                    let url = URL(string: productimagee)
                                    
                                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                    
                                    if data != nil {
                                        
                                        let productphoto = UIImage(data: (data)!)
                                        
                                        //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                                        let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                                        
                                        sixbookcovers[each] = productphoto
                                        
//                                        functioncounter += 1
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
//                                functioncounter += 1
                                
                            }
                        
                        }
                            

                        
                        if selectedgenre == "Health & Fitness" {
                            
                            
                            sevenids.append(each)
                            var author = value?["Author"] as! String
                            sevenbookauthors[each] = author
                            var name = value?["Name"] as! String
                            sevenbooknames[each] = name
                            var description = value?["Description"] as! String
                            sevenbookdescriptions[each] = description
                            var insight = value?["Insights"] as! String
                            sevenbookinsights[each] = insight
                            functioncounter += 1

                            if var productimagee = value?["Image"] as? String {
                                
                                sevenbookurls[each] = productimagee
                                
                                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                                    
                                    let url = URL(string: productimagee)
                                    
                                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                    
                                    if data != nil {
                                        
                                        let productphoto = UIImage(data: (data)!)
                                        
                                        //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                                        let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                                        
                                        sevenbookcovers[each] = productphoto
                                        
//                                        functioncounter += 1
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
//                                functioncounter += 1
                                
                            }
    
                        }

                        
                        
                        if selectedgenre == "Sex & Relationships" {
                            
                            
                            eightids.append(each)
                            var author = value?["Author"] as! String
                            eightbookauthors[each] = author
                            var name = value?["Name"] as! String
                            eightbooknames[each] = name
                            var description = value?["Description"] as! String
                            eightbookdescriptions[each] = description
                            var insight = value?["Insights"] as! String
                            eightbookinsights[each] = insight
                            functioncounter += 1

                            if var productimagee = value?["Image"] as? String {
                                
                                eightbookurls[each] = productimagee
                                
                                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                                    
                                    let url = URL(string: productimagee)
                                    
                                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                    
                                    if data != nil {
                                        
                                        let productphoto = UIImage(data: (data)!)
                                        
                                        //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                                        let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                                        
                                        eightbookcovers[each] = productphoto
                                        
//                                        functioncounter += 1
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
//                                functioncounter += 1
                                
                            }
                        
                        }

                        
                        
                        if selectedgenre == "Money & Investments" {
                            
                            nineids.append(each)
                            var author = value?["Author"] as! String
                            ninebookauthors[each] = author
                            var name = value?["Name"] as! String
                            ninebooknames[each] = name
                            var description = value?["Description"] as! String
                            ninebookdescriptions[each] = description
                            var insight = value?["Insights"] as! String
                            ninebookinsights[each] = insight
                            functioncounter += 1

                            if var productimagee = value?["Image"] as? String {
                                
                                ninebookurls[each] = productimagee
                                
                                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                                    
                                    let url = URL(string: productimagee)
                                    
                                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                    
                                    if data != nil {
                                        
                                        let productphoto = UIImage(data: (data)!)
                                        
                                        //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                                        let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                                        
                                        ninebookcovers[each] = productphoto
                                        
//                                        functioncounter += 1
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
//                                functioncounter += 1
                                
                            }
                            

                        }


                    if functioncounter == 90 {

                        self.collectionView1.reloadData()
                        self.collectionView2.reloadData()
                        self.collectionView3.reloadData()
                        self.collectionView4.reloadData()
                        self.collectionView5.reloadData()
                        self.collectionView6.reloadData()
                        self.collectionView7.reloadData()
                        self.collectionView8.reloadData()
                        self.collectionView9.reloadData()
                        
//                        self.collectionView.reloadData()
                        
                    }
                }
                    
                })
                

            }
            
    }
    

  
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
            if collectionView.tag == 1 {
                
            return onebooknames.count

            } else {
                
                if collectionView.tag == 2 {
                    
                    return twobooknames.count
                    
                } else {
                    
                    if collectionView.tag == 3 {
                        
                        return threebooknames.count
                        
                    } else {
                        
                        if collectionView.tag == 4 {
                            
                            return fourbooknames.count
                            
                        } else {
                            
                            if collectionView.tag == 5 {
                                
                                return fivebooknames.count
                                
                            } else {
                                
                                if collectionView.tag == 6 {
                                    
                                    return sixbooknames.count
                                    
                                } else {
                                    
                                    if collectionView.tag == 7 {
                                        
                                        return sevenbooknames.count
                                        
                                    } else {
                                        
                                        if collectionView.tag == 8 {
                                            
                                            return eightbooknames.count
                                            
                                        } else {
                                            
                                            if collectionView.tag == 9 {
                                                
                                                return ninebooknames.count
                                                
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
        
        
            if collectionView.tag == 9 {
                
                if ninebookinsights.count > indexPath.row {

                cell.bookauthor.text = "\(ninebookinsights[nineids[indexPath.row]]!) views"
                cell.bookcover.image = ninebookcovers[nineids[indexPath.row]]
                cell.booktitle.text = ninebooknames[nineids[indexPath.row]]
                
                hideloading()
                    
                }
                
            }
        
        if collectionView.tag == 1 {
            
            if onebookinsights.count > indexPath.row {
                
                cell.bookauthor.text = "\(onebookinsights[oneids[indexPath.row]]!) views"
                cell.bookcover.image = onebookcovers[oneids[indexPath.row]]
                cell.booktitle.text = onebooknames[oneids[indexPath.row]]
                
                    if indexPath.row == 0 {
                        
                        cell.lockimage.image = UIImage(named: "Tester")
                        
                    } else {
                        
                        
                    }
                
            }
            
        }
        
        if collectionView.tag == 2 {
            
            if twobookinsights.count > indexPath.row {
                
                cell.bookauthor.text = "\(twobookinsights[twoids[indexPath.row]]!) views"
                cell.bookcover.image = twobookcovers[twoids[indexPath.row]]
                cell.booktitle.text = twobooknames[twoids[indexPath.row]]
                
                
            }
            
        }
        
        if collectionView.tag == 3 {
            
            if threebookinsights.count > indexPath.row {
                
                cell.bookauthor.text = "\(threebookinsights[threeids[indexPath.row]]!) views"
                cell.bookcover.image = threebookcovers[threeids[indexPath.row]]
                cell.booktitle.text = threebooknames[threeids[indexPath.row]]
                
            }
            
        }
        
        if collectionView.tag == 4 {
            
            if fourbookinsights.count > indexPath.row {
                
                cell.bookauthor.text = "\(fourbookinsights[fourids[indexPath.row]]!) views"
                cell.bookcover.image = fourbookcovers[fourids[indexPath.row]]
                cell.booktitle.text = fourbooknames[fourids[indexPath.row]]
                
                
            }
            
        }
        
        if collectionView.tag == 5 {
            
            if fivebookinsights.count > indexPath.row {
                
                cell.bookauthor.text = "\(fivebookinsights[fiveids[indexPath.row]]!) views"
                cell.bookcover.image = fivebookcovers[fiveids[indexPath.row]]
                cell.booktitle.text = fivebooknames[fiveids[indexPath.row]]
                
                
            }
            
        }
        
        if collectionView.tag == 6 {
            
            if sixbookinsights.count > indexPath.row {
                
                cell.bookauthor.text = "\(sixbookinsights[sixids[indexPath.row]]!) views"
                cell.bookcover.image = sixbookcovers[sixids[indexPath.row]]
                cell.booktitle.text = sixbooknames[sixids[indexPath.row]]
                
                
            }
            
        }
        
        if collectionView.tag == 7 {
            
            if sevenbookinsights.count > indexPath.row {
                
                cell.bookauthor.text = "\(sevenbookinsights[sevenids[indexPath.row]]!) views"
                cell.bookcover.image = sevenbookcovers[sevenids[indexPath.row]]
                cell.booktitle.text = sevenbooknames[sevenids[indexPath.row]]
                
                
            }
            
        }
        
        if collectionView.tag == 8 {
            
            if eightbookinsights.count > indexPath.row {
                
                cell.bookauthor.text = "\(eightbookinsights[eightids[indexPath.row]]!) views"
                cell.bookcover.image = eightbookcovers[eightids[indexPath.row]]
                cell.booktitle.text = eightbooknames[eightids[indexPath.row]]
                
                
            }
            
        }
        

                

            
            if bookcompleted[bookids[indexPath.row]] == "True" {
                
                cell.lockimage.alpha = 0

            } else {
                
                cell.lockimage.alpha = 1

                }
        
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
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
            if collectionView.tag == 1 {
                
                selectedbookid = oneids[indexPath.row]
                selectedtitle = onebooknames[oneids[indexPath.row]]!
                selectedauthor = onebookauthors[oneids[indexPath.row]]!
                selectedimage = onebookcovers[oneids[indexPath.row]]!
                selecteddescription = onebookdescriptions[oneids[indexPath.row]]!
                selectedurl = onebookurls[oneids[indexPath.row]]!
                
                if indexPath.row == 0 {
                    
                    testerselected = true
                    
                } else {
                    
                    testerselected = false
                }
                
                self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                
            } else {
                
                if collectionView.tag == 2 {
                    
                    selectedbookid = twoids[indexPath.row]
                    selectedtitle = twobooknames[twoids[indexPath.row]]!
                    selectedauthor = twobookauthors[twoids[indexPath.row]]!
                    selectedimage = twobookcovers[twoids[indexPath.row]]!
                    selecteddescription = twobookdescriptions[twoids[indexPath.row]]!
                    selectedurl = twobookurls[twoids[indexPath.row]]!
                    
                    self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                    
                } else {
                    
                    if collectionView.tag == 3 {
                        selectedbookid = threeids[indexPath.row]
                        selectedtitle = threebooknames[threeids[indexPath.row]]!
                        selectedauthor = threebookauthors[threeids[indexPath.row]]!
                        selectedimage = threebookcovers[threeids[indexPath.row]]!
                        selecteddescription = threebookdescriptions[threeids[indexPath.row]]!
                        selectedurl = threebookurls[threeids[indexPath.row]]!
                        
                        self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                        
                    } else {
                        
                        if collectionView.tag == 4 {
                            
                            selectedbookid = fourids[indexPath.row]
                            selectedtitle = fourbooknames[fourids[indexPath.row]]!
                            selectedauthor = fourbookauthors[fourids[indexPath.row]]!
                            selectedimage = fourbookcovers[fourids[indexPath.row]]!
                            selecteddescription = fourbookdescriptions[fourids[indexPath.row]]!
                            selectedurl = fourbookurls[fourids[indexPath.row]]!
                            
                            self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                            
                        } else {
                            
                            if collectionView.tag == 5 {
                                
                                selectedbookid = fiveids[indexPath.row]
                                selectedtitle = fivebooknames[fiveids[indexPath.row]]!
                                selectedauthor = fivebookauthors[fiveids[indexPath.row]]!
                                selectedimage = fivebookcovers[fiveids[indexPath.row]]!
                                selecteddescription = fivebookdescriptions[fiveids[indexPath.row]]!
                                selectedurl = fivebookurls[fiveids[indexPath.row]]!
                                
                                self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                
                            } else {
                                
                                if collectionView.tag == 6 {
                                    
                                    selectedbookid = sixids[indexPath.row]
                                    selectedtitle = sixbooknames[sixids[indexPath.row]]!
                                    selectedauthor = sixbookauthors[sixids[indexPath.row]]!
                                    selectedimage = sixbookcovers[sixids[indexPath.row]]!
                                    selecteddescription = sixbookdescriptions[sixids[indexPath.row]]!
                                    selectedurl = sixbookurls[sixids[indexPath.row]]!
                                    
                                    self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                    
                                } else {
                                    
                                    if collectionView.tag == 7 {
                                        
                                        selectedbookid = sevenids[indexPath.row]
                                        selectedtitle = sevenbooknames[sevenids[indexPath.row]]!
                                        selectedauthor = sevenbookauthors[sevenids[indexPath.row]]!
                                        selectedimage = sevenbookcovers[sevenids[indexPath.row]]!
                                        selecteddescription = sevenbookdescriptions[sevenids[indexPath.row]]!
                                        selectedurl = sevenbookurls[sevenids[indexPath.row]]!
                                        
                                        self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                        
                                    } else {
                                        
                                        if collectionView.tag == 8 {
                                            
                                            selectedbookid = eightids[indexPath.row]
                                            selectedtitle = eightbooknames[eightids[indexPath.row]]!
                                            selectedauthor = eightbookauthors[eightids[indexPath.row]]!
                                            selectedimage = eightbookcovers[eightids[indexPath.row]]!
                                            selecteddescription = eightbookdescriptions[eightids[indexPath.row]]!
                                            selectedurl = eightbookurls[eightids[indexPath.row]]!
                                            
                                            self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                                            
                                        } else {
                                            
                                            if collectionView.tag == 9 {
                                                
                                                selectedbookid = nineids[indexPath.row]
                                                selectedtitle = ninebooknames[nineids[indexPath.row]]!
                                                selectedauthor = ninebookauthors[nineids[indexPath.row]]!
                                                selectedimage = ninebookcovers[nineids[indexPath.row]]!
                                                selecteddescription = ninebookdescriptions[nineids[indexPath.row]]!
                                                selectedurl = ninebookurls[nineids[indexPath.row]]!
                                                
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
var twobookcovers = [String:UIImage]()
var twobookdescriptions = [String:String]()
var twobookurls = [String:String]()
var twobookcompleted = [String:String]()
var twobookinsights = [String:String]()

var threebooknames = [String:String]()
var threebookauthors = [String:String]()
var threebookcovers = [String:UIImage]()
var threebookdescriptions = [String:String]()
var threebookurls = [String:String]()
var threebookcompleted = [String:String]()
var threebookinsights = [String:String]()

var fourbooknames = [String:String]()
var fourbookauthors = [String:String]()
var fourbookcovers = [String:UIImage]()
var fourbookdescriptions = [String:String]()
var fourbookurls = [String:String]()
var fourbookcompleted = [String:String]()
var fourbookinsights = [String:String]()

var fivebooknames = [String:String]()
var fivebookauthors = [String:String]()
var fivebookcovers = [String:UIImage]()
var fivebookdescriptions = [String:String]()
var fivebookurls = [String:String]()
var fivebookcompleted = [String:String]()
var fivebookinsights = [String:String]()

var sixbooknames = [String:String]()
var sixbookauthors = [String:String]()
var sixbookcovers = [String:UIImage]()
var sixbookdescriptions = [String:String]()
var sixbookurls = [String:String]()
var sixbookcompleted = [String:String]()
var sixbookinsights = [String:String]()

var sevenbooknames = [String:String]()
var sevenbookauthors = [String:String]()
var sevenbookcovers = [String:UIImage]()
var sevenbookdescriptions = [String:String]()
var sevenbookurls = [String:String]()
var sevenbookcompleted = [String:String]()
var sevenbookinsights = [String:String]()

var eightbooknames = [String:String]()
var eightbookauthors = [String:String]()
var eightbookcovers = [String:UIImage]()
var eightbookdescriptions = [String:String]()
var eightbookurls = [String:String]()
var eightbookcompleted = [String:String]()
var eightbookinsights = [String:String]()

var ninebooknames = [String:String]()
var ninebookauthors = [String:String]()
var ninebookcovers = [String:UIImage]()
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
