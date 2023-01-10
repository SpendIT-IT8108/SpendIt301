//
//  LoginViewController.swift
//  SpendIt301
//
//  Created by Nawra Alhaji on 09/01/2023.
//

import UIKit
import Firebase
import FirebaseAuth
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //declare user defaults
    let defaults = UserDefaults.standard
    
    //create outlets for the fields
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    func validateFields(){
        //validations for fields
        if email.text?.isEmpty==true{
            //prompt an alert to the user
            let alert = UIAlertController(title: "Empty Field", message: "Please Enter Your Email", preferredStyle: .alert)
            
            //show a dismiss button + presnt the alert
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            present(alert, animated: true)
            
            return
        }
        
        
        
        
        if password.text?.isEmpty == true{
            
            //prompt an alert to the user
            let alert = UIAlertController(title: "Empty Field", message: "Please Enter Your Password", preferredStyle: .alert)
            
            //show a dismiss button + presnt the alert
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            present(alert, animated: true)
            
            return
        }
        
        //start login process after validation
        login()
    }
    

    func login(){
        
        //force unwrap tp avoid the crash
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] authResult, errorMessgae in
            
            
            guard let strongSelf = self else {return}
            
            if let errorMessgae = errorMessgae{
                print(errorMessgae.localizedDescription)
                
               
            }
            
            
            
     
            
            
            //double check the information
            self!.checkUserInfo()
        }
        
    }
        
        //double check that the user logged in and have information
        func checkUserInfo(){
            if Auth.auth().currentUser != nil {
                //print the id to ensure
                print(Auth.auth().currentUser?.uid)
                //print(Auth.auth().currentUser?.displayName)
                
                //set the value inside the user defaults
                self.defaults.set(true, forKey: "Logged In")
                
                //pass the user the overview
                let mainSB = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainSB.instantiateViewController(withIdentifier: "tabBar")
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
                let userID: String = Auth.auth().currentUser!.uid
                
                
            }else{
                //set the user as false inside user defaults
                self.defaults.set(false, forKey: "Logged In")
                
                //pass the user to the login form directly
                let loginForm = UIStoryboard(name: "loginAndSignUp", bundle: nil)
                let loginVc = loginForm.instantiateViewController(withIdentifier: "loginForm")
                loginVc.modalPresentationStyle = .overFullScreen
                self.present(loginVc, animated: true)
               

            }
            
            
            
        }
        
    
       @IBAction func LoginTapped(_ sender: Any) {
       //start from validating
           validateFields()
       }
        
    
    override func viewDidAppear(_ animated: Bool) {
        //checkUserInfo()
    }
    }
    

    
    
 



