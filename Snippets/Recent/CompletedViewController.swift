//
//  CompletedViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 9/16/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Cheers
import Firebase
var starsnumber = String()

class CompletedViewController: UIViewController {

    @IBOutlet weak var stars: UIImageView!
    @IBAction func tapNext(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
       
        if starsnumber != "" {
            ref!.child("FeedbackStars").child(selectedgenre).child(selectedbookid).childByAutoId().updateChildValues(["Stars" : starsnumber])
            
            self.performSegue(withIdentifier: "CompletedToMain", sender: self)
        } else {
            
            self.performSegue(withIdentifier: "CompletedToMain", sender: self)

        }
        
    }
    @IBAction func tapB4(_ sender: Any) {
        
        stars.image = UIImage(named: "4Star")
        starsnumber = "4"
    }
    @IBAction func tapB1(_ sender: Any) {
        
        
        
        stars.image = UIImage(named: "1Star")
        starsnumber = "1"
    }
    @IBAction func tapB2(_ sender: Any) {
        
        stars.image = UIImage(named: "2Star")
        starsnumber = "2"
    }
    @IBAction func tapB3(_ sender: Any) {
        
        stars.image = UIImage(named: "3Star")
        starsnumber = "3"
    }

    @IBAction func tapB5(_ sender: Any) {
        
        stars.image = UIImage(named: "5Star")
        starsnumber = "5"
    }
    @IBOutlet weak var bamview: CheerView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var imageback: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        imageback.image = selectedimage
        titlelabel.text = "\(selectedtitle)!"
        
        // Configure
        bamview.config.particle = .confetti(allowedShapes: [Particle.ConfettiShape.triangle])
        
        bamview.config.colors = [myblue, mygreen]

        // Start
        bamview.start()
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CompletedViewController.count), userInfo: nil, repeats: true)

        
        
        imageback.layer.cornerRadius = 10.0
        imageback.layer.masksToBounds = true
        
        starsnumber = ""
        // Stop
        // Do any additional setup after loading the view.
    }

    var counter3 = 0
    
    @objc func count() {
        
        counter += 1
        
        if counter == 4 {
            
            
            bamview.stop()
            timer.invalidate()
        }
    }
    var timer = Timer()
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
