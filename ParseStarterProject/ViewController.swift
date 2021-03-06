/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signupMode = true
    
    var activityIndicator = UIActivityIndicatorView()

    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func signupOrLogin(_ sender: Any) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
        
            createAlert(title: "Error In Form", message: "Please Enter in an email and password")
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                
            activityIndicator.center = self.view.center
            
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            
            activityIndicator.startAnimating()
            
            view.addSubview(activityIndicator)
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if signupMode {
                //sign up mode
                
                let user = PFUser()
                
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackground(block: { (success, error) in
                    
                    self.activityIndicator.stopAnimating()
                    
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Something wen't wrong, please try again later."
                        
                        if let errorMessage = (error! as NSError).userInfo["error"] as? String {
                            
                            displayErrorMessage = errorMessage
                            
                        }
                        
                        self.createAlert(title: "Signup error", message: displayErrorMessage)
                        
                    } else {
                        
                        print("User signed up")
                        
                    
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                        
                        
                    }
                    
                })
                
            } else {
                
                //login mode
                
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    self.activityIndicator.stopAnimating()
                    
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Something wen't wrong, please try again later."
                        
                        if let errorMessage = (error! as NSError).userInfo["error"] as? String {
                            
                            displayErrorMessage = errorMessage
                        }
                        
                        self.createAlert(title: "Login form", message: displayErrorMessage)
                        
                    } else {
                        
                        print("Logged in")
                        
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                    
                })
                
            }
            
        }
        
    }
   
    @IBOutlet var signupOrLoginButton: UIButton!
    @IBAction func changeSignupMode(_ sender: Any) {
        
        if signupMode {
            //change to log in mode
            
            signupOrLoginButton.setTitle("Log In", for: [])

            changeSignupModeButton.setTitle("Sign Up", for: [])
            
            messageLabel.text = "Don't have an account?"
            
            signupMode = false
            
        } else {
            //change to sign up mode
            
            signupOrLoginButton.setTitle("Sign Up", for: [])
            
            changeSignupModeButton.setTitle("Log In", for: [])
            
            messageLabel.text = "Already have an account?"
            
            signupMode = true
            
        }
        
    }
    @IBOutlet var changeSignupModeButton: UIButton!
    
    @IBOutlet var messageLabel: UILabel!
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            
            performSegue(withIdentifier: "showUserTable", sender: self)
            
        }
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
