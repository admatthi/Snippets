//
//  SaleViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 11/11/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import UserNotifications
import StoreKit
import FBSDKCoreKit
import UserNotifications
import Purchases

var myblue2 = UIColor(red:0.19, green:0.39, blue:1.00, alpha:1.0)

class SaleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var attrs = [
        NSAttributedStringKey.foregroundColor : UIColor.lightGray,
        NSAttributedStringKey.underlineStyle : 1] as [NSAttributedStringKey : Any]
    
    var attrs2 = [NSAttributedStringKey.font : UIFont(name: "AvenirNext-Bold", size: 17.0),
                  NSAttributedStringKey.foregroundColor : UIColor.black] as [NSAttributedStringKey : Any]
    
    var attributedString = NSMutableAttributedString(string:"")
    var attributedString2 = NSMutableAttributedString(string:"")
    
    
    @IBOutlet weak var progressView: UIProgressView!
    

    
    var purchases = RCPurchases(apiKey: "RDlbQdhQOSZKZUtWvzWnfocZNPLbDFfw")
    
    @IBAction func tapLogin(_ sender: Any) {
    }
    @IBOutlet weak var tapyearly: UIButton!
    @IBAction func tapBuyYearly(_ sender: Any) {
        
        FBSDKAppEvents.logEvent("Yearly Pressed")
        
        //        purchase(purchase: threedaytrial)
        
        //        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        purchases.entitlements { entitlements in
            guard let pro = entitlements?["Subscriptions"] else { return }
            guard let monthly = pro.offerings["Yearly"] else { return }
            guard let product = monthly.activeProduct else { return }
            self.purchases.makePurchase(product)
            
            
        }
    }
    @IBAction func tapBuy(_ sender: Any) {
        
        FBSDKAppEvents.logEvent("Monthly Pressed")
        
        //        purchase(purchase: threedaytrial)
        
        //        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        purchases.entitlements { entitlements in
            guard let pro = entitlements?["Subscriptions"] else { return }
            guard let monthly = pro.offerings["Monthly"] else { return }
            guard let product = monthly.activeProduct else { return }
            self.purchases.makePurchase(product)
            
            
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var ref: DatabaseReference?
    var category = String()
    
    var bookmarktapped = Bool()
    
    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    
    @IBAction func tapTerms(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.mysnippetsapp.weebly.com/privacy-policy.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    
    @IBOutlet weak var savetext2: UIButton!
    @IBAction func savetext(_ sender: Any) {
    }
    @IBOutlet weak var tapterms: UIButton!
    @IBOutlet weak var tapbuy: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        savetext2.layer.cornerRadius = 5.0
        savetext2.layer.masksToBounds = true
        tapbuy.layer.borderColor = myblue2.cgColor
        
        tapbuy.layer.borderWidth = 2.0
        tapbuy.layer.cornerRadius = 5.0
        tapbuy.layer.masksToBounds = true
        tapyearly.layer.cornerRadius = 5.0
        tapyearly.layer.masksToBounds = true
        
        tapterms.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        
        let buttonTitleStr = NSMutableAttributedString(string:"By continuing, you accept our Terms of Use & Privacy Policy", attributes:attrs)
        attributedString.append(buttonTitleStr)
        tapterms.setAttributedTitle(attributedString, for: .normal)
        tapterms.setTitleColor(.black, for: .normal)
        
        
        
        //        whitelabel.layer.cornerRadius = 10.0
        //        whitelabel.layer.masksToBounds = true
        
//        titlelabel.text = selectedtitle
//        authorlabel.text = selectedauthor
//        cover.image = selectedimage
//        cover.layer.cornerRadius = 5.0
//        cover.layer.masksToBounds = true
        
        
//        whatthehell()
        
        sixbookcovers.removeAll()
        
        sixbookcovers.append(UIImage(named: "B1")!)
        sixbookcovers.append(UIImage(named: "B2")!)
        sixbookcovers.append(UIImage(named: "B3")!)
        sixbookcovers.append(UIImage(named: "B4")!)
        sixbookcovers.append(UIImage(named: "B5")!)
        sixbookcovers.append(UIImage(named: "B6")!)
        sixbookcovers.append(UIImage(named: "B7")!)
        sixbookcovers.append(UIImage(named: "B8")!)
        sixbookcovers.append(UIImage(named: "B9")!)
        sixbookcovers.append(UIImage(named: "B10")!)
        sixbookcovers.append(UIImage(named: "B11")!)
        sixbookcovers.append(UIImage(named: "B12")!)
        sixbookcovers.append(UIImage(named: "B13")!)
        sixbookcovers.append(UIImage(named: "B14")!)
        sixbookcovers.append(UIImage(named: "B15")!)
        sixbookcovers.append(UIImage(named: "B16")!)
        sixbookcovers.append(UIImage(named: "B17")!)
        sixbookcovers.append(UIImage(named: "B18")!)
        sixbookcovers.append(UIImage(named: "B19")!)
        sixbookcovers.append(UIImage(named: "B20")!)

        
        sixbookcovers.append(UIImage(named: "F1")!)
        sixbookcovers.append(UIImage(named: "F2")!)
        sixbookcovers.append(UIImage(named: "F3")!)
        sixbookcovers.append(UIImage(named: "F4")!)
        sixbookcovers.append(UIImage(named: "F5")!)
        sixbookcovers.append(UIImage(named: "F6")!)
        sixbookcovers.append(UIImage(named: "F7")!)
        sixbookcovers.append(UIImage(named: "F8")!)
        sixbookcovers.append(UIImage(named: "F9")!)
        sixbookcovers.append(UIImage(named: "F10")!)

        
        sixbookcovers.append(UIImage(named: "H1")!)
        sixbookcovers.append(UIImage(named: "H2")!)
        sixbookcovers.append(UIImage(named: "H3")!)
        sixbookcovers.append(UIImage(named: "H4")!)
        sixbookcovers.append(UIImage(named: "H5")!)
        sixbookcovers.append(UIImage(named: "H6")!)
        sixbookcovers.append(UIImage(named: "H7")!)
        sixbookcovers.append(UIImage(named: "H8")!)
        sixbookcovers.append(UIImage(named: "H9")!)
        sixbookcovers.append(UIImage(named: "H10")!)
        sixbookcovers.append(UIImage(named: "H11")!)
        sixbookcovers.append(UIImage(named: "H12")!)
        
        sixbookcovers.append(UIImage(named: "H13")!)
        sixbookcovers.append(UIImage(named: "H14")!)
        sixbookcovers.append(UIImage(named: "H15")!)
        sixbookcovers.append(UIImage(named: "H16")!)
        sixbookcovers.append(UIImage(named: "H17")!)
        sixbookcovers.append(UIImage(named: "H18")!)
        sixbookcovers.append(UIImage(named: "H19")!)
        sixbookcovers.append(UIImage(named: "H20")!)
        sixbookcovers.append(UIImage(named: "H21")!)
        sixbookcovers.append(UIImage(named: "H22")!)
        sixbookcovers.append(UIImage(named: "H23")!)
        sixbookcovers.append(UIImage(named: "H24")!)
        
        sixbookcovers.append(UIImage(named: "M1")!)
        sixbookcovers.append(UIImage(named: "M2")!)
        sixbookcovers.append(UIImage(named: "M3")!)
        sixbookcovers.append(UIImage(named: "M4")!)
        sixbookcovers.append(UIImage(named: "M5")!)
        sixbookcovers.append(UIImage(named: "M6")!)
        sixbookcovers.append(UIImage(named: "M7")!)
        sixbookcovers.append(UIImage(named: "M8")!)
        sixbookcovers.append(UIImage(named: "M9")!)
        sixbookcovers.append(UIImage(named: "M10")!)
        sixbookcovers.append(UIImage(named: "M11")!)
        sixbookcovers.append(UIImage(named: "M12")!)
        sixbookcovers.append(UIImage(named: "M13")!)
        sixbookcovers.append(UIImage(named: "M14")!)
        sixbookcovers.append(UIImage(named: "M15")!)
        sixbookcovers.append(UIImage(named: "M16")!)
        sixbookcovers.append(UIImage(named: "M17")!)
        sixbookcovers.append(UIImage(named: "M18")!)
        sixbookcovers.append(UIImage(named: "M19")!)
        sixbookcovers.append(UIImage(named: "M20")!)
        sixbookcovers.append(UIImage(named: "M21")!)
        sixbookcovers.append(UIImage(named: "M22")!)
        sixbookcovers.append(UIImage(named: "M23")!)
        sixbookcovers.append(UIImage(named: "M24")!)
        
        
        sixbookcovers.append(UIImage(named: "MH1")!)
        sixbookcovers.append(UIImage(named: "MH2")!)
        sixbookcovers.append(UIImage(named: "MH3")!)
        sixbookcovers.append(UIImage(named: "MH4")!)
        sixbookcovers.append(UIImage(named: "MH5")!)
        sixbookcovers.append(UIImage(named: "MH6")!)
        sixbookcovers.append(UIImage(named: "MH7")!)
        sixbookcovers.append(UIImage(named: "MH8")!)
        sixbookcovers.append(UIImage(named: "MH9")!)
        sixbookcovers.append(UIImage(named: "MH10")!)
        sixbookcovers.append(UIImage(named: "MH11")!)
        sixbookcovers.append(UIImage(named: "MH12")!)
        
        collectionView.reloadData()
        
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sixbookcovers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Books", for: indexPath) as! BooksCollectionViewCell
            
        cell.bookcover.layer.cornerRadius = 10.0
        cell.bookcover.layer.masksToBounds = true
            cell.bookcover.image = sixbookcovers[indexPath.row]
            
            return cell
        }
    
}

