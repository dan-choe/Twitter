//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Admin on 3/6/16.
//  Copyright © 2016 DanChoe. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    var user : User?
    
    @IBOutlet weak var userText: UITextView!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userId.text = user?.screenname as! String
        userName.text = user?.name as! String
        userImg.setImageWithURL((user?.profileUrl)!)
        

        // Do any additional setup after loading the view.
    }

    @IBAction func tweetBtnOn(sender: AnyObject) {
        print(userText.text)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
