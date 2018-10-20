//
//  GenreViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 10/18/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {

    @IBAction func tapBio(_ sender: AnyObject?) {
        
        tapbio.alpha = 1
        taphealth.alpha = 0.50
        tapbiz.alpha = 0.50
        tapmh.alpha = 0.50
        tapprod.alpha = 0.50
        tappsych.alpha = 0.50
        tapsex.alpha = 0.50
        
        selectedgenre = "Biography & Memoir"

    }
    @IBAction func tapBiz(_ sender: AnyObject?) {
        
        tapbio.alpha = 0.50
        taphealth.alpha = 0.50
        tapbiz.alpha = 1
        tapmh.alpha = 0.50
        tapprod.alpha = 0.50
        tappsych.alpha = 0.50
        tapsex.alpha = 0.50
        
        selectedgenre = "Business & Investing"
    }
    @IBAction func tapHealth(_ sender: AnyObject?) {
        
        tapbio.alpha = 0.50
        taphealth.alpha = 1
        tapbiz.alpha = 0.50
        tapmh.alpha = 0.50
        tapprod.alpha = 0.50
        tappsych.alpha = 0.50
        tapsex.alpha = 0.50
        selectedgenre = "Health, Fitness, & Dieting"
    }
    @IBAction func tapMH(_ sender: AnyObject?) {
        
        tapbio.alpha = 0.50
        taphealth.alpha = 0.50
        tapbiz.alpha = 0.50
        tapmh.alpha = 1
        tapprod.alpha = 0.50
        tappsych.alpha = 0.50
        tapsex.alpha = 0.50
        selectedgenre = "Mental Health"
    }
    @IBAction func tapProd(_ sender: AnyObject?) {
        
        tapbio.alpha = 0.50
        taphealth.alpha = 0.50
        tapbiz.alpha = 0.50
        tapmh.alpha = 0.50
        tapprod.alpha = 1
        tappsych.alpha = 0.50
        tapsex.alpha = 0.50
        selectedgenre = "Productivity"
    }
    @IBAction func tapPsych(_ sender: AnyObject?) {
        
        tapbio.alpha = 0.50
        taphealth.alpha = 0.50
        tapbiz.alpha = 0.50
        tapmh.alpha = 0.50
        tapprod.alpha = 0.50
        tappsych.alpha = 1
        tapsex.alpha = 0.50
        selectedgenre = "Psychology"
    }
    @IBAction func tapSex(_ sender: AnyObject?) {
        
        tapbio.alpha = 0.50
        taphealth.alpha = 0.50
        tapbiz.alpha = 0.50
        tapmh.alpha = 0.50
        tapprod.alpha = 0.50
        tappsych.alpha = 0.50
        tapsex.alpha = 1
        selectedgenre = "Sex & Relationships"
        
    }
    @IBOutlet weak var tapbio: UIButton!
    @IBOutlet weak var tapbiz: UIButton!

    @IBOutlet weak var taphealth: UIButton!

    @IBOutlet weak var tapmh: UIButton!

    @IBOutlet weak var tapprod: UIButton!

    @IBOutlet weak var tappsych: UIButton!
    
    @IBOutlet weak var tapsex: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        tapbio.contentHorizontalAlignment = .left
        taphealth.contentHorizontalAlignment = .left
        tapbiz.contentHorizontalAlignment = .left
        tapmh.contentHorizontalAlignment = .left
        tapprod.contentHorizontalAlignment = .left
        tappsych.contentHorizontalAlignment = .left
        tapsex.contentHorizontalAlignment = .left

        if selectedgenre == "Biography & Memoir" {
            
            tapBio(nil)
        }
        if selectedgenre == "Business & Investing" {
            
            tapBiz(nil)
        }
        if selectedgenre == "Health, Fitness, & Dieting" {
            
            tapHealth(nil)
        }
        if selectedgenre == "Mental Health" {
            
            tapMH(nil)
        }
        if selectedgenre == "Productivity" {
            
            tapProd(nil)
        }
        if selectedgenre == "Psychology" {
            
            tapPsych(nil)
        }
        if selectedgenre == "Sex & Relationships" {
            
            tapSex(nil)
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
