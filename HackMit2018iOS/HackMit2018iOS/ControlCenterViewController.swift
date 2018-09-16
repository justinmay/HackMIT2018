//
//  ControlCenterViewController.swift
//  HackMit2018iOS
//
//  Created by Justin May on 9/15/18.
//  Copyright © 2018 Justin May. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ControlCenterViewController: UIViewController {

    @IBOutlet var controlCenterView: UIView!
    @IBOutlet weak var resQbutton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var waterButton: UIButton!
    @IBOutlet weak var hosptitalButton: UIButton!
    @IBOutlet weak var shelterButton: UIButton!
    @IBOutlet weak var gasButton: UIButton!
    
    var type:String = ""
    override func prepare (for segue: UIStoryboardSegue, sender: Any!) {
        if(segue.identifier == "VRsegue") {
            let svc = segue.destination as! ARViewController
            svc.typePassed = type
        }
    }
    
    @IBAction func foodButtonTouch(_ sender: Any) {
        //Tell ARViewController Food
        type = "food"
        self.performSegue(withIdentifier: "VRsegue", sender: nil)
    }
    
    @IBAction func waterButtonTouch(_ sender: Any) {
        type = "water"
        self.performSegue(withIdentifier: "VRsegue", sender: nil)
    }
    
    @IBAction func hospitalButtonTouch(_ sender: Any) {
        type = "hospital"
        self.performSegue(withIdentifier: "VRsegue", sender: nil)
    }
    
    
    @IBAction func gasButtonTouch(_ sender: Any) {
        type = "gas"
        self.performSegue(withIdentifier: "VRsegue", sender: nil)
    }
    
    
    @IBAction func shelterButtonTouch(_ sender: Any) {
        type = "shelter"
        self.performSegue(withIdentifier: "VRsegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
        setUpViews()
        //getWeather()
        getAPIWeather()

        // Do any additional setup after loading the view.
    }
    
    func setUpViews() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: controlCenterView.frame.width, height: controlCenterView.frame.height))
        let gradient = CAGradientLayer()
        let top = UIColor(red:0.76, green:0.08, blue:0.20, alpha:1.0)
        let bottom = UIColor(red:0.14, green:0.04, blue:0.21, alpha:1.0)
        
        gradient.frame = view.bounds
        gradient.colors = [top.cgColor, bottom.cgColor]
        
        self.view.layer.insertSublayer(gradient, at: 0)

    }
    
    func setUpButtons() {
        print("setting up buttons")
        resQbutton.titleLabel?.textColor = UIColor.white
        foodButton.titleLabel?.textColor = UIColor.white
        waterButton.titleLabel?.textColor = UIColor.white
        hosptitalButton.titleLabel?.textColor = UIColor.white
        shelterButton.titleLabel?.textColor = UIColor.white
        gasButton.titleLabel?.textColor = UIColor.white

    }
    
    func getAPIWeather() {
        
        let url = "https://api.weather.com/v3/alerts/headlines"

        let parameters: Parameters = [
            "geocode": "32.66,-80.07",
            "format": "json",
            "language": "en-US",
            "apiKey":"da328055e2e940d8b28055e2e9e0d851"
        ]
        
        let headers: HTTPHeaders = [
            "Accept-Encoding": "gzip",
            "accept": "application/json"
        ]
        
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func getWeather() {

        let parameters: Parameters = [
            "username": "b51504d8-d80f-4e1c-b491-89d9ebd18df4",
            "password": "k57wHEq8P4",
            "host": "twcservice.mybluemix.net",
            "port": 443
        ]
        
        let url =  "https://b51504d8-d80f-4e1c-b491-89d9ebd18df4:k57wHEq8P4@twcservice.mybluemix.net/v1/geocode/33.40/83.42/alerts.json"
        
        Alamofire.request(url, parameters: parameters).responseString { response in
            //print(response)
            debugPrint(response)
        }
        
    }

}
