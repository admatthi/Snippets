//
//  ScrollTableViewCell.swift
//  Bolts
//
//  Created by Alek Matthiessen on 10/17/18.
//

import UIKit

class ScrollTableViewCell: UITableViewCell {

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
