//
//  ARViewController.swift
//  PennAppsFall2018iOS
//
//  Created by Justin May on 9/7/18.
//  Copyright © 2018 Justin May. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import CoreLocation
import Firebase
import FirebaseDatabase

class ARViewController: UIViewController, ARSCNViewDelegate, CLLocationManagerDelegate  {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var imageViewLeft: UIImageView!
    @IBOutlet weak var imageViewRight: UIImageView!
    @IBOutlet weak var sceneViewLeft: ARSCNView!
    @IBOutlet weak var sceneViewRight: ARSCNView!
    
    //type passed from Control Center
    var typePassed:String!
    
    var timer = Timer()
    
    private var planeNode: SCNNode?
    private var imageNode: SCNNode?
    
    let pointOfView : SCNNode = SCNNode()
    let eyeCamera : SCNCamera = SCNCamera()
    var targetLocation = CGPoint(x: 0, y: 0)
    
    let locationManager = CLLocationManager()
    
    //LAT LANG
    var lat = 0.0
    var lang = 0.0
    
    //label CGPOINT
    var resourceLocation = CGPoint(x: 0, y: 0)
    
    // Parametres
    let interpupilaryDistance = 0.066 // This is the value for the distance between two pupils (in metres). The Interpupilary Distance (IPD).
    let viewBackgroundColor : UIColor = UIColor.black // UIColor.white
    
    /*
     SET eyeFOV and cameraImageScale. UNCOMMENT any of the below lines to change FOV:
     */
    //    let eyeFOV = 38.5; var cameraImageScale = 1.739; // (FOV: 38.5 ± 2.0) Brute-force estimate based on iPhone7+
    let eyeFOV = 60; var cameraImageScale = 3.478; // Calculation based on iPhone7+ // <- Works ok for cheap mobile headsets. Rough guestimate.
    //    let eyeFOV = 90; var cameraImageScale = 6; // (Scale: 6 ± 1.0) Very Rough Guestimate.
    //    let eyeFOV = 120; var cameraImageScale = 8.756; // Rough Guestimate.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Up
        print(typePassed)
        setUpARNode(whichNode: typePassed)
        
        //Firebase setup
        let userID = Auth.auth().currentUser?.uid
        var ref: DatabaseReference! = Database.database().reference()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        // Set the view's delegate
        sceneView.delegate = self
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        ////////////////////////////////////////////////////////////////
        // App Setup
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Scene setup
        sceneView.isHidden = true
        self.view.backgroundColor = viewBackgroundColor
        
        ////////////////////////////////////////////////////////////////
        // Set up Left-Eye SceneView
        sceneViewLeft.scene = scene
        sceneViewLeft.showsStatistics = sceneView.showsStatistics
        sceneViewLeft.isPlaying = true
        
        // Set up Right-Eye SceneView
        sceneViewRight.scene = scene
        sceneViewRight.showsStatistics = sceneView.showsStatistics
        sceneViewRight.isPlaying = true
        
