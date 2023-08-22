//
//  FruitListTblCell.swift
//  FruitApp
//
//  Created by Pawan Sharma on 11/08/23.
//

import UIKit

class FruitListTblCell: UITableViewCell {
    @IBOutlet weak var LabelFruitName: UILabel!
    @IBOutlet weak var LabelFamilyName: UILabel!
    @IBOutlet weak var LabelFamilyGenus: UILabel!
    @IBOutlet weak var LabelFamilyOrder: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
