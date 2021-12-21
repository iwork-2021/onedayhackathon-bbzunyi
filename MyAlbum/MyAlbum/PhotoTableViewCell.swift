//
//  PhotoTableViewCell.swift
//  New_album
//
//  Created by bb on 2021/12/21.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var type_text: UILabel!
    @IBOutlet weak var image_view: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
