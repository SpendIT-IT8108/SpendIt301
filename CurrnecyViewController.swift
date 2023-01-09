//
//  CurrnecyViewController.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 09/01/2023.
//

import UIKit

class CurrnecyViewController: UIViewController {


    @IBOutlet weak var usdRadioBtn: UIButton!
    @IBOutlet weak var euroRadioBtn: UIButton!
    
    @IBOutlet weak var amountTxtBx: UITextField!
    
    @IBOutlet weak var convertedamountLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func rbtnAction(_ sender: UIButton) {
        let itemCost = Float(amountTxtBx.text!)
        var bhd : Float = 0
        if sender.tag == 1 {
            usdRadioBtn.isSelected = true
            euroRadioBtn.isSelected = false
            let usRate = 2.65
            bhd = (itemCost!*Float(usRate))
            
            convertedamountLbl.text = String("\(bhd) BHD")
        } else if sender.tag == 2 {
            usdRadioBtn.isSelected = false
            euroRadioBtn.isSelected = true
            let euroRate = 2.47
            bhd = (itemCost!*Float(euroRate))
            convertedamountLbl.text = String("\(bhd) BHD")
        }
        
    }

}