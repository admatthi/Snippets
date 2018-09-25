//
//  LibViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 9/10/18.
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

var inprogresspressed = Bool()
var searchterm = String()

class LibViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tapinprogress: UIButton!
    @IBOutlet weak var tapfinished: UIButton!
    
    @IBAction func tapInProgress(_ sender: Any) {
        
        inprogresspressed = true
        searchterm = "InProgress"
        tapinprogress.alpha = 1
        tapfinished.alpha = 0.25
        tapinprogress.setBackgroundImage(UIImage(named: "BottomBar"), for: .normal)
        tapfinished.setBackgroundImage(nil, for: .normal)
        queryforbookids { () -> () in
            
            self.queryforbookinfo()
            
        }
    }
    
    @IBAction func tapFinished(_ sender: Any) {
        
        inprogresspressed = false
        searchterm = "Completed"
        tapinprogress.alpha = 0.25
        tapfinished.alpha = 1
        tapfinished.setBackgroundImage(UIImage(named: "BottomBar"), for: .normal)
        tapinprogress.setBackgroundImage(nil, for: .normal)

        queryforbookids { () -> () in
            
            self.queryforbookinfo()
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        self.becomeFirstResponder() // To get shake gesture
        
        //        freebackground.layer.cornerRadius = 5.0
        FBSDKAppEvents.logEvent("Library Viewed")
        
        self.loaddefaultvalues()


        loadstuff()
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            tapinprogress.alpha = 0
            tapfinished.alpha = 0
            
        } else {
         
            uid = (Auth.auth().currentUser?.uid)!

            tapinprogress.alpha = 1
            tapfinished.alpha = 0.25
            inprogresspressed = true
            searchterm = "InProgress"
            tapinprogress.setBackgroundImage(UIImage(named: "BottomBar"), for: .normal)

            queryforbookids { () -> () in
                
                self.queryforbookinfo()
                
            }
            
        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func queryforbookids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        librarybookids.removeAll()
        librarycovers.removeAll()
        libraryauthors.removeAll()
        librarytitles.removeAll()
        librarygenres.removeAll()
        librarysubids.removeAll()
        libraryimagenames.removeAll()
       
        tableView.reloadData()
    ref?.child("Users").child(uid).child("Library").child(searchterm).queryLimited(toFirst: 25).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    librarybookids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
        
        
    }
    
    func queryforbookinfo() {
        
        var functioncounter = 0
        
        librarybookids = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: librarybookids) as! [String]
        
        for each in librarybookids  {
            
            ref?.child("Users").child(uid).child("Library").child(searchterm).child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                
                if var activityvalue1 = value?["Name"] as? String {
                    
                    librarytitles[each] = activityvalue1
                    
                }
                
                if var activityvalue2 = value?["Author"] as? String {
                    
                    libraryauthors[each] = activityvalue2
                    
                }
                
                if var activityvalue4 = value?["Genre"] as? String {
                    
                    librarygenres[each] = activityvalue4
                    
                }
                
                if var activityvalue4 = value?["BookID"] as? String {
                    
                    librarysubids[each] = activityvalue4
                    
                }
                
                if var activityvalue4 = value?["Completed"] as? String {
                    
                    if activityvalue4 == "True" {
                        
                        librarycomps[each] = "True"
                        
                    } else {
                        
                        librarycomps[each] = "False"
                    }
                    
                }
                
                if var activityvalue3 = value?["Image"] as? String {
                    
                    librarycovers[each] = UIImage(named: "\(activityvalue3)")
                    
                    libraryimagenames[each] = activityvalue3
                    
                    functioncounter += 1

                }
                
                
                if functioncounter == librarybookids.count  {
                    
//                    self.showloading()
                    self.tableView.reloadData()
                }
                
            })
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if librarycovers.count > 0 {
            
        selectedgenre = librarygenres[librarybookids[indexPath.row]]!
        selectedbookid = librarysubids[librarybookids[indexPath.row]]!
        selectedimage = librarycovers[librarybookids[indexPath.row]]!
        selectedtitle = librarytitles[librarybookids[indexPath.row]]!
        selectedauthor = libraryauthors[librarybookids[indexPath.row]]!
        selectedimagename = libraryimagenames[librarybookids[indexPath.row]]!
            
        self.performSegue(withIdentifier: "LibraryToOverview", sender: self)

            
        } else {
            
            selectedgenre = "Psychology"
            selectedbookid = "\(indexPath.row+1)"
            selectedimage = ninebookcovers[indexPath.row]
            selectedimagename = "PS\(indexPath.row+1)"
            selectedtitle = ninebooknames[indexPath.row]
            selectedauthor = ninebookauthors[indexPath.row]
            
            self.performSegue(withIdentifier: "LibraryToOverview", sender: self)

        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if librarycovers.count > 0 {
            
           return librarycovers.count
            
        } else {
            
            if ninebookauthors.count > 0 {
                
                if searchterm == "InProgress" {
                    
                    return 15

                } else {
                    
                    return 1
                }
                
            } else {
                
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Lib", for: indexPath) as! LibTableViewCell
        
        cell.coverimage.layer.cornerRadius = 10.0
        cell.coverimage.layer.masksToBounds = true
        cell.selectionStyle = .none
        if librarycovers.count > 0 {
            
            cell.title.text = librarytitles[librarybookids[indexPath.row]]
        cell.author.text = libraryauthors[librarybookids[indexPath.row]]
        cell.coverimage.image = librarycovers[librarybookids[indexPath.row]]
        cell.greenlabel.alpha = 1
        cell.emptylabel.alpha = 0
            
            if inprogresspressed == false {
                
                cell.completed.alpha = 1
                
            } else {
                
                cell.completed.alpha = 0

            }
            
        } else {
            
            if indexPath.row == 0 {
                
            cell.author.text = ""
            cell.title.text = ""
            cell.coverimage.image = nil
            cell.greenlabel.alpha = 0
            cell.emptylabel.alpha = 1
            cell.completed.alpha = 0

                if inprogresspressed {
                    
                    cell.emptylabel.text = "You haven't started any books yet. Here are a few suggestions!"

                } else {
                    
                    if searchterm == "Completed" {
                    
                    cell.emptylabel.text = "This is where your finished books will appear. Start reading!"
                        
                    } else {
                        
                        cell.emptylabel.text = "Your library is empty. Bummer. Here are a few suggestions!"
                    }
                }
                
            } else {
                
                cell.coverimage.image = ninebookcovers[indexPath.row]
                cell.greenlabel.alpha = 1
                cell.author.text = ninebookauthors[indexPath.row]
                cell.title.text = ninebooknames[indexPath.row]
                cell.emptylabel.alpha = 0
                cell.completed.alpha = 0

            }
        }

        return cell
    }
    
    func loadstuff() {
        
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
    
    func loaddefaultvalues() {
        
        ninebookauthors.append("Kevin Horsley")
        ninebookauthors.append("David Deida")
        ninebookauthors.append("Jonathan Heidt")
        ninebookauthors.append("Sigmund Freud")
        ninebookauthors.append("Robert B. Cialdini")
        ninebookauthors.append("Dr. Dan Ariely")
        ninebookauthors.append("Malcolm Gladwell")
        ninebookauthors.append("Mihaly Csikszentmihalyi")
        ninebookauthors.append("Malcolm Gladwell")
        ninebookauthors.append("Mark Williams and Danny Penman")
        ninebookauthors.append("Martin Seligman")
        ninebookauthors.append("Daniel Goleman")
        ninebookauthors.append("Dan Gilbert")
        ninebookauthors.append("Nassim Nicholas Taleb")
        ninebookauthors.append("Karen Ehman")
        ninebooknames.append("Unlimited Memory")
        ninebooknames.append("The Way of the Superior Man")
        ninebooknames.append("The Happiness Hypothesis")
        ninebooknames.append("Civilization and Its Discontents")
        ninebooknames.append("Influence")
        ninebooknames.append("Predictably Irrational")
        ninebooknames.append("Outliers: The Story Of Success")
        ninebooknames.append("Flow: The Psychology Of Happiness")
        ninebooknames.append("David and Goliath")
        ninebooknames.append("Mindfullness")
        ninebooknames.append("Authentic Happiness")
        ninebooknames.append("Emotional Intelligence")
        ninebooknames.append("Stumbling on Happiness")
        ninebooknames.append("Antifragile: Things That Gain from Disorder")
        ninebooknames.append("Keep It Shut")

        tableView.reloadData()
        
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

var librarygenres = [String:String]()
var librarysubids = [String:String]()
var librarycomps = [String:String]()
var libraryimagenames = [String:String]()
