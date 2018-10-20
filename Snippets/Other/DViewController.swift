//
//  DViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 5/20/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import FBSDKCoreKit

var currentweight = String()
var goalweight = String()
var maingoal = String()

class DViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var goaltf: UITextField!
    @IBOutlet weak var errorlabel: UILabel!
    @IBAction func tapNext(_ sender: Any) {
        
        if goaltf.text != "" {
            
            maingoal = goaltf.text!
        }
    }

    //    @IBOutlet weak var slider1label: UILabel!
    //    @IBOutlet weak var slider2label: UILabel!
    //    @IBOutlet weak var slider2: UISlider!
    //    @IBOutlet weak var slider1: UISlider!
    //    @IBAction func sliderChanged(_ sender: Any) {
    //
    //        var slidervalue = slider2.value
    //
    //        var intsv = Int(slidervalue)
    //
    //        slider2label.text = "About \(String(intsv)) lbs"
    //
    //
    //    }
    //    @IBAction func slider2Changed(_ sender: Any) {
    //
    //        var slidervalue = slider1.value
    //
    //        var intsv = Int(slidervalue)
    //
    //        slider1label.text = "About \(String(intsv)) lbs"
    //
    //        newweight = String(intsv)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        FBSDKAppEvents.logEvent("Fourth Screen")
        
 
        
        // Do any additional setup after loading the view.
        
        //        var slidervalue = slider1.value
        //
        //        var intsv = Int(slidervalue)
        //
        //        var originalweight = String(intsv)
        //
        //        slider1label.text = "About \(String(intsv)) lbs"
        //
        //        slidervalue = slider2.value
        //
        //        intsv = Int(slidervalue)
        //
        //        slider2label.text = "About \(String(intsv)) lbs"
        //
        //        newweight = String(intsv)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
        
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

