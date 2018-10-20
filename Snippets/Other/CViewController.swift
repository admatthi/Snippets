//
//  CViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 5/20/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class CViewController: UIViewController {

    var b1pressed = Bool()
    var b2pressed = Bool()
    var b3pressed = Bool()
    var b4pressed = Bool()
    
    @IBOutlet weak var tapbutton1: UIButton!
    @IBOutlet weak var tapbutton2: UIButton!
    @IBOutlet weak var tapbutton3: UIButton!
    @IBOutlet weak var tapbutton4: UIButton!
    
    @IBAction func tapGetStarted(_ sender: Any) {
        
        
    }
    @IBAction func tapButton1(_ sender: Any) {
        
        //        if b1pressed {
        //
        //            tapbutton1.alpha = 1.0
        //            b1pressed = false
        //
        //
        //        } else {
        //
        //            tapbutton1.alpha = 0.5
        //
        //            b1pressed = true
        //        }
        
        tapbutton1.setBackgroundImage(UIImage(named:"ColoredButton"), for: .normal)
        tapbutton1.setTitleColor(.white, for: .normal)
        tapbutton2.setTitleColor(.black, for: .normal)
        tapbutton3.setTitleColor(.black, for: .normal)
        tapbutton2.setBackgroundImage(UIImage(named:"WhiteButton"), for: .normal)
        tapbutton3.setBackgroundImage(UIImage(named:"WhiteButton"), for: .normal)
        
    }
    @IBAction func tapButton2(_ sender: Any) {
        
        tapbutton2.setBackgroundImage(UIImage(named:"ColoredButton"), for: .normal)
        tapbutton2.setTitleColor(.white, for: .normal)
        tapbutton1.setTitleColor(.black, for: .normal)
        tapbutton3.setTitleColor(.black, for: .normal)
        tapbutton1.setBackgroundImage(UIImage(named:"WhiteButton"), for: .normal)
        tapbutton3.setBackgroundImage(UIImage(named:"WhiteButton"), for: .normal)
    }
    @IBAction func tapButton3(_ sender: Any) {
        
        tapbutton3.setBackgroundImage(UIImage(named:"ColoredButton"), for: .normal)
        tapbutton3.setTitleColor(.white, for: .normal)
        tapbutton2.setTitleColor(.black, for: .normal)
        tapbutton1.setTitleColor(.black, for: .normal)
        tapbutton2.setBackgroundImage(UIImage(named:"WhiteButton"), for: .normal)
        tapbutton1.setBackgroundImage(UIImage(named:"WhiteButton"), for: .normal)
        
    }
    @IBAction func tapButton4(_ sender: Any) {
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FBSDKAppEvents.logEvent("Third Screen")
        
        b1pressed = true
        b2pressed = true
        b3pressed = true
        b4pressed = true
        
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

