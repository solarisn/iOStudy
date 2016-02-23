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


class FirstViewController: UIViewController, UINavigationBarDelegate {
    
    // Map outlet declaration
    @IBOutlet weak var beaconMap: MKMapView!
    
    @IBOutlet weak var mapView: UIView!
    //@IBOutlet var whiteSquare: UIView!
    
    @IBAction func beaconButton(sender: AnyObject?) {
        
        //var x = view.subviews[0]
        
        UIView.animateWithDuration(0.5, animations: {
            
           self.view.subviews[0].center.y += self.view.bounds.height
        })
        print ("it tried")
        
    }
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
    }
    
    override func viewWillAppear(animated: Bool) {
        
        /*
        whiteSquare.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        
        whiteSquare.center.y -= self.view.bounds.height
        */
        //self.whiteSquare.center.x = self.view.center.x
        /*
        let x = self.view.frame.width - 50000
        
        let frame = CGRect(x: 20,y: 20, width: 10, height: 10)
        let whiteSquare = UIView(frame: frame)
        self.view.addSubview(whiteSquare)
        //self.whiteSquare.center.y += self.view.bounds.height
        self.whiteSquare.backgroundColor = UIColor.redColor()
        */
    }
    
    
    
    // beaconView beacon overlay outlet
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //navigationBar.tintColor = UIColor.blueColor()
        
        let initialLocation = CLLocation(latitude: 41.661437, longitude: -91.536105)
        let regionRadius: CLLocationDistance = 500
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                regionRadius * 2.0, regionRadius * 2.0)
            beaconMap.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(initialLocation)
        
        var beaconView: UIView = UIView(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height))
        beaconView.backgroundColor = UIColor.redColor()
        beaconView.center.y += self.view.bounds.height
        self.view.addSubview(beaconView)
        
        
        /**
        self.whiteSquare.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        
        self.whiteSquare.center.y -= self.view.bounds.height
        self.whiteSquare.backgroundColor = UIColor.whiteColor()
        print (whiteSquare)
        view.addSubview(whiteSquare)
        **/
        
        /*
        whiteSquare.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        
        whiteSquare.center.y -= view.bounds.height
        */
        
        //whiteSquare.center.y -= view.bounds.height
        
        
        
        
        // Create Beacon View
        /*
        let x = self.view.frame.width - 50000
        
        let frame = CGRect(x: 0,y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        let whiteSquare = UIView(frame: frame)
        whiteSquare.backgroundColor = UIColor.redColor()
        whiteSquare.center.y -= self.view.bounds.height
        self.view.addSubview(whiteSquare)
        //self.whiteSquare.center.y += self.view.bounds.height
        //self.whiteSquare.backgroundColor = UIColor.redColor()
        */
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

