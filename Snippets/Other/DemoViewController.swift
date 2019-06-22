//
//  DemoViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 8/27/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class DemoViewController: UIViewController {
    @IBOutlet weak var progressView: UIProgressView!
    

    @IBAction func tapPrevious(_ sender: Any) {
        quotetext.slideInFromLeft()

        arrayCount = quote.count
        
  
        
        if counter > 0 {
            
            lastcount()
            
        }
        
        //        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
        bookmarktapped = false
    }
    @IBAction func tapNext(_ sender: Any) {
       
        arrayCount = quote.count

        
        quotetext.slideInFromRight()


        nextcount()
        
        //        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
        bookmarktapped = false
    }
    var category = String()
    
    var bookmarktapped = Bool()
    
    func showbookmark() {
        
        //        if bookmarktapped {
        //
        //            tapbookmark.setImage(UIImage(named: "LightBookMark"), for: .normal)
        //
        //        } else {
        //
        //            tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        //        }
    }
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    
    var arrayCount = Int()
    
    @IBOutlet weak var tapbuy: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        //        whitelabel.layer.cornerRadius = 10.0
        //        whitelabel.layer.masksToBounds = true
        

        cover.layer.cornerRadius = 5.0
        cover.layer.masksToBounds = true
        
        bookmarktapped = false
        
        //        wtf()
        
        whatthehell()
        
        // Do any additional setup after loading the view.
        
        tapanywhere.alpha = 0
        tapb1.alpha = 0
        tapb2.alpha = 0
        tapb3.alpha = 0
        tapb4.alpha = 0
        tapb1.layer.cornerRadius = 10.0
        tapb2.layer.cornerRadius = 10.0
        tapb3.layer.cornerRadius = 10.0
        tapb4.layer.cornerRadius = 10.0
        
        tapb1.layer.masksToBounds = true
        tapb2.layer.masksToBounds = true
        tapb3.layer.masksToBounds = true
        tapb4.layer.masksToBounds = true

    }
    
    @IBOutlet weak var counterbutton: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var quotetext: UILabel!
    
    @IBOutlet weak var backgroundlabel: UILabel!
    
    
    
    var counter = 0
    
    func lastcount() {
        
        
        if counter == 0 {
            
            
        } else {
            
            counter -= 1
            showproperquote()
            let progress = (Float(counter)/Float(arrayCount))
            self.progressView.setProgress(Float(progress), animated:true)
        }
        
        bookmarktapped = true
        //        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        
    }
    
    var randomstring = String()
    
   
    @IBOutlet weak var tapb3: UIButton!
    //
    @IBOutlet weak var tapb4: UIButton!
    @IBOutlet weak var tapb2: UIButton!
    @IBOutlet weak var tapb1: UIButton!
    @IBOutlet weak var tapanywhere: UILabel!
    @IBOutlet weak var tapbookmark: UIButton!
    func nextcount() {
        
        
        if counter > (quote.count-2) {
            

            
            
        } else {
            
            
            if counter == (quote.count - 2) {
                
                counter += 1
                
                showproperquote()
                
                let progress = (Float(counter)/Float(arrayCount))
                self.progressView.setProgress(Float(progress), animated:true)
                
                tapb1.slideInFromRight()
                tapb2.slideInFromRight()
                tapb3.slideInFromRight()
                tapb4.slideInFromRight()
                
                tapb1.alpha = 1
                tapb2.alpha = 1
                tapb3.alpha = 1
                tapb4.alpha = 1
                
                
                
            } else {
                
                tapb1.alpha = 0
                tapb2.alpha = 0
                tapb3.alpha = 0
                tapb4.alpha = 0
                
            counter += 1
            
            showproperquote()
            
            let progress = (Float(counter)/Float(arrayCount))
            self.progressView.setProgress(Float(progress), animated:true)
            
            }
        }
        
        tapanywhere.alpha = 0
        
    }
    @IBAction func tapButton1(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        
        self.performSegue(withIdentifier: "DemoToHome", sender: self)
        
    }
    @IBAction func tapbutton2(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        
        self.performSegue(withIdentifier: "DemoToHome", sender: self)
    }
    @IBAction func tapButton3(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        
        self.performSegue(withIdentifier: "DemoToHome", sender: self)
    }
    @IBAction func tapButton4(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        
        self.performSegue(withIdentifier: "DemoToHome", sender: self)
    }
    @IBOutlet weak var whitelabel: UILabel!
    func whatthehell() {
        
        quote.removeAll()
        
        quote.append("Welcome to Snippets. Tap to the right to continue.")
        quote.append("Get the big ideas from best selling books from business  😄 to dating 😍 to money 🤑 to happiness 😊")
        quote.append("So what would you be interested in?")
        
        quotetext.text = quote[0]
        
        
    }
    

    
    func showproperquote() {
        
        if counter < quote.count {
            
            quotetext.text = quote[counter]
            
            print(counter)
            
            //        quotetext.addCharacterSpacing()
            
            //        backgroundlabel.backgroundColor = colors[counter]
            
            
        }
}

}

extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as! CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = kCATransitionPush
        slideInFromLeftTransition.subtype = kCATransitionFromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    func slideInFromRight(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromRightTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromRightTransition.delegate = delegate as! CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromRightTransition.type = kCATransitionPush
        slideInFromRightTransition.subtype = kCATransitionFromRight
        slideInFromRightTransition.duration = duration
        slideInFromRightTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromRightTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromRightTransition, forKey: "slideInFromRightTransition")
    }
}

