//
//  ReadTableViewCell.swift
//  
//
//  Created by Alek Matthiessen on 7/10/18.
//

import UIKit

class ReadTableViewCell: UITableViewCell {

    @IBOutlet weak var quotenumber: UILabel!
    @IBOutlet weak var BACKLABEL: UILabel!
    @IBOutlet weak var quotelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
