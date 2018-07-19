//
//  CodeViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 6/10/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

var legitcodes = [String]()
var legitcodeids = [String]()
class CodeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var errorlabel: UILabel!
    
    @IBAction func tapLogin(_ sender: Any) {
        
        if codetf.text != "" {
            
            var code = codetf.text
            
            if legitcodes.contains(code!) {
                
                newuser = false

                self.performSegue(withIdentifier: "CodeToLogin", sender: self)
                
                
            } else {
                
                errorlabel.alpha = 1
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    @IBOutlet weak var codetf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder() // To get shake gesture

        ref = Database.database().reference()
        errorlabel.alpha = 0
        legitcodes.removeAll()
        legitcodeids.removeAll()
        // Do any additional setup after loading the view.
        
        queryforacceptableids { () -> () in
            
            self.queryforidvalues()
            
        }
    }

    func queryforacceptableids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        ref?.child("AcceptableIDS").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    legitcodeids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
    }
    
    func queryforidvalues() {
        
        var functioncounter = 0
        
        for each in legitcodeids {
            
            ref?.child("AcceptableIDS").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var activityvalue = value?["Code"] as? String {
                    
                    legitcodes.append(activityvalue)
                    
                }
                
            })
            
            
        }
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
