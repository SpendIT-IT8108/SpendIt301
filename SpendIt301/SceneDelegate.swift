//
//  SceneDelegate.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 15/12/2022.
//

import UIKit

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
               
               
               
               
               //check if this is the first launch
               if defaults.bool(forKey: "first launch") == true {
                   print("The second +")
                   
                  
                   //confirmation (but not necssary)
                   defaults.set(true, forKey: "first launch")
                   
                   //run code after other lanches, display overview
                   self.window = overviewWindow
                   overviewWindow.makeKeyAndVisible()
               
               }else{
                   
                   print("First time!")
                   //change the state from false to true >> so important
                   defaults.set(true, forKey: "first launch")
                   
                   
                   //run code after first launch, display the walkthrough
                    self.window = walkthroughWindow
                   walkthroughWindow.makeKeyAndVisible()
                    
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

