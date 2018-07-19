//
//  A1ViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 7/16/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import FBSDKCoreKit

var dummycovers = [UIImage]()
var dummytitles = [String]()
var dummyauthors = [String]()
var dummybookids = [String]()

class A1ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectinView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FBSDKAppEvents.logEvent("Sale Screen")

        
        dummycovers.append(UIImage(named: "1")!)
        dummycovers.append(UIImage(named: "2")!)
        dummycovers.append(UIImage(named: "3")!)
        dummycovers.append(UIImage(named: "4")!)
        dummycovers.append(UIImage(named: "5")!)
        dummycovers.append(UIImage(named: "6")!)
        dummycovers.append(UIImage(named: "7")!)
        dummycovers.append(UIImage(named: "8")!)
        dummycovers.append(UIImage(named: "9")!)
        dummycovers.append(UIImage(named: "10")!)
        dummycovers.append(UIImage(named: "11")!)
        dummycovers.append(UIImage(named: "12")!)
        dummycovers.append(UIImage(named: "13")!)
        dummycovers.append(UIImage(named: "14")!)
        dummycovers.append(UIImage(named: "15")!)
        dummycovers.append(UIImage(named: "16")!)
        dummycovers.append(UIImage(named: "w3")!)
        dummycovers.append(UIImage(named: "18")!)
        dummycovers.append(UIImage(named: "19")!)
        dummycovers.append(UIImage(named: "20")!)
        dummycovers.append(UIImage(named: "21")!)
        dummycovers.append(UIImage(named: "22")!)
        dummycovers.append(UIImage(named: "23")!)
        dummycovers.append(UIImage(named: "24")!)
//        dummycovers.append(UIImage(named: "25")!)
        
        dummytitles.append("Elon Musk: Tesla, SpaceX, and the Quest for a Fantastic Future")
        dummyauthors.append("Ashlee Vance")
        dummytitles.append("Unshakeable: Your Financial Freedom Playbook ")
        dummyauthors.append("Tony Robbins")
        dummytitles.append("Tools of Titans: The Tactics, Routines, and Habits of Billionaires, Icons, and World-Class Performers")
        dummyauthors.append("Timothy Ferriss")
        dummytitles.append("Steve Jobs")
        dummyauthors.append("Walter Isaacson")
        dummytitles.append("How to Read Literature Like a Professor: A Lively and Entertaining Guide to Reading Between the Lines, Revised Edition")
        dummyauthors.append("Thomas C Foster")
        dummytitles.append("The 7 Habits of Highly Effective People: Powerful Lessons in Personal Change")
        dummyauthors.append("Stephen R. Covey ")
        dummytitles.append("Principles: Life and Work ")
        dummyauthors.append("Ray Dalio ")
        dummytitles.append("Outliers: The Story of Success")
        dummyauthors.append("Malcolm Gladwell ")
        dummytitles.append("Freakonomics: A Rogue Economist Explores the Hidden Side of Everything")
        dummyauthors.append("Steven D. Levitt")
        dummytitles.append("A Brief History of Time")
        dummyauthors.append("Stephen Hawking")
        dummytitles.append("The Intelligent Investor: The Definitive Book on Value Investing. A Book of Practical Counsel (Revised Edition) (Collins Business Essentials)")
        dummyauthors.append("Benjamin Graham")
        dummytitles.append("The Plant Paradox: The Hidden Dangers in Healthy Foods That Cause Disease and Weight Gain")
        dummyauthors.append("Steven R. Gundry MD MD ")
        dummytitles.append("The Obesity Code: Unlocking the Secrets of Weight Loss")
        dummyauthors.append("Dr. Jason Fung")
        dummytitles.append("Shoe Dog: A Memoir by the Creator of Nike")
        dummyauthors.append("Phil Knight")
        dummytitles.append("Alibaba: The House That Jack Ma Built")
        dummyauthors.append("Duncan Clark")
        dummytitles.append("Sam Walton: Made In America")
        dummyauthors.append("Sam Walton, John Huey")
        dummytitles.append("Wired for Love: How Understanding Your Partner's Brain and Attachment Style Can Help You Defuse Conflict and Build")
        dummyauthors.append("Stan Tatkin")
        dummytitles.append("The Four Agreements: A Practical Guide to Personal Freedom (A Toltec Wisdom Book)")
        dummyauthors.append("Don Miguel Ruiz")
        dummytitles.append("Sapiens: A Brief History of Humankind")
        dummyauthors.append("Yuval Noah Harari")
        dummytitles.append("48 Laws of Power")
        dummyauthors.append("Robert Greene")
        dummytitles.append("The Power of Now")
        dummyauthors.append("Eckhart Tolle")
        dummytitles.append("The Signal and the Noise: Why So Many Predictions Fail--but Some Don't")
        dummyauthors.append("Nate Silver")
        dummytitles.append("How Google Works")
        dummyauthors.append("Eric Schmidt")
        dummytitles.append("How to Change Your Mind")
        dummyauthors.append("Michael Pollan")
