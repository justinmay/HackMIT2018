//
//  ControlCenterViewController.swift
//  HackMit2018iOS
//
//  Created by Justin May on 9/15/18.
//  Copyright © 2018 Justin May. All rights reserved.
//

import UIKit

class ControlCenterViewController: UIViewController {

    @IBOutlet var controlCenterView: UIView!
    @IBOutlet weak var resQbutton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var waterButton: UIButton!
    @IBOutlet weak var hosptitalButton: UIButton!
    @IBOutlet weak var shelterButton: UIButton!
    @IBOutlet weak var gasButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
        setUpViews()

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
        resQbutton.setTitleColor(UIColor.white, for: .normal)
        foodButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        waterButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        hosptitalButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        shelterButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        gasButton.setTitleColor(UIColor.white, for: UIControlState.normal)
    }

}
