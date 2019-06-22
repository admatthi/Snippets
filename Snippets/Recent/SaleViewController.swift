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

class SaleViewController: UIViewController  {

    
    @IBOutlet weak var tapcontinue: UIButton!
    override func viewDidAppear(_ animated: Bool) {
        
        tapcontinue.flash()
    }
    @IBAction func tapBuyLifetimely(_ sender: Any) {
        
        
        //        purchase(purchase: threedaytrial)
        
        //        let delegate = UIApplication.shared.delegate as! AppDelegate
        
      
        
    }
    
    var month = Bool()
    var year = Bool()
    var Lifetime = Bool()
    
    var purchases = Purchases.configure(withAPIKey: "LaEomxfMQACzbGFnmmffVNcCEopCcCMc", appUserID: nil)

    @IBAction func tapLifetime(_ sender: Any) {
        
        Lifetime = true
        month = false
        year = false
        tapLifetime.setImage(UIImage(named: "LifeTimeT"), for: .normal)
        tapmonth.setImage(UIImage(named:"Months"), for: .normal)
        tapyear.setImage(UIImage(named:"Year"), for: .normal)
        
    }
    
    @IBAction func tapYear(_ sender: Any) {
        
        year = true
        month = false
        Lifetime = false
        tapLifetime.setImage(UIImage(named: "Lifetime"), for: .normal)
        tapmonth.setImage(UIImage(named:"Months"), for: .normal)
        tapyear.setImage(UIImage(named:"YearT"), for: .normal)
    }
    var counter = Int()
    
    @IBOutlet weak var valueimage: UIImageView!
    @IBAction func tapMonth(_ sender: Any) {
        
        month = true
        year = false
        Lifetime = false
        tapLifetime.setImage(UIImage(named: "Lifetime"), for: .normal)
        tapmonth.setImage(UIImage(named:"MonthsT"), for: .normal)
        tapyear.setImage(UIImage(named:"Year"), for: .normal)
    }

    @IBOutlet weak var tapLifetime: UIButton!
    
    @IBOutlet weak var popular: UIImageView!
    @IBOutlet weak var tapyear: UIButton!
    @IBOutlet weak var tapmonth: UIButton!
    @IBAction func tapContinue(_ sender: Any) {
        
        if month {
            
            purchases.entitlements { (entitlements, error) in
                guard let pro = entitlements?["premium"] else { return }
                guard let monthly = pro.offerings["monthly"] else { return }
                guard let product = monthly.activeProduct else { return }
                
                self.purchases.makePurchase(product, { (transaction, purchaserInfo, error, cancelled) in
                    if let purchaserInfo = purchaserInfo {
                        
                        print("x")
                        
                        
                        if purchaserInfo.activeEntitlements.contains("my_entitlement_identifier") {
                            // Unlock that great "pro" content
                            
                            
                            
                            
//                            ref?.child("users").child(uid).updateChildValues(["Account Balance" : newcoin])
                            
                            self.performSegue(withIdentifier: "PayToHome", sender: self)
                            
                            print("n")
                        } else {
                            
                            
//                            ref?.child("users").child(uid).updateChildValues(["Account Balance" : newcoin])
                            
                            self.performSegue(withIdentifier: "PayToHome", sender: self)
                            
                            print("y")
                        }
                        
                    } else {
                        
                        //                    self.performSegue(withIdentifier: "PayToHome", sender: self)
                        //
                        //                    print("n")
                    }
                })
                
            }
        }
        if Lifetime {
            
            
            purchases.entitlements { (entitlements, error) in
                guard let pro = entitlements?["premium"] else { return }
                guard let monthly = pro.offerings["Lifetimely"] else { return }
                guard let product = monthly.activeProduct else { return }
                
                self.purchases.makePurchase(product, { (transaction, purchaserInfo, error, cancelled) in
                    if let purchaserInfo = purchaserInfo {
                        
                        print("x")
                        
                        
                        if purchaserInfo.activeEntitlements.contains("my_entitlement_identifier") {
                            // Unlock that great "pro" content
                            
                            
                            
                            
//                            ref?.child("users").child(uid).updateChildValues(["Account Balance" : newcoin])
                            
                            self.performSegue(withIdentifier: "PayToHome", sender: self)
                            
                            print("n")
                        } else {
                            
                            
//                            ref?.child("users").child(uid).updateChildValues(["Account Balance" : newcoin])
                            
                            self.performSegue(withIdentifier: "PayToHome", sender: self)
                            
                            print("y")
                        }
                        
                    } else {
                        
                        //                    self.performSegue(withIdentifier: "PayToHome", sender: self)
                        //
                        //                    print("n")
                    }
                })
                
            }
        }
        
        if year {
            
            purchases.entitlements { (entitlements, error) in
                guard let pro = entitlements?["premium"] else { return }
                guard let monthly = pro.offerings["yearly"] else { return }
                guard let product = monthly.activeProduct else { return }
                
                self.purchases.makePurchase(product, { (transaction, purchaserInfo, error, cancelled) in
                    if let purchaserInfo = purchaserInfo {
                        
                        print("x")
                        
                        
                        if purchaserInfo.activeEntitlements.contains("my_entitlement_identifier") {
                            // Unlock that great "pro" content
                            
                            
//                            ref?.child("users").child(uid).updateChildValues(["Account Balance" : newcoin])
                            
                            
                            
                            self.performSegue(withIdentifier: "PayToHome", sender: self)
                            
                            print("n")
                        } else {
                            
                            
//                            ref?.child("users").child(uid).updateChildValues(["Account Balance" : newcoin])
                            
                            self.performSegue(withIdentifier: "PayToHome", sender: self)
                            
                            print("y")
                        }
                        
                    } else {
                        
                        //                    self.performSegue(withIdentifier: "PayToHome", sender: self)
                        //
                        //                    print("n")
                    }
                })
                
            }
        }
    }
    
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    var ref: DatabaseReference?
    var category = String()
    
