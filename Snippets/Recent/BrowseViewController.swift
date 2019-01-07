//
//  BrowseViewController.swift
//  
//
//  Created by Alek Matthiessen on 10/20/18.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

var genres = [String]()
class BrowseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {

    var counter = 0
    @IBOutlet weak var tapback: UIButton!
    @IBOutlet weak var tapbuton: UIButton!
    @IBAction func tapBack(_ sender: Any) {
        
        collectionView.alpha = 0
        
     
        if counter > 1 {
            
            tapbuton.alpha = 1
            counter -= 1
            
            tapgenre.slideInFromLeft()
            
            tapgenre.text = genres[counter]
            selectedgenre = genres[counter]
            activityIndicator.startAnimating()
            activityIndicator.alpha = 1
            activityIndicator.color = mygreen
            
            selectedgenreshortner()
            
            queryforids { () -> () in
                
                self.queryforreviewinfo()
                
            }
            
            tapbuton.alpha = 0.25
            
        } else {
            
            counter -= 1
            
            tapgenre.slideInFromLeft()
            
            tapgenre.text = genres[counter]
            selectedgenre = genres[counter]
            activityIndicator.startAnimating()
            activityIndicator.alpha = 1
            activityIndicator.color = mygreen
            
            selectedgenreshortner()
            
            queryforids { () -> () in
                
                self.queryforreviewinfo()
                
            }
            
            tapback.alpha = 0
            
        }
        
    }
    
    @IBAction func tapGenre(_ sender: Any) {
        
        collectionView.alpha = 0
        
        if counter < genres.count-1 {
            
            tapbuton.alpha = 0.25
            counter += 1
            
            tapgenre.slideInFromRight()
            
            tapgenre.text = genres[counter]
            selectedgenre = genres[counter]
            activityIndicator.startAnimating()
            activityIndicator.alpha = 1
            activityIndicator.color = mygreen
     
            selectedgenreshortner()
            queryforids { () -> () in
                
                self.queryforreviewinfo()
                
            }
            
            tapback.alpha = 0.25
            
        } else {
            
            
            
            tapbuton.alpha = 0
            
        }
    }
    @IBOutlet weak var tapgenre: UILabel!
    @IBOutlet weak var tapselectedgenre: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var swipecounter = Int()
    
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    
    @objc func swipeR() {
        
        
        swipecounter += 1
        selectedindex = swipecounter

        collectionView2.reloadData()

    }
    
    @objc func swipeL() {
        
        swipecounter -= 1
        selectedindex = swipecounter

        collectionView2.reloadData()
        
    }
 var intdayofweek = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        loadviews()
        ref = Database.database().reference()

        addstaticbooks()
        genres.removeAll()
        genres.append("Today's Picks")
        genres.append("Biography & Memoir")
        genres.append("Health, Fitness, & Dieting")
        genres.append("Business & Investing")
        genres.append("Sex & Relationships")
        genres.append("Productivity")
        genres.append("Mental Health")
        
        collectionView2.reloadData()
        
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        activityIndicator.color = mygreen
        selectedindex = 0
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
        dayofmonth = dateFormatter.string(from: now)
        intdayofweek = Int(dayofmonth)!
//        dayofmonth = "29"

        var screenSize = collectionView.bounds
        var screenWidth = screenSize.width
        var screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/1.2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        
        queryfortodayspicks()
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
        
