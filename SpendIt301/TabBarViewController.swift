//
//  TabBarViewController.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 27/12/2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(floatingButton)
        
        //assign the object function as an action to the programmatically created floating button
        floatingButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)

    }
    
    //floating button
    private let floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 150, y: 550, width: 75, height: 75))
       
        button.backgroundColor = UIColor(red: 224.0/255, green: 223.0/255, blue: 119.0/255, alpha: 1.0)
        
        let image = UIImage(systemName: "plus",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        
        //shadow options
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //corner radius
        
        //uncomment this to remove the shadow
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        
        button.translatesAutoresizingMaskIntoConstraints = false
   
        return button
        
    }()

   
    
    //subView for floating button
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x:view.frame.size.width/2 - 30,
                                    y:view.frame.size.height - 115,
                                    width:60, height:60)
        
    }
    
    // MARK: - Navigation
    @objc func addButtonClicked(){
            performSegue(withIdentifier: "showAddForm", sender: self)
        }
        
        @IBSegueAction func showAddForm(_ coder: NSCoder) -> UIViewController? {
            return AddTransactionTVC(coder: coder, transaction: nil)
        }
        
    }
    


