//
//  MainViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 9/11/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

let darkbluee = UIColor(red:0.09, green:0.11, blue:0.14, alpha:1.0)

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if didpurchase {
            
            
        } else {
            
            self.performSegue(withIdentifier: "ExploreToPurchase8", sender: self)//
        }
        
//        self.tabBar.barTintColor = darkbluee
//        self.tabBar.isTranslucent = false
//        self.tabBar.tintColor = .white
        // Do any additional setup after loading the view.
//        tabBar.backgroundImage = UIImage.imageWithData(UIColor.clearColor())

//        tabBar.isTranslucent = true
////       tabBar.alpha = 0.3
//
//                var bgView: UIImageView = UIImageView(image: UIImage(named: "tabbar"))
//
//        bgView.frame = tabBar.bounds
////        bgView.bottomAnchor = view.bottomAnchor
//        tabBar.addSubview(bgView)
//        tabBar.shadowImage = nil
        
//        var bgView: UIImageView = UIImageView(image: UIImage(named: "tabbar"))
////        bgView.frame = CGRectMake(0, 420, 320, 60)//you might need to modify this frame to your tabbar frame
//
//        self.view.addSubview(bgView)
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
