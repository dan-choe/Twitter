//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Admin on 2/28/16.
//  Copyright © 2016 DanChoe. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileUsername: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var tweetTime: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
       
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
