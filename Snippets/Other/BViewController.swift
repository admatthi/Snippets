//
//  BViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 5/20/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import FBSDKCoreKit

let darkblue = UIColor(red:0.62, green:0.64, blue:0.74, alpha:1.0)
let mygreen = UIColor(red:0.17, green:0.88, blue:0.70, alpha:1.0)

class BViewController: UIViewController {

    var b1pressed = Bool()
    var b2pressed = Bool()
    var b3pressed = Bool()
    var b4pressed = Bool()

    @IBOutlet weak var taplove: UIButton!
    @IBOutlet weak var taphealth: UIButton!
    @IBOutlet weak var tapwealth: UIButton!
    @IBOutlet weak var taphappiness: UIButton!
    @IBOutlet weak var love: UIImageView!
    @IBOutlet weak var health: UIImageView!
    @IBOutlet weak var wealth: UIImageView!
    @IBOutlet weak var happiness: UIImageView!
    @IBAction func tapLove(_ sender: Any) {
        
        if loveb {
            
            lovetapped()
            
        } else {
            
            loveuntapped()
        }
    }
    @IBAction func tapHealth(_ sender: Any) {
        
        if healthb {
            
            healthtapped()
            
        } else {
            
            healthuntapped()
        }
    }
    @IBAction func tapWealth(_ sender: Any) {
        
        if wealthb {
            
            wealthtapped()
            
        } else {
            
            wealthuntapped()
        }
    }
    @IBAction func tapHappiness(_ sender: Any) {
        
        if happinessb {
            
            happinesstapped()
            
        } else {
            
            happinessuntapped()
        }
    }
    @IBAction func tapGetStarted(_ sender: Any) {
     
        if wealthb {
            
            wealthtapped()
            
        } else {
            
            wealthuntapped()
        }
    }
    
    var happinessb = Bool()
    var wealthb = Bool()
    var healthb = Bool()
    var loveb = Bool()
    
    func happinessuntapped() {
        
        taphappiness.setBackgroundImage(UIImage(named: "HappinessLite"), for: .normal)
        
        happinessb = true

    }
    
    func happinesstapped() {
        
        taphappiness.setBackgroundImage(UIImage(named: "Happiness"), for: .normal)
     
        happinessb = false

    }
    
    func loveuntapped() {
        
        taplove.setBackgroundImage(UIImage(named: "LoveLite"), for: .normal)
        
        loveb = true
        
    }
    
    func lovetapped() {
        
        taplove.setBackgroundImage(UIImage(named: "Love"), for: .normal)
        
        loveb = false
        
    }
    
    func healthuntapped() {
        
        taphealth.setBackgroundImage(UIImage(named: "HealthLite"), for: .normal)
        
        healthb = true
        
    }
    
    func healthtapped() {
        
        taphealth.setBackgroundImage(UIImage(named: "Health"), for: .normal)
        
        healthb = false
        
    }
    
    func wealthuntapped() {
        
        tapwealth.setBackgroundImage(UIImage(named: "MoneyLite"), for: .normal)
        tapwealth.setTitleColor(darkblue, for: .normal)
        
        wealthb = true
        
    }
    
    func wealthtapped() {
        
        tapwealth.setBackgroundImage(UIImage(named: "Money"), for: .normal)
        
        wealthb = false
        
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FBSDKAppEvents.logEvent("Second Screen")
        
        b1pressed = true
        b2pressed = true
        b3pressed = true
        b4pressed = true
        
        happinessb = true
        wealthb = true
        loveb = true
        healthb = true
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

