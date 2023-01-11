//
//  UserProfileTableViewCell.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 9/1/23.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var isOnline: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
