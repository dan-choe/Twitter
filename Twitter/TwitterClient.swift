//
//  TwitterClient.swift
//  Twitter
//
//  Created by Admin on 2/26/16.
//  Copyright © 2016 DanChoe. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "K64z31U1bkxsyPPbf60geSUUn", consumerSecret: "E56jlei8z7yjrxfTLeTGjdrZcYfFHnIzLZfeeBzN7Yyqa1tt4U")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> () ) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            
            /*
                for tweet in tweets {
                    print("\(tweet.text)")
                }
            */
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
               failure(error)
        })

    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            /*
            
            print("account: \(response)")
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            //print("account: \(user!["name"])")
            
            print("account: \(user.name)")
            print("screenname: \(user.screen_name)")
            print("profile url: \(user.profile_image_url_https)")
            print("description: \(user.tagline)")
            
            print("account: \(user!["name"])")

            
            */
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
          
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })

    }
    
    func login(success: () -> (), failure: (NSError) -> () ){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil,
            success: { (requestToken:BDBOAuth1Credential!) -> Void in
                print("I got a token!")
                
                let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
                UIApplication.sharedApplication().openURL(url)
                
            }){ (error: NSError!) -> Void in
                print("error:  \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.UserDidLogoutNotification, object: nil)
    }
    
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken,
            success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
                self.currentAccount({ (user: User) -> () in
                    User.currentUser = user
                    self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
                })
                
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    //completion: (tweet: Tweet?, error: NSError?) -> ()
    func retweet(tweetID: NSNumber) {
        POST("1.1/statuses/retweet/\(tweetID).json", parameters: nil, progress: { (progress) -> Void in
            }, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
        })
    }
    //completion: (tweet: Tweet?, error: NSError?) -> ()
    func favorite(tweetID: NSNumber, favorite: Bool) {
        POST("1.1/favorites/create.json?id=\(tweetID)", parameters: nil, progress: { (progress) -> Void in
            }, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
        })
    }
    
    func cancelFavorite(tweetID: NSNumber, favorite: Bool, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("/1.1/favorites/destroy.json", parameters: nil, progress: { (progress) -> Void in
            }, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
        })
    }
    
}
