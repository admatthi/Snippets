//
//  FilterViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 7/20/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

let myblue = UIColor(red:0.00, green:0.62, blue:0.98, alpha:1.0)

class FilterViewController: UIViewController {

    @IBOutlet weak var one: UILabel!
       @IBOutlet weak var two: UILabel!
       @IBOutlet weak var three: UILabel!
       @IBOutlet weak var four: UILabel!
       @IBOutlet weak var five: UILabel!
       @IBOutlet weak var six: UILabel!
       @IBOutlet weak var seven: UILabel!
       @IBOutlet weak var eight: UILabel!
       @IBOutlet weak var nine: UILabel!

    @IBOutlet weak var ninei: UIImageView!
        @IBOutlet weak var onei: UIImageView!
        @IBOutlet weak var twoi: UIImageView!
        @IBOutlet weak var threei: UIImageView!
        @IBOutlet weak var fouri: UIImageView!
        @IBOutlet weak var fivei: UIImageView!
        @IBOutlet weak var sixi: UIImageView!
        @IBOutlet weak var seveni: UIImageView!
        @IBOutlet weak var eighti: UIImageView!

    var b1 = Bool()
    var b2 = Bool()
    var b3 = Bool()
    var b4 = Bool()
    var b6 = Bool()
    var b7 = Bool()
    var b8 = Bool()
    var b9 = Bool()
    
