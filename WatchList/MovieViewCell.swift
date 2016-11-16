//
//  MovieViewCell.swift
//  WatchList
//
//  Created by Christopher Ras on 16/11/2016.
//  Copyright © 2016 Chris Ras. All rights reserved.
//

import UIKit

class MovieViewCell: UITableViewCell {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
