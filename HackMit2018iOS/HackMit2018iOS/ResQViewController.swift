//
//  ResQViewController.swift
//  HackMit2018iOS
//
//  Created by Justin May on 9/15/18.
//  Copyright © 2018 Justin May. All rights reserved.
//

import UIKit

class ResQViewController: UIViewController {

    @IBOutlet var resQView: UIView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        // Do any additional setup after loading the view.
    }

    func setUpViews() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: resQView.frame.width, height: resQView.frame.height / 5 ))
        
        let gradient = CAGradientLayer()
        let top = UIColor(red:0.76, green:0.08, blue:0.20, alpha:1.0)
        let bottom = UIColor(red:0.14, green:0.04, blue:0.21, alpha:1.0)
        
        gradient.frame = view.bounds
        gradient.colors = [top.cgColor, bottom.cgColor]
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        titleLable.textColor = UIColor.white
        
    }

}
