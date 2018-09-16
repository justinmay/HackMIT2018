//
//  AROneViewController.swift
//  HackMit2018iOS
//
//  Created by Justin May on 9/16/18.
//  Copyright © 2018 Justin May. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class AROneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        //sceneView.session.run(configuration)
    }
    
    func addText() -> SCNNode{
        let text = SCNText(string: "bob", extrusionDepth: 0.1)
        text.font = UIFont.systemFont(ofSize: 1.0)
        text.flatness = 0.01
        text.firstMaterial?.diffuse.contents = UIColor.white
        
        let textNode = SCNNode(geometry: text)
        
        let fontSize = Float(0.04)
        textNode.scale = SCNVector3(fontSize, fontSize, fontSize)
        
        return textNode
    }
}
