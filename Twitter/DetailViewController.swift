//
//  DetailViewController.swift
//  Twitter
//
//  Created by Admin on 3/6/16.
//  Copyright © 2016 DanChoe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var tweet: Tweet!

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileId: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    
    let profilePush = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = tweet.user
        
        profileImg.setImageWithURL(user!.profileUrl!)
        profileImg.userInteractionEnabled = true
        profileImg.addGestureRecognizer(profilePush)
        profilePush.addTarget(self, action: "profileView")
        
        
        profileName.text = user?.name as! String
        profileId.text = "@\(user!.screenname!)"
        tweetText.text = tweet.text
        
        retweetCount.text = "\(tweet.retweetCount)"
        favoriteCount.text = "\(tweet.favoritesCount)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func profileView() {
        performSegueWithIdentifier("profile", sender: profileImg)
    }
    
    @IBAction func replyOn(sender: AnyObject) {
    }

    @IBAction func retweetOn(sender: AnyObject) {
    }
    
    @IBAction func favoriteOn(sender: AnyObject) {
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "profile"){
        let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.user = tweet!.user
        }else{
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.user = tweet!.user
        }
        /*

if(segue.identifier == "replyCompose") {
let vc = segue.destinationViewController as! ComposeViewController
vc.user = User.currentUser
vc.inReplyTo = tweet!.id!
vc.replyUserName = tweet!.user!.screenname!
}
else {
let vc = segue.destinationViewController as! UserViewController
vc.user = tweet!.user
}

*/

    }


}
