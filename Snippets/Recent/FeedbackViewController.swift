//
//  FeedbackViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 6/11/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

var counter = Int()
var logodownloadurl = String()

class FeedbackViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tapx: UIButton!
    @IBOutlet weak var ss: UIImageView!
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var tapb: UIButton!
    @IBOutlet weak var tf: UITextView!
    @IBAction func tapX(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            
        })
    }
    @IBAction func tapB(_ sender: Any) {
    
        activityIndicator.alpha = 1
        tapx.alpha = 0
        ss.alpha = 0
        tf.alpha = 0
        tapb.alpha = 0
        header.alpha = 0

        activityIndicator.startAnimating()
        
        self.view.endEditing(true)

        if tf.text != "" {
        
           
                let storage = Storage.storage()
                let storageRef = storage.reference()
                let currentUser = Auth.auth().currentUser
            
                var logoimagedata2 = UIImageJPEGRepresentation(screenshot, 1.0)!

                
                let metaData = StorageMetadata()
                
                metaData.contentType = "image/jpg"
                
                counter += 1
                
                let filePath = "\(uid)\(counter)"
                
                //        let filePath = "\(counter)"
                
                storageRef.child(filePath).putData(logoimagedata2, metadata: metaData){(metaData,error) in
                    
                    if let error = error {
                        
                        print(error.localizedDescription)
                        
                        return
                        
                    } else {
                        
                        // store download url
//                        logodownloadurl = metaData!.downloadURL()!.absoluteString
                        
                        
                        let currentUser = Auth.auth().currentUser
                        
                        var uid = String()
                        
                          if Auth.auth().currentUser == nil {
                            
//                            ref?.child("Feedback").child("1232131").childByAutoId().updateChildValues(["Text" : self.tf.text!, "Image" : logodownloadurl])


                          } else {
                            

                            
                                uid = currentUser!.uid
//                            ref?.child("Feedback").child(uid).childByAutoId().updateChildValues(["Text" : self.tf.text!, "Image" : logodownloadurl])
                            
                        }
                        
                        ref = Database.database().reference()
                        
                        DispatchQueue.main.async {
                            
                            self.dismiss(animated: true, completion: {
                                
                            })
                        }
                        
         
                    }
                        
                    }
                    
            

            

        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        activityIndicator.alpha = 0
        tf.delegate = self
        ss.image = screenshot
        tf.layer.cornerRadius = 2.0
        tf.layer.masksToBounds = true
        tf.text = "Please describe what went wrong"
        tf.textColor = UIColor.lightGray
        
        // Do any additional setup after loading the view.
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Please describe what went wrong"
            textView.textColor = UIColor.lightGray
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

}
