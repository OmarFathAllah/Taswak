//
//  ProfileListTableViewCell.swift
//  Taswak
//
//  Created by omar  on 03/09/2022.
//

import UIKit

class ProfileListTableViewCell: UITableViewCell {

    @IBOutlet weak var profileListImage: UIImageView!
    @IBOutlet weak var profileListNameLabel: UILabel!
    static let identifier = String(describing: ProfileListTableViewCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
