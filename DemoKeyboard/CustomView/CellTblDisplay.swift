//
//  CellTblDisplay.swift
//  DemoKeyboard
//
//  Created by admin on 08/03/21.
//

import UIKit

class CellTblDisplay: UITableViewCell {
    @IBOutlet weak var imgDisplay: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgDisplay.layer.cornerRadius = 10
        self.imgDisplay.layer.borderWidth = 1
        self.imgDisplay.layer.borderColor = UIColor.clear.cgColor

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