    @IBAction func tap1(_ sender: Any) {
        
        one.textColor = myblue
        two.textColor = UIColor.black
        three.textColor = UIColor.black
        four.textColor = UIColor.black
        five.textColor = UIColor.black
        six.textColor = UIColor.black
        seven.textColor = UIColor.black
        eight.textColor = UIColor.black
        nine.textColor = UIColor.black

        onei.image = UIImage(named: "BlueOval")
        twoi.image = UIImage(named: "GreyOval")
        threei.image = UIImage(named: "GreyOval")
        fouri.image = UIImage(named: "GreyOval")
        fivei.image = UIImage(named: "GreyOval")
        sixi.image = UIImage(named: "GreyOval")
        seveni.image = UIImage(named: "GreyOval")
        eighti.image = UIImage(named: "GreyOval")
        ninei.image = UIImage(named: "GreyOval")
        
        selectedfilter = one.text!
        
        
    }
    @IBAction func tap2(_ sender: Any) {
        
        two.textColor = myblue
        one.textColor = UIColor.black
        three.textColor = UIColor.black
        four.textColor = UIColor.black
        five.textColor = UIColor.black
        six.textColor = UIColor.black
        seven.textColor = UIColor.black
        eight.textColor = UIColor.black
        nine.textColor = UIColor.black
        
        twoi.image = UIImage(named: "BlueOval")
        onei.image = UIImage(named: "GreyOval")
        threei.image = UIImage(named: "GreyOval")
        fouri.image = UIImage(named: "GreyOval")
        fivei.image = UIImage(named: "GreyOval")
        sixi.image = UIImage(named: "GreyOval")
        seveni.image = UIImage(named: "GreyOval")
        eighti.image = UIImage(named: "GreyOval")
        ninei.image = UIImage(named: "GreyOval")
        
        selectedfilter = two.text!
    }
    @IBAction func tap3(_ sender: Any) {
        
        three.textColor = myblue
        two.textColor = UIColor.black
        one.textColor = UIColor.black
        four.textColor = UIColor.black
        five.textColor = UIColor.black
        six.textColor = UIColor.black
        seven.textColor = UIColor.black
        eight.textColor = UIColor.black
        nine.textColor = UIColor.black
        
        threei.image = UIImage(named: "BlueOval")
        twoi.image = UIImage(named: "GreyOval")
        onei.image = UIImage(named: "GreyOval")
        fouri.image = UIImage(named: "GreyOval")
        fivei.image = UIImage(named: "GreyOval")
        sixi.image = UIImage(named: "GreyOval")
        seveni.image = UIImage(named: "GreyOval")
        eighti.image = UIImage(named: "GreyOval")
        ninei.image = UIImage(named: "GreyOval")
        
        selectedfilter = three.text!
    }
    @IBAction func tap4(_ sender: Any) {
        four.textColor = myblue
        two.textColor = UIColor.black
        three.textColor = UIColor.black
        one.textColor = UIColor.black
        five.textColor = UIColor.black
        six.textColor = UIColor.black
        seven.textColor = UIColor.black
        eight.textColor = UIColor.black
        nine.textColor = UIColor.black
        
        fouri.image = UIImage(named: "BlueOval")
        twoi.image = UIImage(named: "GreyOval")
        threei.image = UIImage(named: "GreyOval")
        onei.image = UIImage(named: "GreyOval")
        fivei.image = UIImage(named: "GreyOval")
        sixi.image = UIImage(named: "GreyOval")
        seveni.image = UIImage(named: "GreyOval")
        eighti.image = UIImage(named: "GreyOval")
        ninei.image = UIImage(named: "GreyOval")
        
        selectedfilter = four.text!
    }
    @IBAction func tap5(_ sender: Any) {
        
        five.textColor = myblue
        two.textColor = UIColor.black
        three.textColor = UIColor.black
        four.textColor = UIColor.black
        one.textColor = UIColor.black
        six.textColor = UIColor.black
        seven.textColor = UIColor.black
        eight.textColor = UIColor.black
        nine.textColor = UIColor.black
        
        fivei.image = UIImage(named: "BlueOval")
        twoi.image = UIImage(named: "GreyOval")
        threei.image = UIImage(named: "GreyOval")
        fouri.image = UIImage(named: "GreyOval")
        onei.image = UIImage(named: "GreyOval")
        sixi.image = UIImage(named: "GreyOval")
        seveni.image = UIImage(named: "GreyOval")
        eighti.image = UIImage(named: "GreyOval")
        ninei.image = UIImage(named: "GreyOval")
        
        selectedfilter = five.text!
    }
    @IBAction func tap6(_ sender: Any) {
        
        six.textColor = myblue
        two.textColor = UIColor.black
        three.textColor = UIColor.black
        four.textColor = UIColor.black
        five.textColor = UIColor.black
        one.textColor = UIColor.black
        seven.textColor = UIColor.black
        eight.textColor = UIColor.black
        nine.textColor = UIColor.black
        
        sixi.image = UIImage(named: "BlueOval")
        twoi.image = UIImage(named: "GreyOval")
        threei.image = UIImage(named: "GreyOval")
        fouri.image = UIImage(named: "GreyOval")
        fivei.image = UIImage(named: "GreyOval")
        onei.image = UIImage(named: "GreyOval")
        seveni.image = UIImage(named: "GreyOval")
        eighti.image = UIImage(named: "GreyOval")
        ninei.image = UIImage(named: "GreyOval")
        
        selectedfilter = six.text!
    }
    @IBAction func tap7(_ sender: Any) {
        
        seven.textColor = myblue
        two.textColor = UIColor.black
        three.textColor = UIColor.black
        four.textColor = UIColor.black
        five.textColor = UIColor.black
        six.textColor = UIColor.black
        one.textColor = UIColor.black
        eight.textColor = UIColor.black
        nine.textColor = UIColor.black
        
        seveni.image = UIImage(named: "BlueOval")
        twoi.image = UIImage(named: "GreyOval")
        threei.image = UIImage(named: "GreyOval")
        fouri.image = UIImage(named: "GreyOval")
        fivei.image = UIImage(named: "GreyOval")
        sixi.image = UIImage(named: "GreyOval")
        onei.image = UIImage(named: "GreyOval")
        eighti.image = UIImage(named: "GreyOval")
        ninei.image = UIImage(named: "GreyOval")
        
        selectedfilter = seven.text!
    }
    @IBAction func tap8(_ sender: Any) {
        
        eight.textColor = myblue
        two.textColor = UIColor.black
        three.textColor = UIColor.black
        four.textColor = UIColor.black
        five.textColor = UIColor.black
        six.textColor = UIColor.black
        seven.textColor = UIColor.black
        one.textColor = UIColor.black
        nine.textColor = UIColor.black
        
        eighti.image = UIImage(named: "BlueOval")
        twoi.image = UIImage(named: "GreyOval")
        threei.image = UIImage(named: "GreyOval")
        fouri.image = UIImage(named: "GreyOval")
        fivei.image = UIImage(named: "GreyOval")
        sixi.image = UIImage(named: "GreyOval")
        seveni.image = UIImage(named: "GreyOval")
        onei.image = UIImage(named: "GreyOval")
        ninei.image = UIImage(named: "GreyOval")
        
        selectedfilter = eight.text!
    }
    @IBAction func tap9(_ sender: Any) {
        
        nine.textColor = myblue
        two.textColor = UIColor.black
        three.textColor = UIColor.black
        four.textColor = UIColor.black
        five.textColor = UIColor.black
        six.textColor = UIColor.black
        seven.textColor = UIColor.black
        eight.textColor = UIColor.black
        one.textColor = UIColor.black
        
        ninei.image = UIImage(named: "BlueOval")
        twoi.image = UIImage(named: "GreyOval")
        threei.image = UIImage(named: "GreyOval")
        fouri.image = UIImage(named: "GreyOval")
        fivei.image = UIImage(named: "GreyOval")
        sixi.image = UIImage(named: "GreyOval")
        seveni.image = UIImage(named: "GreyOval")
        eighti.image = UIImage(named: "GreyOval")
        onei.image = UIImage(named: "GreyOval")
        
        selectedfilter = nine.text!
        
        
    }

