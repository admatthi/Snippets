//
//  ContactUsViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 1/1/19.
//  Copyright © 2019 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

class ContactUsViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var tapBack: UIButton!
    
    @IBOutlet weak var thankyoulabel: UILabel!
    @IBOutlet weak var tv: UITextView!
    @IBAction func tapback(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            
        })
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Your message here..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBOutlet weak var requestlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        tv.text = "Your message here..."
        
        tv.textColor = UIColor.lightGray
        thankyoulabel.alpha = 0
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.layer.borderWidth = 0.5
        
        tv.delegate = self
        taps.addTextSpacing(2.0)
                header.addCharacterSpacing()
        // Do any additional setup after loading the view.
        
    }
    
    //    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var taps: UIButton!
    @IBAction func tapSubmit(_ sender: Any) {
        
        if tv.text != "" {
            
            if uid != "" {
                
                thankyoulabel.alpha = 1
                ref?.child("Feedback").child(uid).childByAutoId().updateChildValues(["text" : "\(tv.text!)"])
                tv.alpha = 0
                taps.alpha = 0
                self.view.endEditing(true)
                
                //                self.dismiss(animated: true, completion: {
                //
                //                })
                
            } else {
                
                thankyoulabel.alpha = 1
                ref?.child("Feedback").childByAutoId().updateChildValues(["Text" : "\(tv.text!)"])
                tv.alpha = 0
                taps.alpha = 0
                self.view.endEditing(true)
                
                //                self.dismiss(animated: true, completion: {
                //
                //                })
            }
            
        }
        
        
        
        
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