            purchased = false
            
        } else {
            
            uid = (Auth.auth().currentUser?.uid)!

            purchased = true
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        collectionView.alpha = 0
        
        var functioncounter = 0
        
        seemoreids.removeAll()
        seemoreimages.removeAll()
        seemoretitles.removeAll()
        seemoreauthors.removeAll()
        seemoreimagenames.removeAll()
        
        
        ref?.child("AllBooks1").child(selectedgenre).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    if ids != "Title" {
                        
                        seemoreimages[ids] = UIImage(named: "\(abbreviation)\(ids)")

                        seemoreids.append(ids)
                        
                    }
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        self.collectionView.alpha = 1
                        self.collectionView.reloadData()
                        
                        
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
    }
    
    func selectedgenreshortner() {
        
        if selectedgenre == "Biography & Memoir" {
            
            abbreviation = "M"
        }
        
        if selectedgenre == "For You" {
            
            abbreviation = "F"
        }
        
        if selectedgenre == "Health, Fitness, & Dieting" {
            
            abbreviation = "H"
        }
        
        if selectedgenre == "Business & Investing" {
            
            abbreviation = "B"
        }
        
        if selectedgenre == "Sex & Relationships" {
            
            abbreviation = "S"
        }
        
        if selectedgenre == "Productivity" {
            
            abbreviation = "PR"
        }
        
        if selectedgenre == "Mental Health" {
            
            abbreviation = "MH"
        }
        
        if selectedgenre == "Psychology" {
            
            abbreviation = "PS"
        }
        
    }
    
    func queryforreviewinfo() {
        
        var functioncounter = 0
        
        for each in seemoreids {
            
            
            ref?.child("AllBooks1").child(selectedgenre).child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
                
                if var author2 = value?["Author"] as? String {
                    seemoreauthors[each] = author2
                    
                }
                if var name = value?["Name"] as? String {
                    seemoretitles[each] = name
                    
                }
                
                if var views = value?["Views"] as? String {
                    seemoreviews[each] = views
                    
                }
                
                seemoreimages[each] = UIImage(named: "\(abbreviation)\(each)")
                
                seemoreimagenames[each] = "\(abbreviation)\(each)"
                
                //        ref?.child("AllBooks1").child(selectedgenre).child(each).updateChildValues(["Views" : nineviews[functioncounter]])
                
                
                functioncounter += 1
                //
                //            if var productimagee = value?["Image"] as? String {
                //
                //
                //                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                //
                //                    let url = URL(string: productimagee)
                //
                //                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                //
                //                    if data != nil {
                //
                //                        let productphoto = UIImage(data: (data)!)
                //
                //                        //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                //                        let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                //
                //                        if productphoto == nil {
                //
                //                            seemoreimages[each] = UIImage(named: "StockPhoto")
                //                        } else {
                //
                //                            seemoreimages[each] = productphoto!
                //
                //                        }
                //
                //
                //                        functioncounter += 1
                //
                //
                //                    }
                //
                
                //                }
                //            }
                //
                
                print(functioncounter)
                
                
                
                if functioncounter == seemoreids.count {
                 
                    self.collectionView.reloadData()
                }
                
                
            })
            
        }
    }
    
    var dayofmonth = String()
    
    func addstaticbooks() {
        
        selectedgenre = "Sex & Relationships"
        
        var counter2 = 7
        
        while counter2 < 12 {
            
                        ref?.child("AllBooks1").child(selectedgenre).child("\(counter2)").updateChildValues(["Author" : "Jordan B. Peterson", "BookID" : "\(counter2)", "Description" : "What does everyone in the modern world need to know? Renowned psychologist Jordan B. Peterson's answer to this most difficult of questions uniquely combines the hard-won truths of ancient tradition with the stunning revelations of cutting-edge scientific research.", "Genre" : "\(selectedgenre)", "Image" : "F\(counter2)", "Name" : "12 Rules for Life", "Completed" : "No", "Views" : "x"])
            
            //    ref?.child("AllBooks2").child(selectedgenre).child("\(counter2)").updateChildValues([ "Views" : "\(nineviews[counter2])"])
            
            ref?.child("AllBooks1").child(selectedgenre).child("\(counter2)").child("Summary").child("1").updateChildValues(["1" : "x", "2" : "x", "3" : "x", "4" : "x", "5" : "x", "6" : "x","7" : "x", "8" : "x","9" : "x","10" : "x","11" : "x", "12" : "x", "13" : "x", "14" : "x", "15" : "x", "16" : "x", "17" : "x", "18" : "x", "19" : "x", "20" : "x", "Title" : "x"])
            
            
            counter2 += 1
            
        }
        
        
    }
    func queryfortodayspicks() {
        
        var functioncounter = 0
        seemoreids.removeAll()
        seemoreimages.removeAll()
        seemoretitles.removeAll()
        seemoreauthors.removeAll()
        seemoreimagenames.removeAll()
        
        for each in genres {
            
            if each == "Today's Picks" {
                
                
            } else {
            
            
            ref?.child("AllBooks1").child(each).child(dayofmonth).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
                if var author2 = value?["Author"] as? String {
                    seemoreauthors[each] = author2
                    
                }
                if var name = value?["Name"] as? String {
                    seemoretitles[each] = name
                    
                }
                
                if var views = value?["Views"] as? String {
                    seemoreviews[each] = views
                    
                }
                
                if each == "Biography & Memoir" {
                    
                    abbreviation = "M"
                    seemoreimages[each] = UIImage(named: "\(abbreviation)\(self.dayofmonth)")
                    
                    seemoreimagenames[each] = "\(abbreviation)\(self.dayofmonth)"
                    functioncounter += 1

                }
            
                
                if each == "Health, Fitness, & Dieting" {
                    
                    abbreviation = "H"
                    seemoreimages[each] = UIImage(named: "\(abbreviation)\(self.dayofmonth)")
                    
                    seemoreimagenames[each] = "\(abbreviation)\(self.dayofmonth)"
                    functioncounter += 1

                }
                
                if each == "Business & Investing" {
                    
                    abbreviation = "B"
                    seemoreimages[each] = UIImage(named: "\(abbreviation)\(self.dayofmonth)")
                    
                    seemoreimagenames[each] = "\(abbreviation)\(self.dayofmonth)"
                    functioncounter += 1

                }
                
                if each == "Sex & Relationships" {
                    
                    abbreviation = "S"
                    seemoreimages[each] = UIImage(named: "\(abbreviation)\(self.dayofmonth)")
                    
                    seemoreimagenames[each] = "\(abbreviation)\(self.dayofmonth)"
                    functioncounter += 1

                }
                
                if each == "Productivity" {
                    
                    abbreviation = "PR"
                    seemoreimages[each] = UIImage(named: "\(abbreviation)\(self.dayofmonth)")
                    
                    seemoreimagenames[each] = "\(abbreviation)\(self.dayofmonth)"
                    functioncounter += 1

                }
                
                if each == "Mental Health" {
                    
                    abbreviation = "MH"
                    seemoreimages[each] = UIImage(named: "\(abbreviation)\(self.dayofmonth)")
                    
                    seemoreimagenames[each] = "\(abbreviation)\(self.dayofmonth)"
                    functioncounter += 1

                }
                
                if selectedgenre == "Psychology" {
                    
                    abbreviation = "PS"
                    seemoreimages[each] = UIImage(named: "\(abbreviation)\(self.dayofmonth)")
                    
                    seemoreimagenames[each] = "\(abbreviation)\(self.dayofmonth)"
                    functioncounter += 1

                }
                

                
                
                print(functioncounter)
                print(each)
                
                if functioncounter == genres.count-1 {
                    seemoreids = genres
                    var index3 = seemoreids.firstIndex(of: "Today's Picks")
                    seemoreids.remove(at: index3!)
                    seemoreids.shuffle()
                    
                    self.collectionView.reloadData()
                    self.collectionView2.reloadData()
                }
                
                
            })
                
            }
            
        }
    }
    
    func loadviews() {
        
        nineviews.append("233K views")
        nineviews.append("492K views")
        nineviews.append("432K views")
        nineviews.append("589K views")
        nineviews.append("2.4M views")
        nineviews.append("2M views")
        nineviews.append("1.3M views")
        nineviews.append("1.9M views")
        nineviews.append("887K views")
        nineviews.append("145K views")
        
        nineviews.append("343K views")
        nineviews.append("466.9K views")
        nineviews.append("957.6K views")
        nineviews.append("377.9K views")
        nineviews.append("3.4M views")
        nineviews.append("2.1M views")
        nineviews.append("1.6M views")
        nineviews.append("1.2M views")
        nineviews.append("87K views")
        nineviews.append("123.5K views")
        
        nineviews.append("377.9K views")
        nineviews.append("3.4M views")
        nineviews.append("933.6K views")
        nineviews.append("395.8K views")
        nineviews.append("82K views")
        nineviews.append("5.1M views")
        nineviews.append("2.6M views")
        nineviews.append("1.3M views")
        nineviews.append("2M views")
        nineviews.append("1.2M views")
        
        nineviews.append("264.9K views")
        nineviews.append("1.4M views")
        nineviews.append("321.2K views")
        nineviews.append("452.3K views")
        nineviews.append("115K views")
        nineviews.append("3.2M views")
        nineviews.append("6.2M views")
        nineviews.append("3.8M views")
        nineviews.append("1.1M views")
        nineviews.append("1.5M views")
        
        nineviews.append("255.4K views")
        nineviews.append("1.5M views")
        nineviews.append("321K views")
        nineviews.append("455K views")
        nineviews.append("321K views")
        nineviews.append("4.3M views")
        nineviews.append("2.1M views")
        nineviews.append("1.8M views")
        nineviews.append("2.5M views")
        nineviews.append("26K views")
        nineviews.append("37K views")
        nineviews.append("39K views")
        nineviews.append("321.6K views")
        nineviews.append("342.8K views")
        nineviews.append("821K views")
        nineviews.append("4.2M views")
        nineviews.append("1.9M views")
        nineviews.append("2.2M views")
        nineviews.append("3.7M views")
        nineviews.append("1M views")
        
        nineviews.append("450K views")
        nineviews.append("2.8M views")
        nineviews.append("321K views")
        nineviews.append("892K views")
        nineviews.append("801K views")
        nineviews.append("4M views")
        nineviews.append("1.2M views")
        nineviews.append("1M views")
        nineviews.append("2.4M views")
        nineviews.append("2.9M views")
        
        nineviews.append("1.8M views")
        nineviews.append("2.5M views")
        nineviews.append("26K views")
        nineviews.append("37K views")
        nineviews.append("39K views")
        nineviews.append("321.6K views")
        nineviews.append("342.8K views")
        nineviews.append("821K views")
        nineviews.append("4.2M views")
        nineviews.append("39K views")
        nineviews.append("321.6K views")
        nineviews.append("342.8K views")
        nineviews.append("821K views")
        
        nineviews.append("377.9K views")
        nineviews.append("3.4M views")
        nineviews.append("933.6K views")
        nineviews.append("395.8K views")
        nineviews.append("82K views")
        nineviews.append("5.1M views")
        nineviews.append("2.6M views")
        nineviews.append("1.3M views")
        nineviews.append("2M views")
        nineviews.append("1.2M views")
        nineviews.append("1.3M views")
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
        nineviews.append("123K views")
        nineviews.append("23K views")
        nineviews.append("984K views")
        nineviews.append("4.1M views")
        nineviews.append("1.4M views")
        nineviews.append("3.8M views")
        nineviews.append("2M views")
        nineviews.append("1.2M views")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        if collectionView.tag == 1 {
            
            selectedindex = indexPath.row
            
            collectionView2.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            
            

            if selectedindex == 0 {
                
                collectionView.alpha = 0
                
                activityIndicator.startAnimating()
                activityIndicator.alpha = 1
                activityIndicator.color = mygreen
                
                queryfortodayspicks()
                
                collectionView2.reloadData()

            } else {
            
            collectionView.alpha = 0
            
            selectedgenre = genres[indexPath.row]
            activityIndicator.startAnimating()
            activityIndicator.alpha = 1
            activityIndicator.color = mygreen
            
            selectedgenreshortner()
            
            queryforids { () -> () in
                
                self.queryforreviewinfo()
                
            }
            
            collectionView2.reloadData()
                
            }

        } else {
            
        if seemoreimages.count > 0 {
            
            if selectedindex == 0 {
                
                
                selectedbookid = dayofmonth
                selectedgenre = seemoreids[indexPath.row]
                selectedimage = seemoreimages[seemoreids[indexPath.row]]!
                selectedtitle = seemoretitles[seemoreids[indexPath.row]]!
                selectedauthor = seemoreauthors[seemoreids[indexPath.row]]!
                selectedimagename = seemoreimagenames[seemoreids[indexPath.row]]!
                selectedviews = nineviews[indexPath.row]

                DispatchQueue.main.async {
                    
                    
                    self.performSegue(withIdentifier: "BrowseToOverview", sender: self)
                    
                }
                
            } else {
                selectedbookid = seemoreids[indexPath.row]
                selectedimage = seemoreimages[seemoreids[indexPath.row]]!
                selectedtitle = seemoretitles[seemoreids[indexPath.row]]!
                selectedauthor = seemoreauthors[seemoreids[indexPath.row]]!
                selectedimagename = seemoreimagenames[seemoreids[indexPath.row]]!
                
                selectedviews = nineviews[indexPath.row]
                
                DispatchQueue.main.async {
                    
                    
                    self.performSegue(withIdentifier: "BrowseToOverview", sender: self)
                    
                }
            }
            

            
            
        } else {
            
        }
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 1 {
            
            return genres.count
            
        } else {
            
        if seemoreimages.count > 0 {
            
            return seemoreimages.count
            
        } else {
            
            return 0
            
        }
            
        }
    }
    
    func organizebyalphabetical() {
        
        
        seemoreids = seemoreids.sorted { $0 < $1 }
        
        
        collectionView.reloadData()
        
    }
    
    @IBOutlet weak var collectionView2: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 2 {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Books", for: indexPath) as! BooksCollectionViewCell
        cell.bookcover.layer.cornerRadius = 2.0
        cell.bookcover.layer.masksToBounds = true
        
            
//        cell.viewslabel.sizeToFit()
            
        cell.views.alpha =  0
        
        cell.dark.alpha = 0
        //        cell.selectionStyle = .none
        
        //        cell.layer.cornerRadius = 10.0
        //        cell.layer.masksToBounds = true
        //
        //        cell.finished.alpha = 0
        cell.genre.alpha = 0
        
        if seemoreimages.count > 0 {
            
            if selectedindex == 0 {
                
                cell.viewslabel.text = nineviews[intdayofweek + indexPath.row]
//                cell.readagain.alpha = 0
                cell.dark.alpha = 1
                cell.bookcover.image = seemoreimages[seemoreids[indexPath.row]]
                cell.views.text = seemoretitles[seemoreids[indexPath.row]]

                cell.views.alpha = 1
                cell.viewslabel.alpha = 1
                cell.eyeball.alpha = 1
                self.activityIndicator.stopAnimating()
                self.activityIndicator.alpha = 0
                
//                cell.lockimage.alpha = 1
            } else {
//                cell.readagain.alpha = 0
                cell.viewslabel.text = nineviews.randomElement()
                cell.views.alpha = 1
                cell.eyeball.alpha = 1
                cell.viewslabel.alpha = 1
                cell.dark.alpha = 1
                cell.views.text = seemoretitles[seemoreids[indexPath.row]]
                cell.bookcover.image = seemoreimages[seemoreids[indexPath.row]]
                
                self.activityIndicator.stopAnimating()
                self.activityIndicator.alpha = 0
            }


            
        } else {
            
            
            
            
            
        }
            
            return cell

        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Categories", for: indexPath) as! CategoriesCollectionViewCell

            collectionView.alpha = 1
            cell.titlelabel.text = genres[indexPath.row]
//            cell.titlelabel.sizeToFit()
            
            cell.selectedimage.layer.cornerRadius = 5.0
                cell.selectedimage.layer.masksToBounds = true
            collectionView2.alpha = 1
            
            if selectedindex == 0 {

                if indexPath.row == 0 {

                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1

                } else {

                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0

                }

            }
            
            if selectedindex == 1 {
                
                if indexPath.row == 1 {
                    
                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1
                    
                } else {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                    
                }
                
            }
            
            if selectedindex == 2 {

                if indexPath.row == 2 {

                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1

                } else {

                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0

                }

            }

            if selectedindex == 3 {

                if indexPath.row == 3 {

                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1

                } else {

                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0

                }

            }

            if selectedindex == 4 {

                if indexPath.row == 4 {

                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1

                } else {

                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0

                }

            }

            if selectedindex == 5 {

                if indexPath.row == 5 {

                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1

                } else {

                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0

                }

            }
            
            if selectedindex == 6 {
                
                if indexPath.row == 6 {
                    
                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1
                    
                } else {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                    
                }
                
            }
            
            if selectedindex == 7 {
                
                if indexPath.row == 7 {
                    
                    cell.titlelabel.alpha = 1
                    cell.selectedimage.alpha = 1
                    
                } else {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                    
                }
                
            }
            
            return cell

        }
        
    }

    var selectedindex = Int()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
