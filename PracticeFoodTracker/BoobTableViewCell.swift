//
//  BoobTableViewCell.swift
//  PracticeBoobsTracker
//
//  Created by Lezardvaleth on 2019/2/12.
//  Copyright © 2019 Lezardvaleth. All rights reserved.
//

import UIKit

class BoobTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
