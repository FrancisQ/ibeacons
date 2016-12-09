//
//  ViewController.swift
//  ibeacons
//
//  Created by Francis Quintal on 2016-11-18.
//  Copyright © 2016 Francis Quintal. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    @IBOutlet weak var textlabel: UILabel!
    //this limits which ibeacons are visible
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "C6C4C829-4FD9-4762-837C-DA24C665015A")!, identifier: "BCIT")
    
    let colors = [
        363: UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
        372: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
        ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse){
            
            //if you wan to check only when app is open
            locationManager.requestWhenInUseAuthorization()
            //if you want to always be checking (must change line above too!
            //locationManager.requestAlwaysAuthorization()

        }
        //start to look for beacon activity
         locationManager.startMonitoring(for: region)
        locationManager.startRangingBeacons(in: region)
    }
    


    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        //print(beacons)
        
        
        //Major = 1 x2
        //Minor = 363 & 372
        
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.unknown }
        if (knownBeacons.count > 0) {
            
            let closestBeacon = knownBeacons[0] as CLBeacon
            let num  = closestBeacon.proximity.rawValue
            var color = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            
            if(closestBeacon.minor == 363){
                textlabel.text = "B#1"
            }else if (closestBeacon.minor == 372){
                    textlabel.text = "B# 2"
            }

            print (num)
            if(num == 1){
                 color = UIColor.red
            }
            else if(num == 2){
                 color = UIColor.orange
                
            }
            else if(num == 3){
                 color = UIColor.blue
            }
            
            //UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1)
            self.view.backgroundColor = color
                //self.colors[closestBeacon.minor.intValue]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//https://willd.me/posts/getting-started-with-ibeacon-a-swift-tutorial
//USE THIS^^^^
}

