//
//  SortTableViewCell.swift
//  Pods
//
//  Created by Zainab Muneer on 01/01/2023.
//

import UIKit

class SortTableViewCell: UITableViewCell {

    @IBOutlet weak var LtHSwitchOutlet: UISwitch!
    @IBOutlet weak var HtLSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func HtLPressed(_ sender: UISwitch) {

        if sender.isOn{
        
            LtHSwitchOutlet.setOn(false, animated: true)
           
       }
        
    }
    
    
    @IBAction func LtHSwitch(_ sender: UISwitch) {
        
        if sender.isOn{
           print(LtHSwitchOutlet)
            print(HtLSwitch)
        
        }

    }
    
}

