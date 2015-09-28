//
//  LoginController.swift
//  up
//
//  Created by Solaris Nite on 9/26/15.
//  Copyright © 2015 Solaris Nite. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginController: UIViewController, FBSDKLoginButtonDelegate {
    
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
        
        var loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile","email","user_friends"]
        loginButton.center = self.view.center //put in center of screen
        
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark - Facebook Login
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if (error == nil) {
            
            print("Login Complete")
            self.performSegueWithIdentifier("showHome", sender: self)
            
        }
        else
        {
            print(error.localizedDescription)
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
}
