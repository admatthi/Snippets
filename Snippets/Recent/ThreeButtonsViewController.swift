//
//  ThreeButtonsViewController.swift
//  
//
//  Created by Alek Matthiessen on 1/10/19.
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

var selectedscreenshot = UIImage()

class ThreeButtonsViewController: UIViewController {

    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func tapBuy(_ sender: Any) {
        
        if let url = NSURL(string: selectedurl
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    var bookmarktapped = Bool()
    
    var randomstring = String()
    
    @IBAction func tapBookMark(_ sender: Any) {
        
    
            
            if bookmarktapped {
                
            ref?.child("Snippets").child("Users").child(uid).child("Favorites").child(randomstring).removeValue()
                
                tapbookmark.setImage(UIImage(named: "BookMarkNew"), for: .normal)
                
                bookmarktapped = false
                
            } else {
                
                tapbookmark.setImage(UIImage(named: "BookMarkFull"), for: .normal)
                
            ref?.child("Snippets").child("Users").child(uid).child("Favorites").child(randomstring).updateChildValues(["Text" : selectedtext, "Image" : selectedimagename])
                
                bookmarktapped = true
                
            }
        
        
    }
    @IBAction func tapShare(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Share This Snippet", style: .default, handler: { action in
            switch action.style{
            case .default:
                
                let text = "You should read this Snippet from \(selectedauthor)'s \(selectedtitle)."
                
                var image = screenshot
              
                let myWebsite = NSURL(string: "https://snippets.page.link/share")
                
                let shareAll : Array = [text, image, myWebsite] as [Any]
                
                
                let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
                
                activityViewController.excludedActivityTypes = [UIActivityType.print, UIActivityType.postToWeibo, UIActivityType.addToReadingList, UIActivityType.postToVimeo, UIActivityType.saveToCameraRoll, UIActivityType.assignToContact]
                
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        present(alert, animated: true)
    }
    @IBOutlet weak var tapbookmark: UIButton!
    @IBOutlet weak var tapbuy: UIButton!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var mainimage: UIImageView!
    @IBOutlet weak var textlabel: UILabel!
    @IBOutlet weak var background: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        background.layer.cornerRadius = 5.0
        background.layer.masksToBounds = true
        textlabel.text = selectedtext
        authorlabel.text = selectedauthor
        titlelabel.text = selectedtitle
        mainimage.image = selectedimage
        mainimage.layer.cornerRadius = 5.0
        mainimage.layer.masksToBounds = true
        randomstring = UUID().uuidString

        tapbookmark.setImage(UIImage(named: "BookMarkNew"), for: .normal)

        if selectedurl != "" {
            
            tapbuy.alpha = 1
            
        } else {
            
            tapbuy.alpha = 0
        }
        
        if Auth.auth().currentUser == nil {

            tapbookmark.alpha = 0
            
        } else {
            
            tapbookmark.alpha = 1

        }
        // Do any additional setup after loading the view.
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
