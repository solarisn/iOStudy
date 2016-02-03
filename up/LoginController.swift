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
                            
                            
                            if (res["user"]! != nil) {
                                print("There is a user object")
                                
                                var person = res["user"]!
                                let fullName = person!["name"]! as! String
                                let uniqueID = person!["id"]! as! String
                                let fbID = person!["FBid"]! as! String
                                let email = person!["email"]! as! String
                                let gender = person!["gender"]! as! String
                                let timezone = person!["timezone"]! as! NSNumber
                                let jwt = res["jwt"]!!["token"] as! String
                                let expires = res["jwt"]!!["expires"] as! NSNumber
                                
                                User.setValue(fullName, forKey: "fullName")
                                User.setValue(uniqueID, forKey: "uniqueID")
                                User.setValue(fbID, forKey: "fbID")
                                User.setValue(email, forKey: "email")
                                User.setValue(gender, forKey: "gender")
                                User.setValue(timezone, forKey: "timezone")
                                User.setValue(jwt, forKey: "jwt")
                                User.setValue(expires, forKey: "expires")
                                
                                
                                
                                
                            }
                            else {
                                print("There is no user object available.")
                                let jwt = res["token"] as! String
                                let expires = res["expires"] as! NSNumber
                                
                                User.setValue(jwt, forKey: "jwt")
                                User.setValue(expires, forKey: "expires")
                                
                                
                            }
                            
                            
                            //4
                            
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
            FBSDKAccessToken.currentAccessToken()
            print("Logged In.")
            self.performSegueWithIdentifier("showHome", sender: self)
        }
        
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
}