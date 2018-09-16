//
//  AddEventViewController.swift
//  HackMit2018iOS
//
//  Created by Justin May on 9/16/18.
//  Copyright © 2018 Justin May. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet var AddEventView: UIView!
    @IBOutlet weak var alertField: UILabel!
    @IBOutlet weak var powerButton: UIButton!
    @IBOutlet weak var floodingButton: UIButton!
    @IBOutlet weak var petButton: UIButton!
    @IBOutlet weak var roadButton: UIButton!
    @IBOutlet weak var treeButton: UIButton!
    @IBOutlet weak var vandalButton: UIButton!
    @IBOutlet weak var authalertfield: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpButtons()
        // Do any additional setup after loading the view.
    }
    
    func setUpButtons() {
        print("setting up many buttons")
        
        authalertfield.textColor = UIColor.clear
        
        powerButton.layer.cornerRadius = 15
        powerButton.layer.borderWidth = 1
        powerButton.layer.borderColor = UIColor.white.cgColor
        
        floodingButton.layer.cornerRadius = 15
        floodingButton.layer.borderWidth = 1
        floodingButton.layer.borderColor = UIColor.white.cgColor
        
        petButton.layer.cornerRadius = 15
        petButton.layer.borderWidth = 1
        petButton.layer.borderColor = UIColor.white.cgColor
        
        roadButton.layer.cornerRadius = 15
        roadButton.layer.borderWidth = 1
        roadButton.layer.borderColor = UIColor.white.cgColor
        
        treeButton.layer.cornerRadius = 15
        treeButton.layer.borderWidth = 1
        treeButton.layer.borderColor = UIColor.white.cgColor
        
        vandalButton.layer.cornerRadius = 15
        vandalButton.layer.borderWidth = 1
        vandalButton.layer.borderColor = UIColor.white.cgColor
        
    }
    
    @IBAction func touch1(_ sender: Any) {
        authalertfield.textColor = UIColor.black
    }
    @IBAction func touch2(_ sender: Any) {
        authalertfield.textColor = UIColor.black
    }
    @IBAction func touch3(_ sender: Any) {
        authalertfield.textColor = UIColor.black
    }
    @IBAction func touch4(_ sender: Any) {
        authalertfield.textColor = UIColor.black
    }
    @IBAction func touch5(_ sender: Any) {
        authalertfield.textColor = UIColor.black
    }
    @IBAction func touch6(_ sender: Any) {
        authalertfield.textColor = UIColor.black
    }
    
    func setUpViews() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: AddEventView.frame.width, height: AddEventView.frame.height/5))
        let gradient = CAGradientLayer()
        let top = UIColor(red:0.76, green:0.08, blue:0.20, alpha:1.0)
        let bottom = UIColor(red:0.14, green:0.04, blue:0.21, alpha:1.0)
        
        gradient.frame = view.bounds
        gradient.colors = [top.cgColor, bottom.cgColor]
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        alertField.textColor = UIColor.white
        //user.textColor = UIColor.white
        //pass.textColor = UIColor.white
        //email.textColor = UIColor.white
        //signUpButton.setTitleColor(UIColor.white, for: UIControlState.normal)
    }

}
