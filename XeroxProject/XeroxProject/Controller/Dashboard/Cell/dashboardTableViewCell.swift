//
//  dashboardTableViewCell.swift
//  XeroxProject
//
//  Created by Nishanth on 07/08/24.
//

import UIKit

class dashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var devicestatusLabel: UILabel!
    @IBOutlet weak var deviceIpLabel: UILabel!
    @IBOutlet weak var deviceNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
