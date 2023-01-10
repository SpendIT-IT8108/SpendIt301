//
//  UserProfileViewController.swift
//  SpendIt301
//
//  Created by Nawra Alhaji on 10/01/2023.
//

import UIKit
import LocalAuthentication

class UserProfileViewController: UIViewController {

    @IBOutlet weak var faceIdOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    //declare user defaults
    let defaults = UserDefaults.standard


    //create IB actions for all buttons in the Setup storyboard
    
    
    @IBOutlet weak var femaleBtnOutlet: UIButton!

    
    @IBAction func femaleBtn(_ sender: Any) {
        // if the button is pressed, make it highlighted
        femaleBtnOutlet.layer.borderWidth = 9
        femaleBtnOutlet.layer.borderColor = UIColor(red: 224.0/255, green: 223.0/255, blue: 119.0/255, alpha: 1.0).cgColor
        femaleBtnOutlet.layer.cornerRadius = 30
        
        //remove highlight from the male button
        maleBtnOutlet.layer.borderWidth = 0
        
        
        //set the value inside the user defaults
        defaults.set("Female", forKey: "Gender")
        
    }
    
    
    @IBOutlet weak var maleBtnOutlet: UIButton!
    
    @IBAction func maleBtn(_ sender: Any) {
        //remove highlight from the female button
        femaleBtnOutlet.layer.borderWidth = 0
        
        // if the button is pressed, make it highlighted
        maleBtnOutlet.layer.borderWidth = 9
        maleBtnOutlet.layer.borderColor = UIColor(red: 224.0/255, green: 223.0/255, blue: 119.0/255, alpha: 1.0).cgColor
        maleBtnOutlet.layer.cornerRadius = 30
        
        //set the value inside the user defaults
        defaults.set("Male", forKey: "Gender")
    }
    
    
    
    @IBOutlet weak var languageBtnOutlet: UIButton!
    
    
    @IBAction func languageBtn(_ sender: Any) {
        //remove highlight from the other button
        ArabicLanguageOutlet.layer.borderWidth = 0
        
        // if the button is pressed, make it highlighted
        languageBtnOutlet.layer.borderWidth = 9
        languageBtnOutlet.layer.borderColor = UIColor(red: 224.0/255, green: 223.0/255, blue: 119.0/255, alpha: 1.0).cgColor
        languageBtnOutlet.layer.cornerRadius = 30
        
        //set the value inside the user defaults
        defaults.set("English", forKey: "Language")
        
        
    }
    
    @IBOutlet weak var ArabicLanguageOutlet: UIButton!
    
    @IBAction func ArabicBtn(_ sender: Any) {
        //remove highlight from the other button
        languageBtnOutlet.layer.borderWidth = 0
        
        
        // if the button is pressed, make it highlighted
        ArabicLanguageOutlet.layer.borderWidth = 9
        ArabicLanguageOutlet.layer.borderColor = UIColor(red: 224.0/255, green: 223.0/255, blue: 119.0/255, alpha: 1.0).cgColor
        ArabicLanguageOutlet.layer.cornerRadius = 30
        
        //set the value inside the user defaults
        defaults.set("Arabic", forKey: "Language")
    }
    
    
    @IBOutlet weak var lightmodeOutlet: UIButton!
    
    @IBAction func lightmodeBtn(_ sender: Any) {
        //remove highlight from the other button
        darkmodeOutlet.layer.borderWidth = 0
        
        
        // if the button is pressed, make it highlighted
        lightmodeOutlet.layer.borderWidth = 9
        lightmodeOutlet.layer.borderColor = UIColor(red: 224.0/255, green: 223.0/255, blue: 119.0/255, alpha: 1.0).cgColor
        lightmodeOutlet.layer.cornerRadius = 30
        
        //override the ui based on user choice
        //UserProfileViewController().overrideUserInterfaceStyle = .light
        //set the value inside the user defaults
        defaults.set("Light", forKey: "App Mode")
    }
    
    
    
    @IBOutlet weak var darkmodeOutlet: UIButton!
    
    @IBAction func darkmodeBtn(_ sender: Any) {
        //remove highlight from the other button
        lightmodeOutlet.layer.borderWidth = 0
        
        
        // if the button is pressed, make it highlighted
        darkmodeOutlet.layer.borderWidth = 9
        darkmodeOutlet.layer.borderColor = UIColor(red: 224.0/255, green: 223.0/255, blue: 119.0/255, alpha: 1.0).cgColor
        darkmodeOutlet.layer.cornerRadius = 30
        
        //override the ui based on user choice
        
        
        //set the value inside the user defaults
        defaults.set("Dark", forKey: "App Mode")
    }
    
    
    
    @IBAction func faceItSetupBtn(_ sender: Any) {
        
        let context = LAContext()
        var error: NSError? = nil
        //check for older devices
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            
            let reason = "Please authorize with face ID"
            
            //if able to use, use the policy
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] sucess, error in
                
                DispatchQueue.main.async {
                    guard sucess, error == nil else{
                        
                        //failed
                        let alert = UIAlertController(title: "Failed to Authunticate", message: "Please try again", preferredStyle: .alert)
                        
                        //show a dismiss button + presnt the alert
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        
                        //because we're in weak self area
                        self?.present(alert, animated: true)
    
                        return
                    }
                    //success >> show next screen
                    let mainSB = UIStoryboard(name: "UserSetup", bundle: nil)
                    let vc = mainSB.instantiateViewController(withIdentifier: "page5")
                    vc.modalPresentationStyle = .overFullScreen
                    self?.present(vc, animated: true)
                    
                    //set the value of face Id == enabled in userdefaults
                    self?.defaults.set(true, forKey: "FaceID enabled")
                    
                    
                }
                
            }
        }else{
            //cannot use face id / touch id, alert user
            let alert = UIAlertController(title: "Unavialble", message: "You can't use this feature", preferredStyle: .alert)
            
            //show a dismiss button + presnt the alert
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            
        }
        
    }

    
   

}