        ////////////////////////////////////////////////////////////////
        // Update Camera Image Scale - according to iOS 11.3 (ARKit 1.5)
        if #available(iOS 11.3, *) {
            print("iOS 11.3 or later")
            cameraImageScale = cameraImageScale * 1080.0 / 720.0
        } else {
            print("earlier than iOS 11.3")
        }
        
        ////////////////////////////////////////////////////////////////
        // Create CAMERA
        eyeCamera.zNear = 0.001
        eyeCamera.fieldOfView = CGFloat(eyeFOV)
        
        ////////////////////////////////////////////////////////////////
        // Setup ImageViews - for rendering Camera Image
        self.imageViewLeft.clipsToBounds = true
        self.imageViewLeft.contentMode = UIViewContentMode.center
        self.imageViewLeft.transform = self.imageViewLeft.transform.rotated(by: CGFloat(Double.pi/2))
        
        self.imageViewRight.clipsToBounds = true
        self.imageViewRight.contentMode = UIViewContentMode.center
        self.imageViewRight.transform = self.imageViewRight.transform.rotated(by: CGFloat(Double.pi/2))
        print("///")
        print(targetLocation)
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(almostSetUp), userInfo: nil, repeats: false)
    }
    
    @objc func almostSetUp() {
        self.targetLocation = targetPosition(userLocation:CGPoint(x: lat, y: lang),resourceCenter: resourceLocation, scaleFactor: 1)
        let skScene = SKScene(size: CGSize(width: 200, height: 200))
        skScene.backgroundColor = UIColor.clear
        
        let rectangle = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 200, height: 200), cornerRadius: 10)
        rectangle.fillColor = #colorLiteral(red: 0.807843148708344, green: 0.0274509806185961, blue: 0.333333343267441, alpha: 1.0)
        rectangle.strokeColor = #colorLiteral(red: 0.439215689897537, green: 0.0117647061124444, blue: 0.192156866192818, alpha: 1.0)
        rectangle.lineWidth = 5
        rectangle.alpha = 0.4
        let labelNode = SKLabelNode(text: "Hello World")
        labelNode.fontSize = 20
        labelNode.position = CGPoint(x:100,y:100)
        skScene.addChild(rectangle)
        skScene.addChild(labelNode)
        let plane = SCNPlane(width: 20, height: 20)
        let material = SCNMaterial()
        material.isDoubleSided = true
        material.diffuse.contents = skScene
        plane.materials = [material]
        let node = SCNNode(geometry: plane)
        node.position = SCNVector3(targetLocation.x,1.5,targetLocation.y)
        print(node.position)
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }
    
    func targetPosition(userLocation: CGPoint, resourceCenter: CGPoint, scaleFactor: Int) -> CGPoint{
        let xDist = resourceCenter.x - userLocation.x
        let yDist = resourceCenter.y - userLocation.y
        let dist = sqrt(xDist * xDist + yDist * yDist)
        let unitVector: [Double] = [Double(xDist / dist), Double(yDist / dist)]
        return CGPoint(x: 5 * unitVector[0], y: unitVector[1])
    }
    
    func setUpARNode(whichNode: String) {
        switch whichNode{
        case "food":
            let foodRef = Database.database().reference().child("Locations").child("Food")
            print("printing foods")
            
            foodRef.observeSingleEvent(of: .value) { snapshot in
                print(snapshot.childrenCount) // I got the expected number of items
                for case let rest as DataSnapshot in snapshot.children {
                    print(rest.value!)
                    self.resourceLocation = CGPointFromString(rest.value! as! String)
                }
            }
        case "water":
            let foodRef = Database.database().reference().child("Locations").child("Water")
            print("printing waters")
            
            foodRef.observeSingleEvent(of: .value) { snapshot in
                print(snapshot.childrenCount) // I got the expected number of items
                for case let rest as DataSnapshot in snapshot.children {
                    print(rest.value)
                }
            }
        case "hospital":
            let foodRef = Database.database().reference().child("Locations").child("Hospital")
            print("printing hospitals")
        
            foodRef.observeSingleEvent(of: .value) { snapshot in
                print(snapshot.childrenCount) // I got the expected number of items
                for case let rest as DataSnapshot in snapshot.children {
                    print(rest.value)
                }
            }
        case "gas":
            let foodRef = Database.database().reference().child("Locations").child("Gas")
            print("printing hospitals")
            
            foodRef.observeSingleEvent(of: .value) { snapshot in
                print(snapshot.childrenCount) // I got the expected number of items
                for case let rest as DataSnapshot in snapshot.children {
                    print(rest.value)
                }
            }
        case "shelter":
            let foodRef = Database.database().reference().child("Locations").child("Shelter")
            print("printing hospitals")
            
            foodRef.observeSingleEvent(of: .value) { snapshot in
                print(snapshot.childrenCount) // I got the expected number of items
                for case let rest as DataSnapshot in snapshot.children {
                    print(rest.value)
                }
            }
        default:
            print("u done screwed")
        }
    }
    
    //finding location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = locValue.latitude
        lang = locValue.longitude
    }
    
    //returns a SCNMatrix4 of the position
    func sceneSpacePosition(inFrontOf node: SCNNode, atDistance distance: Float) -> SCNVector3 {
        let localPosition = SCNVector3(x: 0, y: 0, z: -distance)
        let scenePosition = node.convertPosition(localPosition, to: nil)
        // to: nil is automatically scene space
        return scenePosition
    }
    
   
    func getUserDirection() -> (SCNVector3) { // (direction, position)
        if let frame = self.sceneView.session.currentFrame {
            let mat = SCNMatrix4(frame.camera.transform) // 4x4 transform matrix describing camera in world space
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33) // orientation of camera in world space
            
            return (dir)
        }
        return (SCNVector3(0, 0, -1))
    }
    
    func getUserPosition() -> (SCNVector3) { // (direction, position)
        if let frame = self.sceneView.session.currentFrame {
            let mat = SCNMatrix4(frame.camera.transform) // 4x4 transform matrix describing camera in world space
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43) // location of camera in world space
            
            return (pos)
        }
        return (SCNVector3(0, 0, -1))
    }
    
    func updateFrame() {
        /////////////////////////////////////////////
        // CREATE POINT OF VIEWS
        
        pointOfView.transform = (sceneView.pointOfView?.transform)!
        pointOfView.scale = (sceneView.pointOfView?.scale)!
        // Create POV from Camera
        pointOfView.camera = eyeCamera
        
        // Set PointOfView for SceneView-LeftEye
        sceneViewLeft.pointOfView = pointOfView
        
        // Clone pointOfView for Right-Eye SceneView
        let pointOfView2 : SCNNode = (sceneViewLeft.pointOfView?.clone())!
        // Determine Adjusted Position for Right Eye
        let orientation : SCNQuaternion = pointOfView.orientation
        let orientationQuaternion : GLKQuaternion = GLKQuaternionMake(orientation.x, orientation.y, orientation.z, orientation.w)
        let eyePos : GLKVector3 = GLKVector3Make(1.0, 0.0, 0.0)
        let rotatedEyePos : GLKVector3 = GLKQuaternionRotateVector3(orientationQuaternion, eyePos)
        let rotatedEyePosSCNV : SCNVector3 = SCNVector3Make(rotatedEyePos.x, rotatedEyePos.y, rotatedEyePos.z)
        let mag : Float = Float(interpupilaryDistance)
        pointOfView2.position.x += rotatedEyePosSCNV.x * mag
        pointOfView2.position.y += rotatedEyePosSCNV.y * mag
        pointOfView2.position.z += rotatedEyePosSCNV.z * mag
        
        // Set PointOfView for SceneView-RightEye
        sceneViewRight.pointOfView = pointOfView2
        
        ////////////////////////////////////////////
        // RENDER CAMERA IMAGE
        /*
         Note:
         - as camera.contentsTransform doesn't appear to affect the camera-image at the current time, we are re-rendering the image.
         - for performance, this should ideally be ported to metal
         */
        // Clear Original Camera-Image
        sceneViewLeft.scene.background.contents = UIColor.clear // This sets a transparent scene bg for all sceneViews - as they're all rendering the same scene.
        
        // Read Camera-Image
        let pixelBuffer : CVPixelBuffer? = sceneView.session.currentFrame?.capturedImage
        if pixelBuffer == nil { return }
        let ciimage = CIImage(cvPixelBuffer: pixelBuffer!)
        // Convert ciimage to cgimage, so uiimage can affect its orientation
        let context = CIContext(options: nil)
        let cgimage = context.createCGImage(ciimage, from: ciimage.extent)
        
        // Determine Camera-Image Scale
        var scale_custom : CGFloat = 1.0
        // let cameraImageSize : CGSize = CGSize(width: ciimage.extent.width, height: ciimage.extent.height) // 1280 x 720 on iPhone 7+
        // let eyeViewSize : CGSize = CGSize(width: self.view.bounds.width / 2, height: self.view.bounds.height) // (736/2) x 414 on iPhone 7+
        // let scale_aspectFill : CGFloat = cameraImageSize.height / eyeViewSize.height // 1.739 // fov = ~38.5 (guestimate on iPhone7+)
        // let scale_aspectFit : CGFloat = cameraImageSize.width / eyeViewSize.width // 3.478 // fov = ~60
        // scale_custom = 8.756 // (8.756) ~ appears close to 120° FOV - (guestimate on iPhone7+)
        // scale_custom = 6 // (6±1) ~ appears close-ish to 90° FOV - (guestimate on iPhone7+)
        scale_custom = CGFloat(cameraImageScale)
        
        // Determine Camera-Image Orientation
        let imageOrientation : UIImageOrientation = (UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeLeft) ? UIImageOrientation.down : UIImageOrientation.up
        
        // Display Camera-Image
        let uiimage = UIImage(cgImage: cgimage!, scale: scale_custom, orientation: imageOrientation)
        self.imageViewLeft.image = uiimage
        self.imageViewRight.image = uiimage
    }
    
    open func screenshot() -> UIImage? {
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
}

