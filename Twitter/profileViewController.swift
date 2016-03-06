//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Admin on 3/6/16.
//  Copyright © 2016 DanChoe. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var user : User?
    var tweets : [Tweet]?
    
    @IBOutlet weak var profileBg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileId: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        profileBg.setImageWithURL((user?.bgUrl)!)
        profileImg.setImageWithURL((user?.profileUrl)!)
        profileName.text = user?.name as! String
        profileId.text = "@\(user?.screenname)"
        tweetCount.text = "\(user!.tweetCount)"
        followingCount.text = "\(user!.following)"
        followerCount.text = "\(user!.followers)"
        
        print("profile view")
        
        TwitterClient.sharedInstance.userTimeline(user!.screenname! as String, success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            print(self.tweets)
            self.tableView.reloadData()
            }) { (error:NSError) -> () in
                print("error")
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileTableViewCell
        
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        }
        return 0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
