//
//  SceneDelegate.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 15/12/2022.
//

import UIKit
import LocalAuthentication
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let defaults = UserDefaults.standard


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
       
        
        
               
               //1. store the scene
               guard let windowScene = (scene as? UIWindowScene) else {return}
               
               
               //2. create new UI window, for both screens that must be displayed in different conditions
               let walkthroughWindow = UIWindow(windowScene: windowScene)
               let overviewWindow = UIWindow(windowScene: windowScene
               )
              
               
               //create the view controller programatically for first launch
               let walkthroughVC = WalkthroughViewController()
               let navigation = UINavigationController(rootViewController: walkthroughVC)
               
               //create the view controller programatically for other launches
               let overviewVC = ViewController()
               let navigation2 = UINavigationController(rootViewController: overviewVC)
               
               //set the root view controller of the window
               walkthroughWindow.rootViewController = navigation
               overviewWindow.rootViewController = navigation2
               
               
               
               
               //check if the user opened the app before, by getting the Logged in key value from the user defaults
               if defaults.bool(forKey: "First Launch") == true {
                   print("The second +")
                   
                  
                   //as a confirmation, put the key = true again
                   defaults.set(true, forKey: "First Launch")
                   
                   
                   //run code after other lanches, depnding on if user logged in or not, display the view
                   if defaults.bool(forKey: "Logged In") == false{
                       
                       
                       //display walkthrough again if user did not log in
                       self.window = walkthroughWindow
                      walkthroughWindow.makeKeyAndVisible()
                       
                       
                   }else{
                       
                       //check if user enabled face id
                       if defaults.bool(forKey: "FaceID enabled") == true {
                           //prompt face id to the user
                           let context = LAContext()
                           var error: NSError? = nil
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
                                       //self?.present(alert, animated: true)
                   
                                       return
                                   }
                                   //success >> show next screen
                                   self?.window = overviewWindow
                                   overviewWindow.makeKeyAndVisible()
                                   
                                   //set the value of face Id == enabled in userdefaults for confirmation only
                                   self?.defaults.set(true, forKey: "FaceID enabled")
                                   
                                   
                               }
                               
                           }
                           
                       }else{
                        
                           
                           //display overview if the user logged in
                           self.window = overviewWindow
                           overviewWindow.makeKeyAndVisible()
                       }
                       
                       
                       
                       
                       
                       
                       
                   }

               
               }else{
                   
                   print("First time!")
                   
                   //change the state from false to true because user opened the app
                   defaults.set(true, forKey: "First Launch")
                   
                   
                   //run code after first launch, display the walkthrough
                   if defaults.bool(forKey: "Logged In") == false{
                       
                       
                       //display walkthrough again if user did not log in
                    self.window = walkthroughWindow
                    walkthroughWindow.makeKeyAndVisible()
                       
                       
                   }else{
                       
                       //display overview if the user logged in
                       self.window = overviewWindow
                       overviewWindow.makeKeyAndVisible()
                   }
                   
                    
               }
        
       
               
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        Transaction.updateRepeated()
        if defaults.string(forKey: "App Mode") == "Dark"{
            window?.overrideUserInterfaceStyle =
                .dark
        }
        else {
            window?.overrideUserInterfaceStyle =
                .light
        }
    
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


    //handling quick actions
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
    
    switch shortcutItem.type {
    case "add":
    // perform the plus button clicked from the tab bar
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "tabBar")
        self.window?.rootViewController = initialViewController
        if let VC = initialViewController as? TabBarViewController {
            VC.addButtonClicked()
        }
    default:
        break
    }
     
    }
    
}

