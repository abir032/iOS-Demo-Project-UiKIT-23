//
//  firstSection.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 21/12/22.
//

import UIKit

class FirstSection: UITableViewCell {


    
    @IBOutlet weak var showOption: UIButton!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var titleInput: UILabel!
    @IBOutlet weak var imagesSet: UIImageView!
    var buttonForIndex: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
    @IBAction func showOptionAction(_ sender: Any) {
        
    }
    
    
}
