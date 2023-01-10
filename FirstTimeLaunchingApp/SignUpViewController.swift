//
//  SignUpViewController.swift
//  SpendIt301
//
//  Created by Nawra Alhaji on 09/01/2023.
//

import UIKit
import Firebase
import FirebaseAuth


class SignUpViewController: UIViewController {

    //declare user defaults
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
        //outlets for all fields
    @IBOutlet weak var name: UITextField!
    
   
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    
    
    
    //if sign up is pressed, start validation process
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        //validation for empty field
        if name.text?.isEmpty==true{
            //prompt an alert to the user
            let alert = UIAlertController(title: "Empty Field", message: "Please Enter Your Name", preferredStyle: .alert)
            
            //show a dismiss button + presnt the alert
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            present(alert, animated: true)
            
            return
            
        }
        
        
        
        //validation for email field
        if email.text?.isEmpty==true{
            
            //prompt an alert to the user
            let alert = UIAlertController(title: "Empty Field", message: "Please Enter Your Email", preferredStyle: .alert)
            
            //show a dismiss button + presnt the alert
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            present(alert, animated: true)
            
            
            return
        }
        
        
        
        
        //validation for password field
        if password.text?.isEmpty == true{
            
            //prompt an alert to the user
            let alert = UIAlertController(title: "Empty Field", message: "Please Enter Your Password", preferredStyle: .alert)
            
            //show a dismiss button + presnt the alert
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            present(alert, animated: true)
            
            return
        }
        
        
        
        //call the sign up function if the fields are validated
        SignUp()
     
    }
    
    
    
    
    
    //send user information + password to firebase
    func SignUp(){
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
            
            //check the auth result to make sure that the user is created
            guard let user = authResult?.user, error == nil else{
                
                
                
                //if user is not created, display the error.
                print("Error \(error?.localizedDescription)")
                
               
                
                return

            }
            
            //set the value inside the user defaults
            self.defaults.set(true, forKey: "Logged In")
            
            //redirect to overview page
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainSB.instantiateViewController(withIdentifier: "tabBar")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        
        }
        
        //save the info in the user defaults too
        defaults.set(name.text, forKey: "User Name")
        defaults.set(email.text, forKey: "User Email")
        defaults.set(password.text, forKey: "User Password")
        
    }
    
}
