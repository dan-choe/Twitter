//
//  Tweet.swift
//  Twitter
//
//  Created by Admin on 2/26/16.
//  Copyright © 2016 DanChoe. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var tweetID: NSNumber?

    var text: String?
    var timeStamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(dictionary: NSDictionary){
        
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        tweetID = dictionary["id"] as? Int
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.timeZone = NSTimeZone(name: "EST")
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.dateFromString(timestampString)
        }
    }
    

    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{

        var tweets = [Tweet]()

        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    
    
   }
