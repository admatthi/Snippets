//
//  AppDelegate.swift
//  Snippets
//
//  Created by Alek Matthiessen on 7/18/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FBSDKCoreKit
import StoreKit
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import AVFoundation
import Purchases

var uid = String()
var ref: DatabaseReference?
var didpurchase = Bool()

var newuser = Bool()
var todaysdate = String()
var screenshot = UIImage()
var tryingtopurchase = Bool()

protocol SnippetsPurchasesDelegate: AnyObject {
    
    func purchaseCompleted(product: String)
    
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var purchases: RCPurchases?

    weak var purchasesdelegate : SnippetsPurchasesDelegate?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
   
        
        
        FirebaseApp.configure()
        
        FBSDKAppEvents.activateApp()
        
        purchases = RCPurchases(apiKey: "RDlbQdhQOSZKZUtWvzWnfocZNPLbDFfw")

        purchases!.delegate = self
        
//        
//        UITabBar.appearance().barTintColor = UIColor.black
//        UITabBar.appearance().tintColor = UIColor.black
    
        
//        UITabBar.appearance().isTranslucent = false
//        UITabBar.appearance().backgroundColor = UIColor.clear
//        UITabBar.appearance().backgroundImage = UIImage(named: "tabbar")
//        UITabBar.appearance().contentMode = .scaleAspectFit
        
        ref = Database.database().reference()

        
        if Auth.auth().currentUser == nil {

//            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//
//            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Teaser") as UIViewController
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            self.window?.rootViewController = initialViewControlleripad
//            self.window?.makeKeyAndVisible()//

            
            var tabBar: UITabBarController = self.window?.rootViewController as! UITabBarController
            
            
            tabBar.selectedIndex = 0
            
        }  else {

            uid = (Auth.auth().currentUser?.uid)!

            queryforinfo()



        }
        
        return true
    }
    
    func queryforinfo() {
        
        var functioncounter = 0
        
        ref?.child("Snippets").child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var purchased = value?["Purchased"] as? String {
                
                if purchased == "Yes" {
                    
                    didpurchase = true
                    
                    
                    var tabBar: UITabBarController = self.window?.rootViewController as! UITabBarController
                    
                    
                    tabBar.selectedIndex = 0
//                    
//                    let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    
//                    
//                    let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Buyer") as UIViewController
//                    self.window = UIWindow(frame: UIScreen.main.bounds)
//                    self.window?.rootViewController = initialViewControlleripad
//                    self.window?.makeKeyAndVisible()
                    
                } else {
                    
                    didpurchase = true
                    
                    var tabBar: UITabBarController = self.window?.rootViewController as! UITabBarController
                    
                    tabBar.selectedIndex = 0
                    
                  
                }
                
            } else {
                
                didpurchase = false
                var tabBar: UITabBarController = self.window?.rootViewController as! UITabBarController
                
                tabBar.selectedIndex = 0
             
              
                
            }
                
            })
            
        }
    
    func letsgo() {
        

        if Auth.auth().currentUser != nil {

            didpurchase = true

    ref?.child("Snippets").child("Users").child(uid).updateChildValues(["Purchased" : "Yes"])

                        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            
                        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Register") as UIViewController
                        self.window = UIWindow(frame: UIScreen.main.bounds)
                        self.window?.rootViewController = initialViewControlleripad
                        self.window?.makeKeyAndVisible()//
            
        }
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            
            guard settings.authorizationStatus == .authorized else { return }
            
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
}

class SegueFromLeft: UIStoryboardSegue
{
    override func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}

class SegueFromRight: UIStoryboardSegue
{
    override func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}

class NoSegue: UIStoryboardSegue
{
    override func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        
        UIView.animate(withDuration: 0.0,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}

class SegueFromTop: UIStoryboardSegue
{
    override func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: 0, y: -src.view.frame.size.height)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}


extension AppDelegate: RCPurchasesDelegate {
    func purchases(_ purchases: RCPurchases, completedTransaction transaction: SKPaymentTransaction, withUpdatedInfo purchaserInfo: RCPurchaserInfo) {
        
        self.purchasesdelegate?.purchaseCompleted(product: transaction.payment.productIdentifier)
        
        didpurchase = true
        
        print("purchased")
        tryingtopurchase  = true
        letsgo()
        
    }

    func purchases(_ purchases: RCPurchases, receivedUpdatedPurchaserInfo purchaserInfo: RCPurchaserInfo) {
//        handlePurchaserInfo(purchaserInfo)
        
        print(purchaserInfo)
        
    }

    func purchases(_ purchases: RCPurchases, failedToUpdatePurchaserInfoWithError error: Error) {
        print(error)
        
        tryingtopurchase = false
    }

    func purchases(_ purchases: RCPurchases, failedTransaction transaction: SKPaymentTransaction, withReason failureReason: Error) {
        print(failureReason)
        
        tryingtopurchase = false
    }

    func purchases(_ purchases: RCPurchases, restoredTransactionsWith purchaserInfo: RCPurchaserInfo) {
//        handlePurchaserInfo(purchaserInfo)
        
        print("restored")
        tryingtopurchase  = true
        letsgo()

        
    }

    func purchases(_ purchases: RCPurchases, failedToRestoreTransactionsWithError error: Error) {
        print(error)
    }
}