    @IBOutlet weak var backgroundlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundlabel.layer.cornerRadius = 10.0
        backgroundlabel.layer.masksToBounds = true

        
        if selectedfilter == "Business & Money" {
            
            one.textColor = myblue
            two.textColor = UIColor.black
            three.textColor = UIColor.black
            four.textColor = UIColor.black
            five.textColor = UIColor.black
            six.textColor = UIColor.black
            seven.textColor = UIColor.black
            eight.textColor = UIColor.black
            nine.textColor = UIColor.black
            
            onei.image = UIImage(named: "BlueOval")
            twoi.image = UIImage(named: "GreyOval")
            threei.image = UIImage(named: "GreyOval")
            fouri.image = UIImage(named: "GreyOval")
            fivei.image = UIImage(named: "GreyOval")
            sixi.image = UIImage(named: "GreyOval")
            seveni.image = UIImage(named: "GreyOval")
            eighti.image = UIImage(named: "GreyOval")
            ninei.image = UIImage(named: "GreyOval")
            
        }
        
        if selectedfilter == "Psychology" {
            
            two.textColor = myblue
            one.textColor = UIColor.black
            three.textColor = UIColor.black
            four.textColor = UIColor.black
            five.textColor = UIColor.black
            six.textColor = UIColor.black
            seven.textColor = UIColor.black
            eight.textColor = UIColor.black
            nine.textColor = UIColor.black
            
            twoi.image = UIImage(named: "BlueOval")
            onei.image = UIImage(named: "GreyOval")
            threei.image = UIImage(named: "GreyOval")
            fouri.image = UIImage(named: "GreyOval")
            fivei.image = UIImage(named: "GreyOval")
            sixi.image = UIImage(named: "GreyOval")
            seveni.image = UIImage(named: "GreyOval")
            eighti.image = UIImage(named: "GreyOval")
            ninei.image = UIImage(named: "GreyOval")
            
        }
        
        if selectedfilter == "Productivity" {
            
            three.textColor = myblue
            two.textColor = UIColor.black
            one.textColor = UIColor.black
            four.textColor = UIColor.black
            five.textColor = UIColor.black
            six.textColor = UIColor.black
            seven.textColor = UIColor.black
            eight.textColor = UIColor.black
            nine.textColor = UIColor.black
            
            threei.image = UIImage(named: "BlueOval")
            twoi.image = UIImage(named: "GreyOval")
            onei.image = UIImage(named: "GreyOval")
            fouri.image = UIImage(named: "GreyOval")
            fivei.image = UIImage(named: "GreyOval")
            sixi.image = UIImage(named: "GreyOval")
            seveni.image = UIImage(named: "GreyOval")
            eighti.image = UIImage(named: "GreyOval")
            ninei.image = UIImage(named: "GreyOval")
            
        }
        
        if selectedfilter == "Mangagement & Leadership" {
            
            four.textColor = myblue
            two.textColor = UIColor.black
            three.textColor = UIColor.black
            one.textColor = UIColor.black
            five.textColor = UIColor.black
            six.textColor = UIColor.black
            seven.textColor = UIColor.black
            eight.textColor = UIColor.black
            nine.textColor = UIColor.black
            
            fouri.image = UIImage(named: "BlueOval")
            twoi.image = UIImage(named: "GreyOval")
            threei.image = UIImage(named: "GreyOval")
            onei.image = UIImage(named: "GreyOval")
            fivei.image = UIImage(named: "GreyOval")
            sixi.image = UIImage(named: "GreyOval")
            seveni.image = UIImage(named: "GreyOval")
            eighti.image = UIImage(named: "GreyOval")
            ninei.image = UIImage(named: "GreyOval")
        }
        
