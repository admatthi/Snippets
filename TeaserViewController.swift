//
//  TeaserViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 1/4/19.
//  Copyright © 2019 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class TeaserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBAction func tapLeft(_ sender: Any) {
        
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    @IBOutlet weak var maintext: UILabel!
    @IBAction func tapRight(_ sender: Any) {
        
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        


   
      
        
        
    }
    
    func whatthehell() {
        
        
        ref?.child("AllBooks1").child(selectedgenre).child(selectedbookid).child("Summary").child("1").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
        
            if var activityvalue2 = value?["1"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["2"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["3"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["4"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["5"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["6"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["7"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["8"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["9"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["10"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["11"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["12"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["13"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["14"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["15"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["16"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["17"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["18"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["19"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["20"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["21"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["22"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["23"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["24"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["25"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["26"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["26"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["27"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["28"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["29"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["30"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["31"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["32"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["33"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["34"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["35"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["36"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["37"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["38"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["39"] as? String {
                
                self.quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["40"] as? String {
                
                self.quote.append(activityvalue2)
            }
            
            
            self.arrayCount = self.quote.count
        })
        
        
    }
    @IBOutlet weak var taplabel: UILabel!
    
    @IBOutlet weak var tapx: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tapw: UIButton!
    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var tapd: UIButton!
    @IBOutlet weak var tapmo: UIButton!
    @IBOutlet weak var tapm: UIButton!
    @IBAction func tapWeightLoss(_ sender: Any) {
        
        counter += 1
        tableView.reloadData()
        selectedgenre = "Health, Fitness, & Dieting"
        selectedbookid = "1"
        selectedtitle = "Weight loss"
        selectedauthor = "Mark"
        selectedimage = UIImage(named: "H1")!
        tapd.alpha = 0
        tapm.alpha = 0
        tapmo.alpha = 0
        taplabel.alpha = 0
        whatthehell()
    }
    @IBAction func tapDating(_ sender: Any) {
        counter += 1
        tableView.reloadData()
        selectedgenre = "Sex & Relationships"
        selectedbookid = "1"
        selectedtitle = "Weight loss"
        selectedauthor = "Mark"
        selectedimage = UIImage(named: "H1")!
        tapm.alpha = 0
        tapmo.alpha = 0
        taplabel.alpha = 0
        tapw.alpha = 0
        whatthehell()
    }
    @IBAction func tapMotivation(_ sender: Any) {
        counter += 1
        tableView.reloadData()
        selectedgenre = "Productivity"
        selectedbookid = "1"
        selectedtitle = "Weight loss"
        selectedauthor = "Mark"
        selectedimage = UIImage(named: "H1")!
        tapd.alpha = 0
        tapm.alpha = 0
        taplabel.alpha = 0
        tapw.alpha = 0
        whatthehell()
    }
    @IBAction func tapMoney(_ sender: Any) {
        counter += 1
        tableView.reloadData()
        selectedgenre = "Business & Investing"
        selectedbookid = "1"
        selectedtitle = "Weight loss"
        selectedauthor = "Mark"
        selectedimage = UIImage(named: "H1")!
        tapd.alpha = 0
        tapmo.alpha = 0
        taplabel.alpha = 0
        tapw.alpha = 0
        whatthehell()
    }
    var counter = 0
    var quote = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        quote.removeAll()
        
        titlelabel.alpha = 0
        authorlabel.alpha = 0
        progressView.alpha = 0
        tapx.alpha = 0
        
        cover.alpha = 0
        tapd.alpha = 0
        tapm.alpha = 0
        tapmo.alpha = 0
        taplabel.alpha = 0
        tapw.alpha = 0
        tapw.layer.cornerRadius = 5.0
        tapmo.layer.masksToBounds = true
        tapmo.layer.cornerRadius = 5.0
        tapm.layer.masksToBounds = true
        tapd.layer.cornerRadius = 5.0
        tapd.layer.masksToBounds = true
        tapm.layer.cornerRadius = 5.0
        tapw.layer.masksToBounds = true
        
        quote.append("Welcome to Snippets. Tap to continue.")
        quote.append("Discover life changing ideas from the world's best non fiction books!")
        quote.append("What interests you?")
        quote.append("Excellent choice. Tap to continue.")

        tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    var trimmedtext = String()
    var arrayCount = Int()
    
    func showproperquote() {
        
        if counter == 0 {
            
            self.progressView.setProgress(0.0, animated:false)
            
        } else {
            let progress = (Float(counter-5)/Float(arrayCount))
            self.progressView.setProgress(Float(progress), animated:true)
        }
        
        if counter < quote.count {
            
            
            trimmedtext = quote[counter]
            
            trimmedtext = trimmedtext.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            trimmedtext = trimmedtext.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            //        trimmedtext = trimmedtext.replacingOccurrences(of: "\'", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            trimmedtext = trimmedtext.replacingOccurrences(of: "“", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            trimmedtext = trimmedtext.replacingOccurrences(of: "”", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            print(trimmedtext)
            //        quotetext.text = trimmedtext.capitalizingFirstLetter()
            
            tableView.reloadData()
            
            print(counter)
            
            //        quotetext.addCharacterSpacing()
            
            //        backgroundlabel.backgroundColor = colors[counter]
            
            
        }
    }
    
    
    @IBAction func tapNext(_ sender: AnyObject?) {
        
        //        threebuttonuntapped()
        
        //        quotetext.slideInFromRight()
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        counter += 1
        
        if counter == 2 {
            
            tapd.alpha = 1
            tapm.alpha = 1
            tapmo.alpha = 1
            taplabel.alpha = 1
            tapw.alpha = 1
            
        }
        
    
        
        if counter == 4 {
            
            tapd.alpha = 0
            tapm.alpha = 0
            tapmo.alpha = 0
            taplabel.alpha = 0
            tapw.alpha = 0
            titlelabel.alpha = 1
            authorlabel.alpha = 1
            cover.alpha = 1
            progressView.alpha = 1
            tapx.alpha = 1
            titlelabel.text = selectedtitle
            authorlabel.text = selectedauthor
            cover.image = selectedimage
            cover.layer.cornerRadius = 5.0
            cover.layer.masksToBounds = true
        }
        
        nextcount()
        
        //        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
    }
    
    @IBAction func tapPrevious(_ sender: AnyObject?) {
        
        //        threebuttonuntapped()
        
        //        quotetext.slideInFromRight()
        
        
        
        //        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
    }
    
    func nextcount() {
        
        
        showproperquote()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        

   
            return 1
            
    }
    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            
            
            if trimmedtext.count > 400 {
                
                return UITableViewAutomaticDimension
                
            } else {
                
                return 625
                
            }
            
        } else {
            
            return UITableViewAutomaticDimension
            
            
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reader", for: indexPath) as! ReaderTableViewCell
        
        
        cell.maintext.text = trimmedtext.capitalizingFirstLetter()
        cell.selectionStyle = .none
        cell.center = self.view.center
        cell.tapright.addTarget(self, action: #selector(TeaserViewController.tapNext(_:)), for: UIControlEvents.touchUpInside)
        cell.tapleft.addTarget(self, action: #selector(TeaserViewController.tapPrevious(_:)), for: UIControlEvents.touchUpInside)

            cell.arrow.alpha = 0
        cell.maintext.text = self.quote[counter]
        
   
        
        return cell
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
