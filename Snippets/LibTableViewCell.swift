//
//  LibTableViewCell.swift
//  Snippets
//
//  Created by Alek Matthiessen on 9/10/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class LibTableViewCell: UITableViewCell {

    @IBOutlet weak var lock: UIImageView!
    @IBOutlet weak var rectangle: UIImageView!
    @IBOutlet weak var emptylabel: UILabel!
    @IBOutlet weak var upgradelabel: UILabel!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var completed: UIImageView!
    @IBOutlet weak var greenlabel: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var coverimage: UIImageView!
    @IBOutlet weak var bluebutton: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