        if selectedfilter == "Communication & Social Skills" {
            
            five.textColor = myblue
            two.textColor = UIColor.black
            three.textColor = UIColor.black
            four.textColor = UIColor.black
            one.textColor = UIColor.black
            six.textColor = UIColor.black
            seven.textColor = UIColor.black
            eight.textColor = UIColor.black
            nine.textColor = UIColor.black
            
            fivei.image = UIImage(named: "BlueOval")
            twoi.image = UIImage(named: "GreyOval")
            threei.image = UIImage(named: "GreyOval")
            fouri.image = UIImage(named: "GreyOval")
            onei.image = UIImage(named: "GreyOval")
            sixi.image = UIImage(named: "GreyOval")
            seveni.image = UIImage(named: "GreyOval")
            eighti.image = UIImage(named: "GreyOval")
            ninei.image = UIImage(named: "GreyOval")
            
        }
        
        if selectedfilter == "Mindfulness & Happiness" {
            
            six.textColor = myblue
            two.textColor = UIColor.black
            three.textColor = UIColor.black
            four.textColor = UIColor.black
            five.textColor = UIColor.black
            one.textColor = UIColor.black
            seven.textColor = UIColor.black
            eight.textColor = UIColor.black
            nine.textColor = UIColor.black
            
            sixi.image = UIImage(named: "BlueOval")
            twoi.image = UIImage(named: "GreyOval")
            threei.image = UIImage(named: "GreyOval")
            fouri.image = UIImage(named: "GreyOval")
            fivei.image = UIImage(named: "GreyOval")
            onei.image = UIImage(named: "GreyOval")
            seveni.image = UIImage(named: "GreyOval")
            eighti.image = UIImage(named: "GreyOval")
            ninei.image = UIImage(named: "GreyOval")
            
        }
        
        if selectedfilter == "Biography & History" {
            
            seven.textColor = myblue
            two.textColor = UIColor.black
            three.textColor = UIColor.black
            four.textColor = UIColor.black
            five.textColor = UIColor.black
            six.textColor = UIColor.black
            one.textColor = UIColor.black
            eight.textColor = UIColor.black
            nine.textColor = UIColor.black
            
            seveni.image = UIImage(named: "BlueOval")
            twoi.image = UIImage(named: "GreyOval")
            threei.image = UIImage(named: "GreyOval")
            fouri.image = UIImage(named: "GreyOval")
            fivei.image = UIImage(named: "GreyOval")
            sixi.image = UIImage(named: "GreyOval")
            onei.image = UIImage(named: "GreyOval")
            eighti.image = UIImage(named: "GreyOval")
            ninei.image = UIImage(named: "GreyOval")
        }
        
        if selectedfilter == "Health, Fitness, & Dieting" {
            
            eight.textColor = myblue
            two.textColor = UIColor.black
            three.textColor = UIColor.black
            four.textColor = UIColor.black
            five.textColor = UIColor.black
            six.textColor = UIColor.black
            seven.textColor = UIColor.black
            one.textColor = UIColor.black
            nine.textColor = UIColor.black
            
            eighti.image = UIImage(named: "BlueOval")
            twoi.image = UIImage(named: "GreyOval")
            threei.image = UIImage(named: "GreyOval")
            fouri.image = UIImage(named: "GreyOval")
            fivei.image = UIImage(named: "GreyOval")
            sixi.image = UIImage(named: "GreyOval")
            seveni.image = UIImage(named: "GreyOval")
            onei.image = UIImage(named: "GreyOval")
            ninei.image = UIImage(named: "GreyOval")
        }
        
        if selectedfilter == "Politics & Social Science" {
            
            nine.textColor = myblue
            two.textColor = UIColor.black
            three.textColor = UIColor.black
            four.textColor = UIColor.black
            five.textColor = UIColor.black
            six.textColor = UIColor.black
            seven.textColor = UIColor.black
            eight.textColor = UIColor.black
            one.textColor = UIColor.black
            
            ninei.image = UIImage(named: "BlueOval")
            twoi.image = UIImage(named: "GreyOval")
            threei.image = UIImage(named: "GreyOval")
            fouri.image = UIImage(named: "GreyOval")
            fivei.image = UIImage(named: "GreyOval")
            sixi.image = UIImage(named: "GreyOval")
            seveni.image = UIImage(named: "GreyOval")
            eighti.image = UIImage(named: "GreyOval")
            onei.image = UIImage(named: "GreyOval")
            
        }
        

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
