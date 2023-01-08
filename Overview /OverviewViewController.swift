//
//  OverviewViewController.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 08/01/2023.
//

import UIKit

class OverviewViewController: UINavigationController {
//this controller is added because localizable file for overview in not added by system!

    @IBOutlet weak var overviewTabbarItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //change tab bar item-localize text to arabic 
        overviewTabbarItem.title = NSLocalizedString("Overview", comment: "")
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
