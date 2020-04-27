//
//  TicketUITableViewCell.swift
//  Raffle
//
//  Created by Vinh Nguyen on 20/4/20.
//  Copyright © 2020 StarWen. All rights reserved.
//

import UIKit

class TicketUITableViewCell: UITableViewCell {
    
    @IBOutlet var CustomerNameLabel: UILabel!
    @IBOutlet var TicketNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
