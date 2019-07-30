//
//  FavoritesTableViewCell.swift
//  Eat
//
//  Created by Alek Matthiessen on 7/16/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var imagecover: UIImageView!
    @IBOutlet weak var favoritelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
