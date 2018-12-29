//
//  ReaderTableViewCell.swift
//  Snippets
//
//  Created by Alek Matthiessen on 12/28/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class ReaderTableViewCell: UITableViewCell {

    @IBOutlet weak var tapright: UIButton!
    @IBOutlet weak var tapleft: UIButton!
    @IBOutlet weak var maintext: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
