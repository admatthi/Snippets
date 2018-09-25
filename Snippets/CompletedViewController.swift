//
//  CompletedViewController.swift
//  Snippets
//
//  Created by Alek Matthiessen on 9/16/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Cheers

class CompletedViewController: UIViewController {

    @IBAction func tapNext(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
    }
    @IBOutlet weak var bamview: CheerView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var imageback: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        imageback.image = selectedimage
        titlelabel.text = "\(selectedtitle)!"
        
        // Configure
        bamview.config.particle = .confetti(allowedShapes: [Particle.ConfettiShape.triangle])
        
        bamview.config.colors = [myblue, mygreen]

        // Start
        bamview.start()
        
        // Stop
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
