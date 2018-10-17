//
//  Scroll2TableViewCell.swift
//  Snippets
//
//  Created by Alek Matthiessen on 10/17/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class Scroll2TableViewCell: UITableViewCell {

    
    @IBOutlet weak var tapprevious: UIButton!
    @IBOutlet weak var tapnext: UIButton!
    @IBOutlet weak var textlabel: UILabel!
    @IBOutlet weak var readerbackground: UILabel!
    @IBOutlet weak var backgroundlabel: UILabel!
    @IBOutlet weak var introlabel: UILabel!
    @IBOutlet weak var swiperightlabel: UILabel!
    @IBOutlet weak var coverimage: UIImageView!
    @IBOutlet weak var smallimage: UIImageView!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
