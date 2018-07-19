//
//  LoginViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 5/20/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

var bodymonthlygoal = String()
var careermonthlygoal = String()
var happinessmonthlygoal = String()
var peoplemonthlygoal = String()

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBAction func tapLogin(_ sender: Any) {
        
        login()
    }
    @IBAction func tapSignUp(_ sender: Any) {
        
        signup()
    }


    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var emailtf: UITextField!
    
    func login() {
        
        var email = "\(emailtf.text!)"
        var password = "\(passwordtf.text!)"
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                
                
                self.errorlabel.alpha = 1
                self.errorlabel.text = error.localizedDescription
                
                return
                
            } else {
                
                uid = (Auth.auth().currentUser?.uid)!
                
                let date = Date()
                let calendar = Calendar.current
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yy"
                var todaysdate =  dateFormatter.string(from: date)
                
                newuser = false
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "LoginToDiscover", sender: self)
                    
                }
            }
            
        }
        
    }
    
    @IBOutlet weak var errorlabel: UILabel!
    func signup() {
        
        
        var email = "\(emailtf.text!)"
        var password = "\(passwordtf.text!)"
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                
                self.errorlabel.alpha = 1
                self.errorlabel.text = error.localizedDescription
                
                return
                
            } else {
                
                uid = (Auth.auth().currentUser?.uid)!
                
                let date = Date()
                let calendar = Calendar.current
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yy"
                var todaysdate =  dateFormatter.string(from: date)
                let thirtyDaysAfterToday = Calendar.current.date(byAdding: .day, value: +30, to: date)!
                let thirty = dateFormatter.string(from: thirtyDaysAfterToday)
                
                
                if bodymonthlygoal != "" && careermonthlygoal != "" && happinessmonthlygoal != "" && careermonthlygoal != "" {
                    
                    ref?.child("Users").child(uid).updateChildValues(["LastOpened" : todaysdate, "BodyMonthlyGoal" : bodymonthlygoal, "CareerMonthlyGoal" : careermonthlygoal, "PeopleMonthlyGoal" : peoplemonthlygoal, "HappinessMonthlyGoal" : happinessmonthlygoal, "FirstMonth" : thirty])
                    
                }
                

                newuser = false

                DispatchQueue.main.async {
                    
        self.performSegue(withIdentifier: "LoginToDiscover", sender: self)
                }
            }
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    @IBOutlet weak var tapcreate: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        
        emailtf.delegate = self
        passwordtf.delegate = self
        emailtf.becomeFirstResponder()
        
        errorlabel.alpha = 0
        
        FBSDKAppEvents.logEvent("LoginScreen")
        
        if tryingtopurchase {
            
            tapcreate.alpha = 1
            
        } else {
            
            tapcreate.alpha = 0 
        }
//        if newuser == true {
//            
//            tapcreate.alpha = 0
//            
//        } else {
//            
//            tapcreate.alpha = 1
//        }
//        
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
    
}

