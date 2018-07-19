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

class FeedbackViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tapx: UIButton!
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var ss: UIImageView!
    
    @IBAction func tapX(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            
        })
    }
    @IBAction func tapB(_ sender: Any) {
    
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
                        logodownloadurl = metaData!.downloadURL()!.absoluteString
                        
                        
                        let currentUser = Auth.auth().currentUser
                        
                        var uid = String()
                        
                        uid = currentUser!.uid
                        
                        ref = Database.database().reference()
                        
                        ref?.child("Feedback").child(uid).childByAutoId().updateChildValues(["Text" : self.tf.text!, "Image" : logodownloadurl])
                        
                        self.dismiss(animated: true, completion: {
                            
                        })
                    }
                        
                    }
                    
            

            

        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        tf.delegate = self
        ss.image = screenshot
        // Do any additional setup after loading the view.
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