    var bookmarktapped = Bool()
    

    @IBAction func tapTerms(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.mysnippetsapp.weebly.com/privacy-policy.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        year = true
        
    }
    
    
    
    @IBOutlet weak var counterimage: UIImageView!

    @objc func shownext (){
        
        if counter < 8 {
            
            counter += 1
            valueimage.image = UIImage(named: "counter\(counter)")
            
            counterimage.image = UIImage(named: "valuecounter\(counter)")
            
        } else {
            
            counter = 1
            counter += 1
            valueimage.image = UIImage(named: "counter\(counter)")
            
            counterimage.image = UIImage(named: "valuecounter\(counter)")
        }
        
    }

    
}

extension UIButton {
    
    func flash() {
        // Take as snapshot of the button and render as a template
        let snapshot = self.snapshot?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: snapshot)
        // Add it image view and render close to white
        imageView.tintColor = UIColor(white: 0.9, alpha: 1.0)
        guard let image = imageView.snapshot  else { return }
        let width = image.size.width
        let height = image.size.height
        // Create CALayer and add light content to it
        let shineLayer = CALayer()
        shineLayer.contents = image.cgImage
        shineLayer.frame = bounds
        
        // create CAGradientLayer that will act as mask clear = not shown, opaque = rendered
        // Adjust gradient to increase width and angle of highlight
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.clear.cgColor,
                                UIColor.black.cgColor,
                                UIColor.clear.cgColor,
                                UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 0.35, 0.50, 0.65, 0.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        gradientLayer.frame = CGRect(x: -width, y: 0, width: width, height: height)
        // Create CA animation that will move mask from outside bounds left to outside bounds right
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.byValue = width * 2
        // How long it takes for glare to move across button
        animation.duration = 3
        // Repeat forever
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        layer.addSublayer(shineLayer)
        shineLayer.mask = gradientLayer
        
        // Add animation
        gradientLayer.add(animation, forKey: "shine")
    }
    
    func stopFlash() {
        // Search all sublayer masks for "shine" animation and remove
        layer.sublayers?.forEach {
            $0.mask?.removeAnimation(forKey: "shine")
        }
    }
}


extension UIView {
    // Helper to snapshot a view
    var snapshot: UIImage? {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        
        let image = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return image
    }
    
}
