//
//  LoginController.swift
//  up
//
//  Created by Solaris Nite on 9/26/15.
//  Copyright © 2015 Solaris Nite. All rights reserved.
//

import Foundationsdfsdf
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit



class LoginController: UIViewController, FBSDKLoginButtonDelegate {
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name,email"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName = result.valueForKey("name")
                print("User Name is: \(userName)")
                let userEmail = result.valueForKey("email")
                print("User Email is: \(userEmail)")
                let userFriends = result.valueForKey("friends")
                print("One of their friends is: \(userFriends)")
                let userProfile = result.valueForKey("")
                print("\(userProfile)")
                let token = FBSDKAccessToken.currentAccessToken()
                print("\(token)")
            }
        })
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        returnUserData()
        print("User Logged In")
        
        performSegueWithIdentifier("showHome", sender: nil)
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
   override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (FBSDKAccessToken.currentAccessToken()==nil){
            print("Not Logged In.")
        }
        else{
            print("Logged In.")
            self.performSegueWithIdentifier("showHome", sender: self)
        }
        
        var loginView = FBSDKLoginButton()
        loginView.readPermissions = ["public_profile","email","user_friends"]
        loginView.center = self.view.center //put in center of screen
        
        loginView.delegate = self
        self.view.addSubview(loginView)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}