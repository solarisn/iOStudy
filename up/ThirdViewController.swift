//
//  ThirdViewController.swift
//  up
//
//  Created by Solaris Nite on 11/15/15.
//  Copyright © 2015 Solaris Nite. All rights reserved.
//

import Foundation
import UIKit

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let socket = SocketIOClient(socketURL: "localhost:", options: [.Log(true), .ForcePolling(true)])
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        socket.on("currentAmount") {data, ack in
            if let cur = data[0] as? Double {
                socket.emitWithAck("canUpdate", cur)(timeoutAfter: 0) {data in
                    socket.emit("update", ["amount": cur + 2.50])
                }
                
                ack.with("Got your currentAmount", "dude")
            }
        }
        
        socket.connect()
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
