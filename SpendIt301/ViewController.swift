//
//  ViewController.swift
//  SpendIt301
//
//  Created by Maryam Taraif on 15/12/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        //instantiate the main story board from here to call it in other launches
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainSB.instantiateViewController(withIdentifier: "tabBar")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)

    }
   
    

}

