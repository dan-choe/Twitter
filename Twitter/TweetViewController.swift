//
//  TweetViewController.swift
//  Twitter
//
//  Created by Admin on 2/26/16.
//  Copyright © 2016 DanChoe. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]!
    var tweet: Tweet!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.38, green: 0.60, blue: 0.94, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.dataSource = self
            self.tableView.delegate = self
            /*
            for tweet in tweets {
                print(tweet.text)
            }
            */
            self.tableView.reloadData()
            
        }, failure: {(error:NSError) -> () in
                print(error.localizedDescription)
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil{
            return tweets.count
        }else{
            return 0
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetTableViewCell
        
        let tweet = tweets![indexPath.row]
        
        if let user = tweet.user {
            cell.profileImageView.setImageWithURL(user.profileUrl!)
            //print(user.profileUrl)
            cell.profileName.text = user.name! as String
            cell.profileUsername.text = "@\(user.screenname!)"
            
            let formatter = NSDateFormatter()
            formatter.timeZone = NSTimeZone(name: "EST")
            formatter.dateFormat = "MMM d HH:mm"

            cell.tweetTime.text = formatter.stringFromDate(tweet.timeStamp!)
            cell.tweetText.text = tweet.text
            
            cell.favoriteCount.text = "\(tweet.favoritesCount)"
            cell.retweetCount.text = "\(tweet.retweetCount)"
        }
        
        return cell
    }
    
    @IBAction func retweet(sender: AnyObject) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetTableViewCell
        
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        
        TwitterClient.sharedInstance.retweet(tweet.tweetID!)
        tweet.retweetCount = tweet.retweetCount + 1
        self.tableView.reloadData()
    }
    
    @IBAction func favorite(sender: AnyObject) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetTableViewCell
        
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        
        TwitterClient.sharedInstance.favorite(tweet.tweetID!, favorite: true)
        tweet.favoritesCount = tweet.favoritesCount + 1
        self.tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]

        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.tweet = tweet
        
        
        
        
        
        print("prepare for segue called")
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
