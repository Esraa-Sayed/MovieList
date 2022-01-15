//
//  TableViewCell.swift
//  MovieList
//
//  Created by esraa on 1/15/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var myRating: UILabel!
    @IBOutlet weak var myGenere: UILabel!
    @IBOutlet weak var myimag: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
