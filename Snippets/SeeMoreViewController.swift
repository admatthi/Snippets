//
//  SeeMoreViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 9/25/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

var seemoreauthors = [String:String]()
var seemoreimages = [String:UIImage]()
var seemoretitles = [String:String]()
var seemoreids = [String]()
var seemoreimagenames = [String:String]()
var seemoreviews = [String:String]()

var abbreviation = String()

class SeeMoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        activityIndicator.color = mygreen
        titlelabel.text = selectedgenre
        
        selectedgenreshortner()
        loadviews()
        
        queryforids { () -> () in
            
            self.queryforreviewinfo()
            
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            
        })
        
    }
    func queryforids(completed: @escaping (() -> ()) ) {
        
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
                        
                    seemoreids.append(ids)

                    }
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        

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
                
                
                self.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        if seemoreimages.count > 0 {
            
            
            selectedbookid = seemoreids[indexPath.row]
            selectedimage = seemoreimages[seemoreids[indexPath.row]]!
            selectedtitle = seemoretitles[seemoreids[indexPath.row]]!
            selectedauthor = seemoreauthors[seemoreids[indexPath.row]]!
            selectedimagename = seemoreimagenames[seemoreids[indexPath.row]]!
            
            selectedviews = seemoreviews[seemoreids[indexPath.row]]!
            self.performSegue(withIdentifier: "SeeMoreToOverview", sender: self)
            
            
        } else {
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if seemoreimages.count > 0 {
            
            return seemoreimages.count
            
        } else {
            
            return 0 
        }
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Lib", for: indexPath) as! LibTableViewCell
        
        cell.coverimage.layer.cornerRadius = 10.0
        cell.coverimage.layer.masksToBounds = true
        cell.selectionStyle = .none
        
        if seemoreimages.count > 0 {
            
            cell.title.text = seemoretitles[seemoreids[indexPath.row]]
            cell.author.text = seemoreauthors[seemoreids[indexPath.row]]
            cell.coverimage.image = seemoreimages[seemoreids[indexPath.row]]
            
            cell.views.text = seemoreviews[seemoreids[indexPath.row]]!
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.alpha = 0
            
            var fuck = cell.views.text
        
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

}
