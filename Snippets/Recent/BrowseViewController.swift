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

        ref = Database.database().reference()

        selectedindex = 0
        
        genres.removeAll()
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
        selectedgenre = "Biography & Memoir"

        selectedgenreshortner()
        loadviews()

        queryforids { () -> () in
            
            self.queryforreviewinfo()
            
        }
        
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
            

            collectionView.alpha = 0
            
            selectedindex = indexPath.row
            selectedgenre = genres[indexPath.row]
            activityIndicator.startAnimating()
            activityIndicator.alpha = 1
            activityIndicator.color = mygreen
            
            selectedgenreshortner()
            queryforids { () -> () in
                
                self.queryforreviewinfo()
                
            }
            
            collectionView2.reloadData()

        } else {
            
        if seemoreimages.count > 0 {
            
            selectedbookid = seemoreids[indexPath.row]
            selectedimage = seemoreimages[seemoreids[indexPath.row]]!
            selectedtitle = seemoretitles[seemoreids[indexPath.row]]!
            selectedauthor = seemoreauthors[seemoreids[indexPath.row]]!
            selectedimagename = seemoreimagenames[seemoreids[indexPath.row]]!
            
            selectedviews = seemoreviews[seemoreids[indexPath.row]]!
            
            self.performSegue(withIdentifier: "BrowseToOverview", sender: self)
            
            
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
        cell.lockimage.alpha = 0
        cell.views.alpha =  0
    
        cell.dark.alpha = 0
        //        cell.selectionStyle = .none
        
        //        cell.layer.cornerRadius = 10.0
        //        cell.layer.masksToBounds = true
        //
        //        cell.finished.alpha = 0
        
        
        if seemoreimages.count > 0 {
            
            cell.dark.alpha = 0
            //            cell.rectangle.alpha = 1
            
            //            if librarycomps[librarybookids[indexPath.row]] == "No" {
            //
            //                cell.rectangle.image = UIImage(named: "EmptyRectangle")
            //
            //            } else {
            //
            //                cell.rectangle.image = UIImage(named: "FullRectangle")
            //
            //            }
            //
//            refreshControl.endRefreshing()
            
            //            cell.title.text = librarytitles[librarybookids[indexPath.row]]
            //            cell.author.text = libraryauthors[librarybookids[indexPath.row]]
            cell.bookcover.image = seemoreimages[seemoreids[indexPath.row]]
            cell.views.text = nineviews[indexPath.row]
            //            cell.descriptionlabel.text = librarydescriptions[librarybookids[indexPath.row]]
            
            //            if libraryviews.count >= librarybookids.count {
            //
            //                cell.views.text = libraryviews[librarybookids[indexPath.row]]!
            //
            //            } else {
            //
            //                cell.views.text = nineviews[indexPath.row]
            //
            //            }
            //            cell.bamlabel.text = "Start Story"
            //            cell.buttonlabel.image = UIImage(named: "WhiteButton-1")
            //            cell.bamlabel.textColor = darkbluee
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.alpha = 0
            
            //            cell.upgradelabel.alpha = 0
            //            cell.bluebutton.alpha = 0
            //            cell.emptylabel.alpha = 0
            //            cell.lock.alpha = 0
            
            //            cell.greenlabel.alpha = 1
            
        } else {
            
            //        cell.greenlabel.alpha = 0
            
            if indexPath.row == 0 {
                
                //            cell.title.text = ""
                ////            cell.emptylabel.alpha = 1
                //            cell.coverimage.image = nil
                //            cell.views.text = ""
                //            cell.author.text = ""
                //            cell.upgradelabel.alpha = 0
                //            cell.lock.alpha = 0
                //            cell.bluebutton.alpha = 0
                //            cell.rectangle.alpha = 0
                
            } else {
                
                //            cell.title.text = ""
                cell.dark.alpha = 0
                cell.bookcover.image = nil
                //            cell.views.text = ""
                //            cell.author.text = ""
                //            cell.upgradelabel.alpha = 1
                //            cell.lock.alpha = 1
                //            cell.bluebutton.alpha = 1
                //            cell.emptylabel.alpha = 0
                //            cell.rectangle.alpha = 0
                
                if Auth.auth().currentUser == nil {
                    // Do smth if user is not logged in
                    //                cell.upgradelabel.alpha = 1
                    //                cell.lock.alpha = 1
                    //                cell.bluebutton.alpha = 1
                    
                } else {
                    //                cell.lock.alpha = 0
                    //                cell.upgradelabel.alpha = 0
                    //                cell.bluebutton.alpha = 0
                    
                }
            }
            
            
            
        }
            
            return cell

        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Categories", for: indexPath) as! CategoriesCollectionViewCell

            collectionView.alpha = 1
            cell.titlelabel.text = genres[indexPath.row]
            
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
