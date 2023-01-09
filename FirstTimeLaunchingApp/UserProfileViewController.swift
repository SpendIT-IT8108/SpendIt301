//
//  UserProfileViewController.swift
//  SpendIt301
//
//  Created by Nawra Alhaji on 09/01/2023.
//

import UIKit

class UserProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        //set the value inside the user defaults
        defaults.set("Dark", forKey: "App Mode")
    }
    
   

}
