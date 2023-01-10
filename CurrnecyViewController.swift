//
//  CurrnecyViewController.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 09/01/2023.
//

import UIKit

class CurrnecyViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var usdRadioBtn: UIButton!
    @IBOutlet weak var euroRadioBtn: UIButton!
    
    @IBOutlet weak var amountTxtBx: UITextField!
    
    @IBOutlet weak var convertedamountLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func rbtnAction(_ sender: UIButton) {
        let itemCost = Float(amountTxtBx.text!)
        var bhd : Float = 0
        if amountTxtBx.text != "" {
        if sender.tag == 1 {
            usdRadioBtn.isSelected = true
            euroRadioBtn.isSelected = false
            
            let usRate = 0.38
            bhd = (itemCost!*Float(usRate))
            
            convertedamountLbl.text = String("\(bhd) BHD")
            }
        else if sender.tag == 2 {
            usdRadioBtn.isSelected = false
            euroRadioBtn.isSelected = true
          
            let euroRate = 0.40
            bhd = (itemCost!*Float(euroRate))
            convertedamountLbl.text = String("\(bhd) BHD")
        }
    }else {
        print("No data entered")
    }
        }
        
        
    }



