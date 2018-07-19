//
//  SubsViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 7/12/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class SubsViewController: UIViewController {

    @IBAction func tapTerms(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.tryeatfree.com/terms.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    @IBAction func tapPrivacy(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.tryeatfree.com/privacy-policy.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    @IBAction func tapBilling(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.tryeatfree.com/billing-terms.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
