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
import SwiftyStoreKit
import StoreKit
import FBSDKCoreKit
import UserNotifications

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

var sharedSecret = "a4cd3069d1b947d9b3e8b9223de7c35d"

var price = Double()
class PurchaseViewController: UIViewController {

    @IBOutlet weak var saleslabel: UILabel!
    let bundleID = "com.aatech.Eat"
    
    var threedaytrial = RegisteredPurchase.threedaytrial
    var sevendaytrial = RegisteredPurchase.sevendaytrial
    var onetimepurchase = RegisteredPurchase.OneTimePurchase
    var sevendayfreetrial = RegisteredPurchase.SevenDayFreeTrial
    let validator = AppleReceiptValidator(service: .production)
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    
    
    @IBAction func tapRestore(_ sender: Any) {
        
        restorePurchases()
        
    }
    @IBOutlet weak var tapterms: UIButton!
    @IBAction func tapTerms(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.tryeatfree.com/privacy-policy.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
        
    }

    @IBOutlet weak var tapPurchase: UIButton!
    @IBAction func tapButton1(_ sender: Any) {
        
        //        generator.impactOccurred()
        
        FBSDKAppEvents.logEvent("YearPressed")
        
        purchase(purchase: onetimepurchase)

    }
    @IBAction func tapButton2(_ sender: Any) {
                
        FBSDKAppEvents.logEvent("MonthlyPressed")
        
        purchase(purchase: threedaytrial)

        
        
    }
    @IBAction func tapButton3(_ sender: Any) {
        
        //        generator.impactOccurred()
        
        FBSDKAppEvents.logEvent("12MonthTrialPressed")
        
        purchase(purchase: sevendayfreetrial)
        
    }
    
    func getInfo(purchase : RegisteredPurchase) {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.retrieveProductsInfo([bundleID + "." + purchase.rawValue], completion: {
            result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            
            self.showAlert(alert: self.alertForProductRetrievalInfo(result: result))
            
            
        })
    }
    
    
    func purchase(purchase : RegisteredPurchase) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM//dd//yyyy"
        let dateresult = formatter.string(from: date)
        
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        
        print(bundleID + "." + purchase.rawValue)
        
