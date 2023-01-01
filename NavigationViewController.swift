//
//  NavigationViewController.swift
//  
//
//  Created by A'laa Alekri on 01/01/2023.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBSegueAction func showForm(_ coder: NSCoder, sender: Any?) -> AddTransactionTVC? {
        if let controller = sender as? TabBarViewController {
            return AddTransactionTVC(coder: coder, transaction: nil)
        }
        else if let ViewController = sender as? TransactionDetailsTVC {
            return AddTransactionTVC(coder: coder, transaction: ViewController.transaction )
        }
        else {
            return AddTransactionTVC(coder: coder, transaction: nil)
        }
       
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
