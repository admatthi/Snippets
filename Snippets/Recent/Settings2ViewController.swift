//
//  Settings2ViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 6/19/18.
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

class Settings2ViewController: UIViewController {
    @IBAction func tapBilling(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.snippetsla.com/billing-terms.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    @IBAction func tapAbout(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.snippetsla.com"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func tapLogout(_ sender: Any) {
        
        try! Auth.auth().signOut()

        self.performSegue(withIdentifier: "Settingstoregister", sender: self)
    }
    @IBAction func tapSubscription(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.snippetsla.com/subscription.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func tapTerms(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.snippetsla.com/terms.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func tapGives(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.snippetsla.com/gives.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func tapPrivacy(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.snippetsla.com/privacy-policy.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    @IBOutlet weak var taplogout: UIButton!
    @IBOutlet weak var taplogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        if didpurchase {
            
            taplogin.alpha = 0
            
        } else {
            
            taplogout.alpha = 0
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
