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
var seemoreviews = [String]()

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
        
        queryforids { () -> () in
            
            self.queryforreviewinfo()
            
        }
        // Do any additional setup after loading the view.
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
            
            seemoreimages[each] = UIImage(named: "\(abbreviation)\(each)")
            
            seemoreimagenames[each] = "\(abbreviation)\(each)"
            
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
            
            selectedviews = seemoreviews[indexPath.row]
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
            
            cell.views.text = seemoreviews[indexPath.row]
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.alpha = 0
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
