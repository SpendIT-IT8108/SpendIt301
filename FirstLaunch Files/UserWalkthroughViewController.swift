//
//  SBViewController.swift
//  SpendIt301
//
//  Created by Nawra Alhaji on 08/01/2023.
//

import UIKit

class SBViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //instantaite the walkthrough storyboard for first launch
        let storyB = UIStoryboard(name: "UserWalkthrough", bundle: nil)
        let vc = storyB.instantiateViewController(withIdentifier: "WalkthroughStartPoint")
        self.present(vc, animated: true)
    

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
