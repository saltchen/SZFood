//
//  ResDetailTableViewCell.swift
//  SZFood
//
//  Created by admin on 16/5/15.
//  Copyright © 2016年 saltchen. All rights reserved.
//

import UIKit

class ResDetailTableViewCell: UITableViewCell {
   
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    
    

    override func awakeFromNib() {
       
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
