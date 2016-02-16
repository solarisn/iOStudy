//
//  BeaconViewController.swift
//  up
//
//  Created by Solaris Nite on 2/9/16.
//  Copyright © 2016 Solaris Nite. All rights reserved.
//

import UIKit

class BeaconViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        self.view.center.y += self.view.frame.height

        // Do any additional setup after loading the view.
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
