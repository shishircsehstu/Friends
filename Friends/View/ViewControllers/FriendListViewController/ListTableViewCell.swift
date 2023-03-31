//
//  ListTableViewCell.swift
//  Friends
//
//  Created by Md Saddam Hossain on 30/3/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var personThumbImage: UIImageView!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
