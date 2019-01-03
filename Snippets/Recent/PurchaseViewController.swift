//
//  PurchaseViewController.swift
//  Sane
//
//  Created by Alek Matthiessen on 5/8/18.
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

var tryingtopurchase = Bool()

enum RegisteredPurchase: String {
    
    case sevendaytrial = "7DayTrial"
    
    case threedaytrial = "3DayTrial"
    
    case OneTimePurchase = "OneTimePurchase"
    
    case SevenDayFreeTrial = "7DayFreeTrial"

    
}

class NetworkActivityIndicatorManager: NSObject {
    
    private static var loadingCount = 0
    
    class func NetworkOperationStarted() {
        
        if loadingCount == 0 {
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        loadingCount += 1
    }
    
    class func networkOperationFinished() {
        
        if loadingCount > 0 {
            
            loadingCount -= 1
            
        }
        
        if loadingCount == 0 {
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
        }
    }
}

var sharedSecret = "8914f8ac3362492caf9e2eba38b4855c"

var price = Double()
class PurchaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var saleslabel: UILabel!
    let bundleID = "com.aatech.Quotes"
    
    var threedaytrial = RegisteredPurchase.threedaytrial
    var sevendaytrial = RegisteredPurchase.sevendaytrial
    var onetimepurchase = RegisteredPurchase.OneTimePurchase
    var sevendayfreetrial = RegisteredPurchase.SevenDayFreeTrial
//    let validator = AppleReceiptValidator(service: .production)
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    

    @IBAction func tapRestore(_ sender: Any) {
        
//        restorePurchases()
        
    }
    @IBOutlet weak var tapterms: UIButton!
    @IBAction func tapTerms(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.snippetsla.com/privacy-policy.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
        
    }

    @IBOutlet weak var tapPurchase: UIButton!
    @IBAction func tapButton1(_ sender: Any) {
        
        //        generator.impactOccurred()
        
        FBSDKAppEvents.logEvent("Lifetime Pressed")
        
//        purchase(purchase: onetimepurchase)
        
 

    }
    @IBAction func tapButton2(_ sender: Any) {
        
        
       
        FBSDKAppEvents.logEvent("Yearl Pressed")
        
        //        purchase(purchase: threedaytrial)
        
        //        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        purchases.entitlements { entitlements in
            guard let pro = entitlements?["Subscriptions"] else { return }
            guard let monthly = pro.offerings["Weekly"] else { return }
            guard let product = monthly.activeProduct else { return }
            self.purchases.makePurchase(product)
            
            
        }
        
    }
    @IBAction func tapButton3(_ sender: Any) {
        
        //        generator.impactOccurred()
        
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Terms", for: indexPath) as! TermsTableViewCell
        
        cell.textlabel.text = "Recurring Billing. Cancel anytime. Payment will be charged to iTunes Account at confirmation of purchase. Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase. Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable To learn more, check out our terms of use."
        return cell
    }
    
    

    
    func yomofucker() {
    
    DispatchQueue.main.async {
    
    self.performSegue(withIdentifier: "PurchaseToLoging", sender: self)
    
        }
    }
    
    
    
    
//
//    func verifyReceipt() {
//        NetworkActivityIndicatorManager.NetworkOperationStarted()
//        SwiftyStoreKit.verifyReceipt(using: validator, paforceRefreshsharedSecret, completion: {
//            result in
//            NetworkActivityIndicatorManager.networkOperationFinished()
//
//            self.showAlert(alert: self.alertForVerifyReceipt(result: result))
//
//            if case .error(let error) = result {
//                if case .noReceiptData = error {
//
//
//
//                }
//            }
//
//        })
//
//    }
    
    
    
