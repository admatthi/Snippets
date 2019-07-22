//
//  AudioViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 7/22/19.
//  Copyright © 2019 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit
import UserNotifications
import AudioToolbox

class AudioViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBAction func tapRead(_ sender: Any) {
    }
    @IBOutlet weak var tapsnippettext: UILabel!
    
    var x2speed = Bool()
    
    @IBOutlet weak var tapspeed: UIButton!
    @IBAction func tapNewSpeed(_ sender: Any) {
        
        if x2speed {
            
            tapspeed.setTitle("1x", for: .normal)
            
            x2speed = false
        } else {
            
              tapspeed.setTitle("2x", for: .normal)
            
            x2speed = true
        }
    }
    @IBAction func tapFastForward(_ sender: Any) {
    }
    @IBAction func tapPrevious(_ sender: Any) {
    }
    @IBAction func tapPlayOrPause(_ sender: Any) {
        
        if playtapped {
            
            tapplayorpause.setBackgroundImage(UIImage(named: "Pause"), for: .normal)
            
                playtapped = false
            
        } else {
            
            tapplayorpause.setBackgroundImage(UIImage(named: "Play"), for: .normal)
            
            playtapped = true
        }
    }
    
    var playtapped = Bool()
    
    @IBOutlet weak var tapplayorpause: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        titlelabel.text = selectedtitle
        authorlabel.text = selectedauthor
        cover.image = selectedimage
        cover.layer.cornerRadius = 5.0
        cover.layer.masksToBounds = true
        
        playtapped = false
        x2speed = false
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var titlelabel: UILabel!
    
    @IBOutlet weak var authorlabel: UILabel!
    
    @IBOutlet weak var cover: UIImageView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
