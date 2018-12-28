//
//  OverviewViewController.swift
//  
//
//  Created by Alek Matthiessen on 12/27/18.
//

import UIKit

class OverviewViewController: UIViewController {

    @IBOutlet weak var tapr: UIButton!
    @IBOutlet weak var taps: UIButton!
    @IBOutlet weak var setupimage: UIImageView!
    @IBOutlet weak var mainimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        counter = 0 
        setupimage.image = UIImage(named: "Setup\(counter)")
        
        
        images.append(UIImage(named: "Overview1")!)
        images.append(UIImage(named: "Overview2")!)
        
        
        images.append(UIImage(named: "Overview3")!)
        images.append(UIImage(named: "Overview4")!)
        
        mainimage.image = images[counter]
tapr.addTextSpacing(2.0)
        taps.addTextSpacing(2.0)
        
        let swipeRightRec = UISwipeGestureRecognizer()
        let swipeLeftRec = UISwipeGestureRecognizer()
        let swipeUpRec = UISwipeGestureRecognizer()
        let swipeDownRec = UISwipeGestureRecognizer()
        
        swipeRightRec.addTarget(self, action: #selector(self.swipeR) )
        swipeRightRec.direction = .right
        self.view!.addGestureRecognizer(swipeRightRec)
        
        
        swipeLeftRec.addTarget(self, action: #selector(self.swipeL) )
        swipeLeftRec.direction = .left
    
        
    self.view!.addGestureRecognizer(swipeLeftRec)

        
        // Do any additional setup after loading the view.
    }
    

    @objc func swipeR() {
        
        self.tapPrevious(nil)
        
    }
    
    @objc func swipeL() {
        
        
        self.tapNext(nil)
        
        
    }
    
    var images = [UIImage]()
    
    @IBAction func tapNext(_ sender: AnyObject?) {
        
        
        if counter < images.count-1 {
            
            counter += 1
            
            setupimage.image = UIImage(named: "Setup\(counter)")
            print(counter)
            mainimage.image = images[counter]
            mainimage.slideInFromRight()
            
        }
        
        if counter == 0 {
            
            
            
        } else {
            
           
        }
        
    }
    
    @IBAction func tapPrevious(_ sender: AnyObject?) {
        
        
        if counter > 0  {
            
            counter -= 1
            
            setupimage.image = UIImage(named: "Setup\(counter)")
            print(counter)
            mainimage.image = images[counter]
            mainimage.slideInFromLeft()
            
        }
        
        if counter == 0 {
            
          
            
        } else {
            

        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
