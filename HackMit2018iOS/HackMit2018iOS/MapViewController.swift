//
//  MapViewController.swift
//  HackMit2018iOS
//
//  Created by Justin May on 9/16/18.
//  Copyright © 2018 Justin May. All rights reserved.
//

import UIKit
import AerisWeatherKit
import AerisMapKit

class MapViewController: AWFWeatherMapViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let place = AWFPlace(city: "atlanta", state: "ga", country: "us")
        AWFObservations.sharedService().get(forPlace: place, options: nil) { (result) in
            guard let results = result?.results else { print("Observation data failed to load - \(String(describing: result?.error))"); return }
            
            if let obs = results.first as? AWFObservation {
                // do something with obs...
            }
        }
    }
   

}

