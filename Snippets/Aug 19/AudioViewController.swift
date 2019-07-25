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
import AVFoundation


var audiofiles = [String]()


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
            
            player?.rate = 1.0
            x2speed = false
            
        } else {
            
              tapspeed.setTitle("2x", for: .normal)
            
            player?.rate = 2.0
            x2speed = true
        }
    }
    @IBOutlet weak var backimage: UIImageView!
    @IBAction func tapFastForward(_ sender: Any) {
        
        nextcount()
    }
    @IBAction func tapPrevious(_ sender: Any) {
        
    
    }
    @IBAction func tapPlayOrPause(_ sender: Any) {
        
    
        
        if player?.rate == 0
        {
            
            player!.play()

            musictimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AudioViewController.musicProgress), userInfo: nil, repeats: true)

            //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
            tapplayorpause.setBackgroundImage(UIImage(named: "Pause"), for: .normal)
            
           
            
        } else {
            player!.pause()
            //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
            tapplayorpause.setBackgroundImage(UIImage(named: "Play"), for: .normal)
            
            musictimer.invalidate()
        }
    }
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var durationlabel: UILabel!
    
    var doublect = Double()
    @objc func musicProgress()  {
        
        
        var currenttime = player?.currentTime()
        print(player!.currentTime)

        doublect = Double(CMTimeGetSeconds(currenttime!))
        
        print(doublect)

        if doublect >= 1 {
            
            var normalizedTime = Float(doublect / duration )
            let dTotalSeconds = player?.currentTime()

            let asset = AVURLAsset(url: url!, options: nil)
            let cTotalSeconds = asset.duration
            
            
            durationlabel.text = cTotalSeconds.durationText
            currentTimeLabel.text = dTotalSeconds?.durationText
            
            self.progressView.progress = normalizedTime
            
            if doublect >= duration {
                
                nextcount()
            }

        } else {
            
       
        }
    
    }
    
    func converttominutes() {
        
//        var minduration = Int(duration) / 60
//
//
//        var mindoublect = Int()
//
//
//        mindoublect = Int(doublect) / 60
//
        


    }
 
    var playtapped = Bool()
    
    @IBAction func tapText(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "AudioToText", sender: self)
        
        
    }
    func nextcount() {
        
        
        if counter > audiofiles.count-2 {
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
            if freepressed {
                
                
            } else {
                
                
                
            }
            
            if uid != "" {
                
                ref?.child("Users").child(uid).child("Library").child("InProgress").child(selectedtitle).removeValue()
                
                ref?.child("Snippets").child("Users").child(uid).child("Library").child("InProgress").child(selectedtitle).updateChildValues(["Name" : selectedtitle, "Author" : selectedauthor, "Image": selectedimagename, "Genre" : selectedgenre, "BookID" : selectedbookid, "Completed" : "Yes", "Description" : selecteddescription, "Views" : selectedviews])
                
                
            }
            
            
            selectedimage = cover.image!
            
            self.performSegue(withIdentifier: "AudioToCompleted", sender: self)
            
            
        } else {
            
            counter += 1
            loadselectedaudio()
            
        }
        
        
    }
    
//    var player: AVAudioPlayer?

    var url = URL(string: "www.google.com")

    func loadselectedaudio() {
        


        url = URL(string: audiofiles[counter])
        
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
//        self.view.layer.addSublayer(playerLayer)
        
        player!.play()
        
        
        
        let asset = AVURLAsset(url: url!, options: nil)
        let audioDuration = asset.duration
        
    
        duration = CMTimeGetSeconds(audioDuration)
        
        musictimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AudioViewController.musicProgress), userInfo: nil, repeats: true)

    }
    
    var musictimer = Timer()
    var duration = Double()
    
    
    func queryforallaudiofiles() {
        
        audiofiles.removeAll()
        
        ref?.child("AllBooks1").child(selectedgenre).child(selectedbookid).child("Summary").child("Audio").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
         
            
            
            if var activityvalue2 = value?["1"] as? String {
                
                audiofiles.append(activityvalue2)
                
                self.loadselectedaudio()

            }
            
            if var activityvalue2 = value?["2"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["3"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["4"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["5"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["6"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["7"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["8"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["9"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["10"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["11"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["12"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["13"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["14"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["15"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["16"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["17"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["18"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["19"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["20"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["21"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["22"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["23"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["24"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["25"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["26"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["26"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["27"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["28"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["29"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["30"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["31"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["32"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["33"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["34"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["35"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["36"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["37"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["38"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["39"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            if var activityvalue2 = value?["40"] as? String {
                
                audiofiles.append(activityvalue2)
            }
            
            
        })
        
        
    }
    
    @IBOutlet weak var tapplayorpause: UIButton!
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = Database.database().reference()

    
        
     
        
        queryforallaudiofiles()
        
        titlelabel.text = selectedtitle
        authorlabel.text = selectedauthor
        cover.image = selectedimage
        cover.layer.cornerRadius = 5.0
        cover.layer.masksToBounds = true
        backimage.image = selectedimage
        
        playtapped = false
        x2speed = false
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        // Do any additional setup after loading the view.
    }
    
    @objc func playButtonTapped(_ sender:UIButton)
    {
      
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped up")
            case UISwipeGestureRecognizerDirection.down:
                self.goodBye(nil)
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped up")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    
    @IBAction func goodBye(_ sender: AnyObject?) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    let swipeDownRec = UISwipeGestureRecognizer()

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

extension CMTime {
    var durationText:String {
        let totalSeconds = CMTimeGetSeconds(self)
        let hours:Int = Int(totalSeconds.truncatingRemainder(dividingBy: 86400) / 3600)
        let minutes:Int = Int(totalSeconds.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds:Int = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        
        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
        
    }
}
