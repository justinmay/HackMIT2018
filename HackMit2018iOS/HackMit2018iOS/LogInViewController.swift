//
//  LogInViewController.swift
//  HackMit2018iOS
//
//  Created by Justin May on 9/15/18.
//  Copyright © 2018 Justin May. All rights reserved.
//

import UIKit
import FacebookLogin
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LogInViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passworldField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var pass: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet var logInView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        setUpViews()
        view.addSubview(loginButton)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpTouch(_ sender: Any) {
        print("sign up button touched")
        Auth.auth().createUser(withEmail: emailField.text!, password: passworldField.text!) { (authResult, error) in
            // ...
            print(error)
            self.performSegue(withIdentifier: "signUpSuccess", sender: nil)
            guard let user = authResult?.user else { return }
            let ref = Database.database().reference(withPath: "users")
            ref.child(user.uid).setValue(["username": self.usernameField.text!])
            
        }
    }
    func setUpViews() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: logInView.frame.width, height: logInView.frame.height))
        let gradient = CAGradientLayer()
        let top = UIColor(red:0.76, green:0.08, blue:0.20, alpha:1.0)
        let bottom = UIColor(red:0.14, green:0.04, blue:0.21, alpha:1.0)
        
        gradient.frame = view.bounds
        gradient.colors = [top.cgColor, bottom.cgColor]
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        user.textColor = UIColor.white
        pass.textColor = UIColor.white
        email.textColor = UIColor.white
        signUpButton.setTitleColor(UIColor.white, for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
