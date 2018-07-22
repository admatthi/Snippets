//
//  ExpandedViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 7/20/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

var selectedtext = String()

class ExpandedViewController: UIViewController {

    @IBOutlet weak var fulltext: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fulltext.text = selectedtext

    fulltext.addCharacterSpacing()
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
