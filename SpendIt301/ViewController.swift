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
        view.addSubview(floatingButton)
        // Do any additional setup after loading the view.


    }
    private let floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x:0, y:0, width:60, height:60))
       
        button.backgroundColor = UIColor(red: 224.0/255, green: 223.0/255, blue: 119.0/255, alpha: 1.0)
        
        let image = UIImage(systemName: "plus",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        
        //shadow options
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        
        
        //corner radius
        
        //uncomment this to remove the shadow
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        
        return button
        
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x:view.frame.size.width/2 - 30,
                                      y:view.frame.size.height - 115,
                                      width:60, height:60)
    }

}