//        dummytitles.append("30 Lessons for Living: Tried and True Advice from the Wisest Americans")
//        dummyauthors.append("Karl Pillemer Ph.D. ")

        dummycovers.append(UIImage(named: "1")!)
        dummycovers.append(UIImage(named: "2")!)
        dummycovers.append(UIImage(named: "3")!)
        dummycovers.append(UIImage(named: "4")!)
        dummycovers.append(UIImage(named: "5")!)
        dummycovers.append(UIImage(named: "6")!)
        dummycovers.append(UIImage(named: "7")!)
        dummycovers.append(UIImage(named: "8")!)
        dummycovers.append(UIImage(named: "9")!)
        dummycovers.append(UIImage(named: "10")!)
        dummycovers.append(UIImage(named: "11")!)
        dummycovers.append(UIImage(named: "12")!)
        dummycovers.append(UIImage(named: "13")!)
        dummycovers.append(UIImage(named: "14")!)
        dummycovers.append(UIImage(named: "15")!)
        dummycovers.append(UIImage(named: "16")!)
        dummycovers.append(UIImage(named: "w3")!)
        dummycovers.append(UIImage(named: "18")!)
        dummycovers.append(UIImage(named: "19")!)
        dummycovers.append(UIImage(named: "20")!)
        dummycovers.append(UIImage(named: "21")!)
        dummycovers.append(UIImage(named: "22")!)
        dummycovers.append(UIImage(named: "23")!)
        dummycovers.append(UIImage(named: "24")!)
        //        dummycovers.append(UIImage(named: "25")!)
        
        dummytitles.append("Elon Musk: Tesla, SpaceX, and the Quest for a Fantastic Future")
        dummyauthors.append("Ashlee Vance")
        dummytitles.append("Unshakeable: Your Financial Freedom Playbook ")
        dummyauthors.append("Tony Robbins")
        dummytitles.append("Tools of Titans: The Tactics, Routines, and Habits of Billionaires, Icons, and World-Class Performers")
        dummyauthors.append("Timothy Ferriss")
        dummytitles.append("Steve Jobs")
        dummyauthors.append("Walter Isaacson")
        dummytitles.append("How to Read Literature Like a Professor: A Lively and Entertaining Guide to Reading Between the Lines, Revised Edition")
        dummyauthors.append("Thomas C Foster")
        dummytitles.append("The 7 Habits of Highly Effective People: Powerful Lessons in Personal Change")
        dummyauthors.append("Stephen R. Covey ")
        dummytitles.append("Principles: Life and Work ")
        dummyauthors.append("Ray Dalio ")
        dummytitles.append("Outliers: The Story of Success")
        dummyauthors.append("Malcolm Gladwell ")
        dummytitles.append("Freakonomics: A Rogue Economist Explores the Hidden Side of Everything")
        dummyauthors.append("Steven D. Levitt")
        dummytitles.append("A Brief History of Time")
        dummyauthors.append("Stephen Hawking")
        dummytitles.append("The Intelligent Investor: The Definitive Book on Value Investing. A Book of Practical Counsel (Revised Edition) (Collins Business Essentials)")
        dummyauthors.append("Benjamin Graham")
        dummytitles.append("The Plant Paradox: The Hidden Dangers in Healthy Foods That Cause Disease and Weight Gain")
        dummyauthors.append("Steven R. Gundry MD MD ")
        dummytitles.append("The Obesity Code: Unlocking the Secrets of Weight Loss")
        dummyauthors.append("Dr. Jason Fung")
        dummytitles.append("Shoe Dog: A Memoir by the Creator of Nike")
        dummyauthors.append("Phil Knight")
        dummytitles.append("Alibaba: The House That Jack Ma Built")
        dummyauthors.append("Duncan Clark")
        dummytitles.append("Sam Walton: Made In America")
        dummyauthors.append("Sam Walton, John Huey")
        dummytitles.append("Wired for Love: How Understanding Your Partner's Brain and Attachment Style Can Help You Defuse Conflict and Build")
        dummyauthors.append("Stan Tatkin")
        dummytitles.append("The Four Agreements: A Practical Guide to Personal Freedom (A Toltec Wisdom Book)")
        dummyauthors.append("Don Miguel Ruiz")
        dummytitles.append("Sapiens: A Brief History of Humankind")
        dummyauthors.append("Yuval Noah Harari")
        dummytitles.append("48 Laws of Power")
        dummyauthors.append("Robert Greene")
        dummytitles.append("The Power of Now")
        dummyauthors.append("Eckhart Tolle")
        dummytitles.append("The Signal and the Noise: Why So Many Predictions Fail--but Some Don't")
        dummyauthors.append("Nate Silver")
        dummytitles.append("How Google Works")
        dummyauthors.append("Eric Schmidt")
        dummytitles.append("How to Change Your Mind")
        dummyauthors.append("Michael Pollan")

        dummycovers.append(UIImage(named: "1")!)
        dummycovers.append(UIImage(named: "2")!)
        dummycovers.append(UIImage(named: "3")!)
        dummycovers.append(UIImage(named: "4")!)
        dummycovers.append(UIImage(named: "5")!)
        dummycovers.append(UIImage(named: "6")!)
        dummycovers.append(UIImage(named: "7")!)
        dummycovers.append(UIImage(named: "8")!)
        dummycovers.append(UIImage(named: "9")!)
        dummycovers.append(UIImage(named: "10")!)
        dummycovers.append(UIImage(named: "11")!)
        dummycovers.append(UIImage(named: "12")!)
        dummycovers.append(UIImage(named: "13")!)
        dummycovers.append(UIImage(named: "14")!)
        dummycovers.append(UIImage(named: "15")!)
        dummycovers.append(UIImage(named: "16")!)
        dummycovers.append(UIImage(named: "w3")!)
        dummycovers.append(UIImage(named: "18")!)
        dummycovers.append(UIImage(named: "19")!)
        dummycovers.append(UIImage(named: "20")!)
        dummycovers.append(UIImage(named: "21")!)
        dummycovers.append(UIImage(named: "22")!)
        dummycovers.append(UIImage(named: "23")!)
        dummycovers.append(UIImage(named: "24")!)
        //        dummycovers.append(UIImage(named: "25")!)
        
        dummytitles.append("Elon Musk: Tesla, SpaceX, and the Quest for a Fantastic Future")
        dummyauthors.append("Ashlee Vance")
        dummytitles.append("Unshakeable: Your Financial Freedom Playbook ")
        dummyauthors.append("Tony Robbins")
        dummytitles.append("Tools of Titans: The Tactics, Routines, and Habits of Billionaires, Icons, and World-Class Performers")
        dummyauthors.append("Timothy Ferriss")
        dummytitles.append("Steve Jobs")
        dummyauthors.append("Walter Isaacson")
        dummytitles.append("How to Read Literature Like a Professor: A Lively and Entertaining Guide to Reading Between the Lines, Revised Edition")
        dummyauthors.append("Thomas C Foster")
        dummytitles.append("The 7 Habits of Highly Effective People: Powerful Lessons in Personal Change")
        dummyauthors.append("Stephen R. Covey ")
        dummytitles.append("Principles: Life and Work ")
        dummyauthors.append("Ray Dalio ")
        dummytitles.append("Outliers: The Story of Success")
        dummyauthors.append("Malcolm Gladwell ")
        dummytitles.append("Freakonomics: A Rogue Economist Explores the Hidden Side of Everything")
        dummyauthors.append("Steven D. Levitt")
        dummytitles.append("A Brief History of Time")
        dummyauthors.append("Stephen Hawking")
        dummytitles.append("The Intelligent Investor: The Definitive Book on Value Investing. A Book of Practical Counsel (Revised Edition) (Collins Business Essentials)")
        dummyauthors.append("Benjamin Graham")
        dummytitles.append("The Plant Paradox: The Hidden Dangers in Healthy Foods That Cause Disease and Weight Gain")
        dummyauthors.append("Steven R. Gundry MD MD ")
        dummytitles.append("The Obesity Code: Unlocking the Secrets of Weight Loss")
        dummyauthors.append("Dr. Jason Fung")
        dummytitles.append("Shoe Dog: A Memoir by the Creator of Nike")
        dummyauthors.append("Phil Knight")
        dummytitles.append("Alibaba: The House That Jack Ma Built")
        dummyauthors.append("Duncan Clark")
        dummytitles.append("Sam Walton: Made In America")
        dummyauthors.append("Sam Walton, John Huey")
        dummytitles.append("Wired for Love: How Understanding Your Partner's Brain and Attachment Style Can Help You Defuse Conflict and Build")
        dummyauthors.append("Stan Tatkin")
        dummytitles.append("The Four Agreements: A Practical Guide to Personal Freedom (A Toltec Wisdom Book)")
        dummyauthors.append("Don Miguel Ruiz")
        dummytitles.append("Sapiens: A Brief History of Humankind")
        dummyauthors.append("Yuval Noah Harari")
        dummytitles.append("48 Laws of Power")
        dummyauthors.append("Robert Greene")
        dummytitles.append("The Power of Now")
        dummyauthors.append("Eckhart Tolle")
        dummytitles.append("The Signal and the Noise: Why So Many Predictions Fail--but Some Don't")
        dummyauthors.append("Nate Silver")
        dummytitles.append("How Google Works")
        dummyauthors.append("Eric Schmidt")
        dummytitles.append("How to Change Your Mind")
        dummyauthors.append("Michael Pollan")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return dummytitles.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Books", for: indexPath) as! BooksCollectionViewCell
        cell.bookcover.layer.cornerRadius = 10.0
        cell.bookcover.layer.masksToBounds = true
        
        cell.dark.layer.cornerRadius = 10.0
        cell.dark.layer.masksToBounds = true
        
        cell.bookcover.image = dummycovers[indexPath.row]
        cell.bookauthor.text = dummyauthors[indexPath.row]
        cell.booktitle.text = dummytitles[indexPath.row]

        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
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
