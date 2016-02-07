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
import Alamofire
import CoreData



class LoginController: UIViewController, FBSDKLoginButtonDelegate {
    
    func loginFunction()
    {
        let token = FBSDKAccessToken.currentAccessToken().tokenString
        
        if ((token) != nil) {
            
            Alamofire.request(.GET, "http://studyapplication.herokuapp.com/user/login", parameters: ["token": token])
                .responseJSON { response in
                    let res = response.result.value!
                    
                    // Initialize User Model
                    
                    let appDelegate =
                    UIApplication.sharedApplication().delegate as! AppDelegate
                    
                    let managedContext = appDelegate.managedObjectContext
                    
                    let entity =  NSEntityDescription.entityForName("User",
                        inManagedObjectContext:managedContext)
                    
                    let User = NSManagedObject(entity: entity!,
                        insertIntoManagedObjectContext: managedContext)
                    /////////////////////////////////////////////////////////////////
                    // unwrapping JWT json response object containing 'token' and 'expires'
                    let jwt = res["jwt"]!
                    
                    let token = jwt!["token"] as! String
                    let expires = jwt!["expires"] as! NSNumber
                    
                    User.setValue(token, forKey: "jwt")
                    User.setValue(expires, forKey: "expires")
                    
                    if (res["user"]! != nil) {
                        //the user json object
                        let person = res["user"]!
                        
                        let fullName = person!["name"]! as! String
                        let uniqueID = person!["id"]! as! String
                        let fbID = person!["FBid"]! as! String
                        let email = person!["email"]! as! String
                        let gender = person!["gender"]! as! String
                        let timezone = person!["timezone"]! as! NSNumber
                        
                        User.setValue(fullName, forKey: "fullName")
                        User.setValue(uniqueID, forKey: "uniqueID")
                        User.setValue(fbID, forKey: "fbID")
                        User.setValue(email, forKey: "email")
                        User.setValue(gender, forKey: "gender")
                        User.setValue(timezone, forKey: "timezone")
                        
                    }
                    
                    
                    // Save user model to persistent storage
                    
                    do {
                        try managedContext.save()
                        
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                    
                    //2
                    let fetchRequest = NSFetchRequest(entityName: "User")
                    
                    //3
                    do {
                        let results =
                        try managedContext.executeFetchRequest(fetchRequest)
                        var Retrieved = results as! [NSManagedObject]
                        print (Retrieved)
                        
                        
                    } catch let error as NSError {
                        print("Could not fetch \(error), \(error.userInfo)")
                    }
                    

                    
                    
            }
            

            
        }
    }
        //})
    //}
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if ((error) != nil)
        {
            print ("There was an error fetching from facebook")
        }
        else if result.isCancelled {
            print ("The result was cancelled")
        }
        else {
            loginFunction()
            performSegueWithIdentifier("showHome", sender: nil)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    
    // MAIN
   override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    var loginView = FBSDKLoginButton()
        loginView.readPermissions = ["public_profile","email","user_friends", "user_birthday","user_education_history","user_location"]
        loginView.center = self.view.center //put in center of screen
    
        loginView.delegate = self
        self.view.addSubview(loginView)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if (FBSDKAccessToken.currentAccessToken()==nil){
            print("Not Logged In.")
        }
        else {
            var token = FBSDKAccessToken.currentAccessToken().tokenString
            print("Logged In.")
            self.performSegueWithIdentifier("showHome", sender: self)
        }
    }
    
    
    
}