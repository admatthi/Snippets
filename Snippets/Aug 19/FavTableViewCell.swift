//
//  FavTableViewCell.swift
//  Snippets
//
//  Created by Alek Matthiessen on 9/10/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class FavTableViewCell: UITableViewCell {

    @IBOutlet weak var lock: UIImageView!
    @IBOutlet weak var bluebutton: UIImageView!
    @IBOutlet weak var upgradelabel: UILabel!
    @IBOutlet weak var emptylabel: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var greenlabel: UILabel!
    @IBOutlet weak var coverimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
