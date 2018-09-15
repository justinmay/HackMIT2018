//
//  ViewController.swift
//  HackMit2018iOS
//
//  Created by Justin May on 9/15/18.
//  Copyright © 2018 Justin May. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var titleScreenView: UIView!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var pass: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpViews() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: titleScreenView.frame.width, height: titleScreenView.frame.height))
        let gradient = CAGradientLayer()
        let top = UIColor(red:0.76, green:0.08, blue:0.20, alpha:1.0)
        let bottom = UIColor(red:0.14, green:0.04, blue:0.21, alpha:1.0)
        
        gradient.frame = view.bounds
        gradient.colors = [top.cgColor, bottom.cgColor]
        
        self.view.layer.insertSublayer(gradient, at: 0)
        print("hi")
        
        user.textColor = UIColor.white
        pass.textColor = UIColor.white
        titleLabel.textColor = UIColor.white
    }
}

