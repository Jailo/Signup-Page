//
//  PostViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Jaiela London on 8/26/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet var imageToPost: UIImageView!
    
    @IBAction func chooseAnImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageToPost.image = image
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet var messageTextField: UITextField!
    
    @IBAction func postImage(_ sender: Any) {
        
        //check to see if user uploaded a picture
        
        //check to see if user typed in a message
        
        if messageTextField.text == "" {
            
            createAlert(title: "Did you forget to caption your photo?", message: "Please type in a caption for your photo and try again")
            
        } else {
        
            //spinner
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            
            activityIndicator.center = self.view.center
            
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            
            activityIndicator.startAnimating()
            
            view.addSubview(activityIndicator)
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            
        var post = PFObject(className: "Posts")
        
        post["message"] = messageTextField.text
        
        post["userid"] = PFUser.current()?.objectId!
        
        let imageData = UIImageJPEGRepresentation(imageToPost.image!, 0.1)
        
        let imageFile = PFFile(name: "image.png", data: imageData!)
        
        post["imageFile"] = imageFile
        
        post.saveInBackground { (success, error) in
            
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            
            if error != nil {
                
                self.createAlert(title: "Could not post image", message: "Try again later")
                
            } else {
                
                self.createAlert(title: "Image Posted!", message: "Your image has been posted")
                
                self.messageTextField.text = ""
                
                self.imageToPost.image = UIImage(named: "person-icon.png")
                
            }
            
        }
        
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
