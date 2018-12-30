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
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadviews()
        ref = Database.database().reference()

//        addstaticbooks()
        genres.removeAll()
        genres.append("Today's Picks")
        genres.append("Biography & Memoir")
        genres.append("Health, Fitness, & Dieting")
        genres.append("Business & Investing")
        genres.append("Sex & Relationships")
        genres.append("Productivity")
        genres.append("Mental Health")
        genres.append("Psychology")
        
        collectionView2.reloadData()
        
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        activityIndicator.color = mygreen
        selectedindex = 0
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        dayofmonth = dateFormatter.string(from: now)
//        dayofmonth = "29"

        
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
                 
                }
                
                
            })
            
        }
    }
    
    var dayofmonth = String()
    
    func addstaticbooks() {
        
        selectedgenre = "Mental Health"
        
        var counter2 = 28
        
        while counter2 < 32 {
            
            //            ref?.child("AllBooks2").child(selectedgenre).child("\(counter2)").updateChildValues(["Author" : "Jordan B. Peterson", "BookID" : "\(counter2)", "Description" : "What does everyone in the modern world need to know? Renowned psychologist Jordan B. Peterson's answer to this most difficult of questions uniquely combines the hard-won truths of ancient tradition with the stunning revelations of cutting-edge scientific research.", "Genre" : "\(selectedgenre)", "Image" : "F\(counter2)", "Name" : "12 Rules for Life", "Completed" : "No", "Views" : "x"])
            
            //    ref?.child("AllBooks2").child(selectedgenre).child("\(counter2)").updateChildValues([ "Views" : "\(sevenviews[counter2])"])
            
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
                
                if functioncounter == genres.count-2 {
                    seemoreids = genres

                    self.collectionView.reloadData()
                    self.collectionView2.reloadData()
                }
                
                
            })
                
            }
            
        }
    }
    
    func loadviews() {
        
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
                selectedgenre = genres[indexPath.row+1]
                selectedimage = seemoreimages[seemoreids[indexPath.row+1]]!
                selectedtitle = seemoretitles[seemoreids[indexPath.row+1]]!
                selectedauthor = seemoreauthors[seemoreids[indexPath.row+1]]!
                selectedimagename = seemoreimagenames[seemoreids[indexPath.row+1]]!
                selectedviews = nineviews[indexPath.row]

                self.performSegue(withIdentifier: "BrowseToOverview", sender: self)
                
            } else {
                selectedbookid = seemoreids[indexPath.row]
                selectedimage = seemoreimages[seemoreids[indexPath.row]]!
                selectedtitle = seemoretitles[seemoreids[indexPath.row]]!
                selectedauthor = seemoreauthors[seemoreids[indexPath.row]]!
                selectedimagename = seemoreimagenames[seemoreids[indexPath.row]]!
                
                selectedviews = nineviews[indexPath.row]
                
                self.performSegue(withIdentifier: "BrowseToOverview", sender: self)
                
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
        cell.views.alpha =  0
        
        cell.dark.alpha = 0
        //        cell.selectionStyle = .none
        
        //        cell.layer.cornerRadius = 10.0
        //        cell.layer.masksToBounds = true
        //
        //        cell.finished.alpha = 0
        
        
        if seemoreimages.count > 0 {
            
            if selectedindex == 0 {
                
                
                cell.dark.alpha = 1
                cell.bookcover.image = seemoreimages[seemoreids[indexPath.row+1]]
                cell.views.text = genres[indexPath.row + 1]
                cell.views.alpha = 1
                self.activityIndicator.stopAnimating()
                self.activityIndicator.alpha = 0
//                cell.lockimage.alpha = 1
            } else {
                
                cell.dark.alpha = 0
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