//    func verifyPurcahse(product : RegisteredPurchase) {
//        NetworkActivityIndicatorManager.NetworkOperationStarted()
//        SwiftyStoreKit.verifyReceipt(using: validator, forceRefresh: sharedSecret, completion: {
//            result in
//            NetworkActivityIndicatorManager.networkOperationFinished()
//            
//            switch result{
//            case .success(let receipt):
//                
//                let productID = self.bundleID + "." + product.rawValue
//                
//                if product == .sevendaytrial || product == .threedaytrial {
//                    let purchaseResult = SwiftyStoreKit.verifySubscription(type: .autoRenewable, productId: productID, inReceipt: receipt, validUntil: Date())
//                    self.showAlert(alert: self.alertForVerifySubscription(result: purchaseResult))
//                    
//                }
//                    
//                else {
//                    
//                    let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: productID, inReceipt: receipt)
//                    self.showAlert(alert: self.alertForVerifyPurchase(result: purchaseResult))
//                    
//                }
//            case .error(let error):
//                self.showAlert(alert: self.alertForVerifyReceipt(result: result))
//                if case .noReceiptData = error {
//                    
//                    
//                }
//                
//            }
//            
//            
//        })
//        
//    }
    var purchases = RCPurchases(apiKey: "RDlbQdhQOSZKZUtWvzWnfocZNPLbDFfw")

    @IBAction func tapBack(_ sender: Any) {
        
//        self.dismiss(animated: true, completion: {
//            
//        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let url = NSURL(string: "https://www.snippetsla.com/privacy-policy.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    @IBOutlet weak var backlabel: UILabel!
    @IBOutlet weak var backgroundimage: UIImageView!
    @IBOutlet weak var descriptivetext: UILabel!
    @IBOutlet weak var customlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        backlabel.layer.cornerRadius = 10.0
        backlabel.layer.masksToBounds = true

        self.becomeFirstResponder() // To get shake gesture

        let buttonTitleStr = NSMutableAttributedString(string:"By continuing, you accept our Terms of Use & Privacy Policy", attributes:attrs)
        attributedString.append(buttonTitleStr)
        tapterms.setAttributedTitle(attributedString, for: .normal)
        tapterms.setTitleColor(.gray, for: .normal)
        tapterms.alpha = 0.75
        
        //        label.text = "By continuing you accept our Privacy Policy, Billing Terms, & Terms of Use"
        
        //        label.underline()
        
        FBSDKAppEvents.logEvent("Purchase Screen")
        
        backgroundimage.image = selectedimage
        
        tapterms.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left



        if selectedtitle != "" {
        let first = "Unlock the big ideas from "
        let second = "\(selectedtitle) "
        let third = "and 2500+ other best selling books!"
        var characters = second.count
        
        let boldItalicsFont = UIFont(name: "AvenirNext-BoldItalic", size: 23.0)!
        
        let buttonTitleStr2 = NSMutableAttributedString(string:first + second + third, attributes:attrs2)
        
        attributedString2.append(buttonTitleStr2)
        descriptivetext.attributedText = attributedString2
            
        } else {
            
            descriptivetext.text = "Unlock the big ideas from over 2500+ best selling books"

        }
        // Do any additional setup after loading the view.
    }
    
    func login() {
        
        var email = "demo@gmail.com"
        var password = "password"
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                
                
                return
                
            } else {
                
                uid = (Auth.auth().currentUser?.uid)!
                
                let date = Date()
                let calendar = Calendar.current
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yy"
                var todaysdate =  dateFormatter.string(from: date)
                
                
                DispatchQueue.main.async {
                    
                    self.performSegue(withIdentifier: "PurchaseToHome8", sender: self)
                    
                }
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBOutlet weak var continuereading: UILabel!
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
  
//    func alertForRefreshRecepit(result : RefreshReceiptResult) -> UIAlertController {
//
//        switch result {
//        case .success(let receiptData):
//            return alertWithTitle(title: "Receipt Refreshed", message: "Receipt refreshed successfully")
//        case .error(let error):
//            return alertWithTitle(title: "Receipt refresh failed", message: "Receipt refresh failed")
//
//        }
//    }
    
    var attrs = [
        NSAttributedStringKey.foregroundColor : UIColor.white,
        NSAttributedStringKey.underlineStyle : 1] as [NSAttributedStringKey : Any]
    
    var attrs2 = [NSAttributedStringKey.font : UIFont(name: "AvenirNext-Bold", size: 17.0),
        NSAttributedStringKey.foregroundColor : UIColor.white] as [NSAttributedStringKey : Any]
    
    var attributedString = NSMutableAttributedString(string:"")
    var attributedString2 = NSMutableAttributedString(string:"")

    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            
            takeScreenshot(true)

            showalert()
            
        }
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
