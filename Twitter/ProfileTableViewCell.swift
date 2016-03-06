//
//  ProfileTableViewCell.swift
//  Twitter
//
//  Created by Admin on 3/6/16.
//  Copyright © 2016 DanChoe. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var profileId: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    var tweet: Tweet? {
        didSet {
            
            profileImg.setImageWithURL((tweet?.user?.profileUrl)!)
            
            profileId.text = "@\((tweet?.user?.screenname!)!)"
            profileName.text = tweet?.user?.name as? String
            
            tweetText.text = tweet?.text

        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
