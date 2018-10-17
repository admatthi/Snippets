//
//  ScrollViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 10/17/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

var reading = [String:String]()
var seemoredescriptions = [String:String]()
var lastread = [String:Int]()

class ScrollViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

//        activityIndicator.startAnimating()
//        activityIndicator.alpha = 1
//        activityIndicator.color = mygreen
//        titlelabel.text = selectedgenre
        
        selectedgenre = "Biography & Memoir"
        
        selectedgenreshortner()
//        loadviews()
        
        queryforids { () -> () in
            
            self.queryforreviewinfo()
            
        }
        
//        swipeRightRec.addTarget(self, action: #selector(self.swipeR) )
//        swipeRightRec.direction = .right
//        self.view!.addGestureRecognizer(swipeRightRec)
        
        
//        swipeLeftRec.addTarget(self, action: #selector(self.swipeL) )
//        swipeLeftRec.direction = .left
//        self.view!.addGestureRecognizer(swipeLeftRec)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func queryforids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        seemoreids.removeAll()
        seemoreimages.removeAll()
        seemoretitles.removeAll()
        seemoreauthors.removeAll()
        seemoreimagenames.removeAll()
        seemoredescriptions.removeAll()
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
                

                if var views = value?["Description"] as? String {
                    seemoredescriptions[each] = views
                    
                }
                
                if var views = value?["LastRead"] as? Int {
                    
                    lastread[each] = counter
                    
                } else {
                    
                    lastread[each] = 0

                }
                
                seemoreimages[each] = UIImage(named: "\(abbreviation)\(each)")
                
                seemoreimagenames[each] = "\(abbreviation)\(each)"
                
                reading[each] = "No"
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if seemoreimages.count > 0 {
            
            return seemoreimages.count
            
        } else {
            
            return 0
        }
    }
    
    @IBAction func tapPrevious(_ sender: AnyObject?) {
        
//        quotetext.slideInFromLeft()
        
        if counter > 0 {
            
            lastcount()
            
        }
        
//        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
//        bookmarktapped = false
    }
    
    func nextcount() {
        
        
        if counter > quote.count-2 {
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
            //            ref?.child("Users").child(uid).child("Library").child("InProgress").child(selectedtitle).removeValue()
            
            //            ref?.child("Users").child(uid).child("Library").child("InProgress").child(selectedtitle).updateChildValues(["Name" : selectedtitle, "Author" : selectedauthor, "Image": selectedimagename, "Genre" : selectedgenre, "BookID" : selectedbookid, "Completed" : "Yes", "Description" : selecteddescription, "Views" : selectedviews])
            
            //            selectedimage = coverimage.image!
            FBSDKAppEvents.logEvent("Book Completed")
            
            //            self.performSegue(withIdentifier: "ReaderToCompleted", sender: self)
            
            
        } else {
            
            counter += 1
            
            ref?.child(selectedgenre).child(selectedbookid).updateChildValues(["LastRead" : counter])

            lastread[seemoreids[buttonTag]] = counter

            showproperquote()
            
//            let progress = (Float(counter)/Float(arrayCount))
//            self.progress.setProgress(Float(progress), animated:true)
        }
        
        
    }
    
    
    
    func showproperquote() {
        
        var trimmedtext = String()
        
        if counter < quote.count {
            
            
            trimmedtext = quote[counter]
            
            trimmedtext = trimmedtext.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            trimmedtext = trimmedtext.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            //        trimmedtext = trimmedtext.replacingOccurrences(of: "\'", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            trimmedtext = trimmedtext.replacingOccurrences(of: "“", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            trimmedtext = trimmedtext.replacingOccurrences(of: "”", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            quote[counter] = trimmedtext
            
            let indexPath = IndexPath(item: buttonTag, section: 0)
            
            UIView.performWithoutAnimation({
                let loc = tableView.contentOffset
                tableView.reloadRows(at: [indexPath], with: .none)
                tableView.contentOffset = loc
            })
            //        textlabel.addCharacterSpacing()
            
            //        backgroundlabel.backgroundColor = colors[counter]
            
            
        }
    }
    func lastcount() {
        
        
        if counter == 0 {
            
            
        } else {
            
            counter -= 1
            
            ref?.child(selectedgenre).child(selectedbookid).updateChildValues(["LastRead" : counter])
            
            lastread[seemoreids[buttonTag]] = counter
            
            showproperquote()
            
//            let progress = (Float(counter)/Float(arrayCount))
//            self.progress.setProgress(Float(progress), animated:true)
        }
        
//        bookmarktapped = true
//        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
    }
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    
        func getquotes() {
            
            quote.removeAll()
            
            ref?.child("AllBooks1").child("Biography & Memoir").child(selectedbookid).child("Summary").child("1").observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
                
                if var activityvalue2 = value?["1"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["2"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["3"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["4"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["5"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["6"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["7"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["8"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["9"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["10"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["11"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["12"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["13"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["14"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["15"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["16"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["17"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["18"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["19"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["20"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["21"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["22"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["23"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["24"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["25"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["26"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                if var activityvalue2 = value?["26"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["27"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["28"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["29"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["30"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["31"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["32"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["33"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["34"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["35"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["36"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["37"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["38"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["39"] as? String {
                    
                    quote.append(activityvalue2)
                }
                if var activityvalue2 = value?["40"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                
                let indexPath = IndexPath(item: self.buttonTag, section: 0)
                
                UIView.performWithoutAnimation({
                    let loc = self.tableView.contentOffset
                    self.tableView.reloadRows(at: [indexPath], with: .none)
                    self.tableView.contentOffset = loc
                })
                
                self.showproperquote()
                
                self.arrayCount = quote.count
            })
            
            
    }
    
    var arrayCount = Int()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        
        
        
        if seemoreimages.count > 0 {
            
            
//            selectedbookid = seemoreids[indexPath.row]

            
            
            
        } else {
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Scroll", for: indexPath) as! Scroll2TableViewCell
        
        cell.smallimage.layer.cornerRadius = 5.0
        cell.smallimage.layer.masksToBounds = true
//        cell.coverimage.layer.cornerRadius = 10.0
//        cell.coverimage.layer.masksToBounds = true
        cell.tapnext.tag = indexPath.row

        cell.tapnext.addTarget(self, action: #selector(ScrollViewController.tapNext2(_:)), for: UIControlEvents.touchUpInside)
    
        cell.tapprevious.tag = indexPath.row
        
        cell.tapprevious.addTarget(self, action: #selector(ScrollViewController.tapPrevious2(_:)), for: UIControlEvents.touchUpInside)

   

                cell.selectionStyle = .none
        
        if seemoreimages.count > 0 {
            
            cell.titlelabel.text = seemoretitles[seemoreids[indexPath.row]]
            cell.authorlabel.text = seemoreauthors[seemoreids[indexPath.row]]
            cell.coverimage.image = seemoreimages[seemoreids[indexPath.row]]
            cell.smallimage.image = seemoreimages[seemoreids[indexPath.row]]
            cell.introlabel.text = seemoredescriptions[seemoreids[indexPath.row]]
            
            if reading[seemoreids[indexPath.row]] == "No" {
                
                cell.coverimage.alpha = 1
                cell.textlabel.alpha = 0
                cell.readerbackground.alpha = 0
                cell.swiperightlabel.alpha = 1
                cell.background3.alpha = 1
                cell.icon.alpha = 1
                
            } else {
                
                cell.coverimage.alpha = 0
                cell.readerbackground.alpha = 1
                cell.textlabel.alpha = 1
                counter = lastread[seemoreids[indexPath.row]]!
//                cell.textlabel.slideInFromRight()
                cell.textlabel.text = quote[counter]
                cell.swiperightlabel.alpha = 0
                cell.background3.alpha = 0
                cell.icon.alpha = 0
                
            }
//            cell.views.text = seemoreviews[seemoreids[indexPath.row]]!
//
//            self.activityIndicator.stopAnimating()
//            self.activityIndicator.alpha = 0
            
            
        }
        
        return cell
    }
    
//    @objc func swipeL() {
//
//        self.tapNext2(nil)
//
//    }
//
    
    @objc func swipeR() {
        
//        self.tapP(nil)
        
    }
    
    var readercounter = Int()
    
    var buttonTag = Int()
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath:IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    @objc func tapNext2(_ sender: UIButton) {
        
        buttonTag = sender.tag
        
        if reading[seemoreids[buttonTag]] == "Yes" {
            
            nextcount()

        } else {
            
            selectedbookid = seemoreids[buttonTag]
            
            reading[seemoreids[buttonTag]] = "Yes"
            
  
            
            getquotes()
            
            
            
        }
        
        
        
    }

    @objc func tapPrevious2(_ sender: UIButton) {
        
        buttonTag = sender.tag
        
        if counter > 0 {
            
            if reading[seemoreids[buttonTag]] == "Yes" {
                
                lastcount()
                
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

}
