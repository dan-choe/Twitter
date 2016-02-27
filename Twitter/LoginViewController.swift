//
//  LoginViewController.swift
//  Twitter
//
//  Created by Admin on 2/26/16.
//  Copyright © 2016 DanChoe. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLoginButton(sender: AnyObject) {
        
        TwitterClient.sharedInstance.login({ () -> () in
            print("I've logged in!")
            
            self.performSegueWithIdentifier("loginSegue", sender: nil)
            
            }) { (error: NSError) -> () in
                print("Error: \(error.localizedDescription)")
        }
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
