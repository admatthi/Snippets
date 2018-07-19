//
//  AViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 5/20/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import FBSDKCoreKit

var newweight = String()


var typed1 = String()
var typed2 = String()

class AViewController: UIViewController {
    @IBAction func button(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newuser = true
        // Do any additional setup after loading the view.
        
        FBSDKAppEvents.logEvent("First Screen")
        
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


