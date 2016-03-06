//
//  User.swift
//  Twitter
//
//  Created by Admin on 2/26/16.
//  Copyright © 2016 DanChoe. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var bgUrl: NSURL?
    var tagline: NSString?
    var tweetCount : Int = 0
    var following : Int = 0
    var followers : Int = 0
    var dictionary: NSDictionary?
    static let UserDidLogoutNotification = "UserDidLogout"
    static var _currentUser: User?

    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        
        let bgUrlString = dictionary["profile_background_image_url_https"] as? String
        if let bgUrlString = bgUrlString {
            bgUrl = NSURL(string: bgUrlString)
        }
        
        tweetCount = (dictionary["statuses_count"] as? Int) ?? 0
        following = (dictionary["friends_count"] as? Int) ?? 0
        followers = (dictionary["followers_count"] as? Int) ?? 0

        tagline = dictionary["description"] as? String
        /// self.dictionary = dictionary
    }
    
    
    class var currentUser: User? {
        get{
            if _currentUser == nil {
        
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
        
                if let userData = userData {
        
                        let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: [])
        
                        _currentUser = User(dictionary: dictionary as! NSDictionary)
//                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
//                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
            
        }
        set(user){
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()
            if let user = user{
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            }else{
                defaults.setObject(nil, forKey: "currentUserData")
            }
           
            defaults.synchronize()
        }
    }
    
}
