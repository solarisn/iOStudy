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
    
    
    @IBAction func beaconButton(sender: UIButton) {
        
        performSegueWithIdentifier("showBeacon", sender: self)
    }
    
    @IBOutlet weak var beaconMap: MKMapView!
    

    
    
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
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