        SwiftyStoreKit.purchaseProduct(bundleID + "." + purchase.rawValue,
                                       completion: {
                                        result in
                                        NetworkActivityIndicatorManager.networkOperationFinished()
                                        
                                        if case .success(let product) = result {
                                            
                                            if product.productId == self.bundleID + "." + "7DayTrial"{
                                                
                                                
                                                
                                            }
                                            if product.productId == self.bundleID + "." + "3DayTrial" {
                                                
                                                
                                                
                                            }
                                            
                                            if product.productId == self.bundleID + "." + "OneTimePurchase" {
                                                
                                                
                                                
                                            }
                                            
                                            if product.productId == self.bundleID + "." + "7DayFreeTrial" {
                                                
                                                
                                                
                                            }
                                            
                                            if product.needsFinishTransaction {
                                                
                                                SwiftyStoreKit.finishTransaction(product.transaction)
                                            }
                                            
                                            FBSDKAppEvents.logEvent("Purchased Completed")
                                        
                                            newuser = false
                                            
                                            self.showAlert(alert: self.alertForPurchaseResult(result: result))

                                            tryingtopurchase = true
                                            
                                            DispatchQueue.main.async {
                                                
                                                self.performSegue(withIdentifier: "PurchaseToLoging", sender: self)
                                                
                                            }
                                            
                                            
                                        } else {
                                            
                                            self.showAlert(alert: self.alertForPurchaseResult(result: result))
                                            

                                        }
                                        
                                        
        })
        
    }
    
    
    func restorePurchases() {
        
        var functioncounter = 0
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.restorePurchases(atomically: true, completion: {
            result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            
            for product in result.restoredPurchases {
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                    
                    functioncounter += 1
                    
                } else {
                    
                    functioncounter += 1
                    
                }
                
                self.showAlert(alert: self.alertForRestorePurchases(result: result))
                
                if functioncounter == result.restoredPurchases.count {
                    
                    //                    var email = "\(firstname)\(time)@gmail.com"
                    //                    var password = "$100kin4m"
                    //
                    //                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    //
                    //                        if let error = error {
                    //                            print(error)
                    //                            return
                    //
                    //                        } else {
                    //
                    //                            uid = (Auth.auth().currentUser?.uid)!
                    //
                    //                            //                            ref?.child("Users").child(uid).updateChildValues(["Name" : firstname, "Time" : time, "Location" : workoutlocation, "Goal" : goal, "Status" : activitylevel])
                    //
                    //                            DispatchQueue.main.async {
                    //
                    //                                self.performSegue(withIdentifier: "PurchaseToHome", sender: self)
                    //
                    //                            }
                    //                        }
                    //
                    //                    }
                }
                
            }
            
        })
        
    }
    
    
    
    func verifyReceipt() {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.verifyReceipt(using: validator, password: sharedSecret, completion: {
            result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            
            self.showAlert(alert: self.alertForVerifyReceipt(result: result))
            
            if case .error(let error) = result {
                if case .noReceiptData = error {
                    
                    
                    
                }
            }
            
        })
        
    }
    
    func verifyPurcahse(product : RegisteredPurchase) {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.verifyReceipt(using: validator, password: sharedSecret, completion: {
            result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            
            switch result{
            case .success(let receipt):
                
                let productID = self.bundleID + "." + product.rawValue
                
                if product == .sevendaytrial || product == .threedaytrial {
                    let purchaseResult = SwiftyStoreKit.verifySubscription(type: .autoRenewable, productId: productID, inReceipt: receipt, validUntil: Date())
                    self.showAlert(alert: self.alertForVerifySubscription(result: purchaseResult))
                    
                }
                    
                else {
                    
                    let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: productID, inReceipt: receipt)
                    self.showAlert(alert: self.alertForVerifyPurchase(result: purchaseResult))
                    
                }
            case .error(let error):
                self.showAlert(alert: self.alertForVerifyReceipt(result: result))
                if case .noReceiptData = error {
                    
                    
                }
                
            }
            
            
        })
        
    }
    
    @IBOutlet weak var customlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        
        self.becomeFirstResponder() // To get shake gesture

        let buttonTitleStr = NSMutableAttributedString(string:"By continuing, you accept our Terms of Use & Privacy Policy", attributes:attrs)
        attributedString.append(buttonTitleStr)
        tapterms.setAttributedTitle(attributedString, for: .normal)
        tapterms.setTitleColor(.gray, for: .normal)
        
        //        label.text = "By continuing you accept our Privacy Policy, Billing Terms, & Terms of Use"
        
        //        label.underline()
        
        FBSDKAppEvents.logEvent("Purchase Screen")
        
        
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
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func alertWithTitle(title : String, message : String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
        
    }
    func showAlert(alert : UIAlertController) {
        guard let _ = self.presentedViewController else {
            self.present(alert, animated: true, completion: nil)
            return
        }
        
    }
    func alertForProductRetrievalInfo(result : RetrieveResults) -> UIAlertController {
        
        
        if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            return alertWithTitle(title: product.localizedTitle, message: "\(product.localizedDescription) - \(priceString)")
            
        }
        else if let invalidProductID = result.invalidProductIDs.first {
            return alertWithTitle(title: "Could not retreive product info", message: "Invalid product identifier: \(invalidProductID)")
        }
        else {
            let errorString = result.error?.localizedDescription ?? "Unknown Error. Please Contact Support"
            return alertWithTitle(title: "Could not retreive product info" , message: errorString)
            
        }
        
    }
    func alertForPurchaseResult(result : PurchaseResult) -> UIAlertController {
        
        
        switch result {
            
        case .success(let product):
            print("Purchase Succesful: \(product.productId)")
            
            
            return alertWithTitle(title: "You're all set", message: "Your purchase was successful")
            
            
            
            
        case .error(let error):
            print("Purchase Failed: \(error)")
            
            switch error.code {
                
            case .unknown: return alertWithTitle(title: "Purchase Error", message: "Unknown error. Please contact support")
            case .clientInvalid: return alertWithTitle(title: "Purchase Error", message: "Not allowed to make the payment")
            case .paymentCancelled: return alertWithTitle(title: "Payment Cancelled", message: "Payment Cancelled")
            case .paymentInvalid: return alertWithTitle(title: "Purchase Error", message: "The purchase identifier was invalid")
            case .paymentNotAllowed: return alertWithTitle(title: "Purchase Error", message: "The device is not allowed to make the payment")
            case .storeProductNotAvailable: return alertWithTitle(title: "Purchase Error", message: "The product is not available in the current storefront")
            case .cloudServicePermissionDenied: return alertWithTitle(title: "Purchase Error", message: "Access to cloud service information is not allowed")
            case .cloudServiceNetworkConnectionFailed: return alertWithTitle(title: "Purchase Error", message: "Could not connect to the network")
            default: return alertWithTitle(title: "Purchase Error", message: "Unknown error")
            }
            
        }
    }
    func alertForRestorePurchases(result : RestoreResults) -> UIAlertController {
        if result.restoreFailedPurchases.count > 0 {
            print("Restore Failed: \(result.restoreFailedPurchases)")
            return alertWithTitle(title: "Restore Failed", message: "Unknown Error. Please Contact Support")
        }
        else if result.restoredPurchases.count > 0 {
            
            //
            return alertWithTitle(title: "Purchases Restored", message: "All purchases have been restored.")
            
            
        }
        else {
            return alertWithTitle(title: "Nothing To Restore", message: "No previous purchases were made.")
        }
        
    }
    func alertForVerifyReceipt(result: VerifyReceiptResult) -> UIAlertController {
        
        switch result {
        case.success(let receipt):
            return alertWithTitle(title: "Receipt Verified", message: "Receipt Verified Remotely")
        case .error(let error):
            switch error {
            case .noReceiptData:
                return alertWithTitle(title: "Receipt Verification", message: "No receipt data found, application will try to get a new one. Try Again.")
            default:
                return alertWithTitle(title: "Receipt verification", message: "Receipt Verification failed")
            }
        }
    }
    func alertForVerifySubscription(result: VerifySubscriptionResult) -> UIAlertController {
        switch result {
        case .purchased(let expiryDate):
            return alertWithTitle(title: "Product is Purchased", message: "Product is valid until \(expiryDate)")
        case .notPurchased:
            return alertWithTitle(title: "Not purchased", message: "This product has never been purchased")
        case .expired(let expiryDate):
            
            return alertWithTitle(title: "Product Expired", message: "Product is expired since \(expiryDate)")
        }
    }
    func alertForVerifyPurchase(result : VerifyPurchaseResult) -> UIAlertController {
        switch result {
        case .purchased:
            return alertWithTitle(title: "Product is Purchased", message: "Product will not expire")
        case .notPurchased:
            
            return alertWithTitle(title: "Product not purchased", message: "Product has never been purchased")
            
            
        }
        
    }
    func alertForRefreshRecepit(result : RefreshReceiptResult) -> UIAlertController {
        
        switch result {
        case .success(let receiptData):
            return alertWithTitle(title: "Receipt Refreshed", message: "Receipt refreshed successfully")
        case .error(let error):
            return alertWithTitle(title: "Receipt refresh failed", message: "Receipt refresh failed")
            
        }
    }
    
    var attrs = [
        NSAttributedStringKey.foregroundColor : UIColor.gray,
        NSAttributedStringKey.underlineStyle : 1] as [NSAttributedStringKey : Any]
    
    var attributedString = NSMutableAttributedString(string:"")
    
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





