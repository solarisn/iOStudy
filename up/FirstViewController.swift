//
//  FirstViewController.swift
//  up
//
//  Created by Solaris Nite on 9/26/15.
//  Copyright © 2015 Solaris Nite. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import MapKit


class FirstViewController: UIViewController {
    
    // Map outlet declaration
    @IBOutlet weak var beaconMap: MKMapView!
    
    @IBOutlet var whiteSquare: UIView!
    
    @IBAction func beaconButton(sender: AnyObject) {
        
        UIView.animateWithDuration(2, animations: {
            self.whiteSquare.frame = CGRect(x: self.view.center.x,y: self.view.center.y, width: self.view.bounds.width, height: self.view.bounds.height)
        })
        print ("it tried")
        
    }
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let frame = CGRect(x: 0,y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.whiteSquare.backgroundColor = UIColor.whiteColor()
        self.whiteSquare.center.y += self.view.bounds.height
        //let whiteSquare = UIView(frame: frame)
        view.addSubview(whiteSquare)
        
    }
    
    
    
    // beaconView beacon overlay outlet
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let initialLocation = CLLocation(latitude: 41.661437, longitude: -91.536105)
        let regionRadius: CLLocationDistance = 500
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                regionRadius * 2.0, regionRadius * 2.0)
            beaconMap.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(initialLocation)
        
        // Create Beacon View

        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

