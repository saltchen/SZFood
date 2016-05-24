//
//  DiscoverTableViewCell.swift
//  SZFood
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 saltchen. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewd: UIImageView!
    @IBOutlet weak var nameD: UILabel!
    @IBOutlet weak var typeD: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
