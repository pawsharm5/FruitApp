//
//  FruitListTblCell.swift
//  FruitApp
//
//  Created by Pawan Sharma on 11/08/23.
//

import UIKit

class FruitListTblCell: UITableViewCell {
    @IBOutlet weak var LabelFruitName: UILabel!
    @IBOutlet weak var LabelFruitCategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpData(name:String, typeName:String) {
        self.LabelFruitName.text = name
        self.LabelFruitCategory.text = typeName
    }
}
