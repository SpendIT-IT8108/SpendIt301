//
//  FilterPriceTableViewCell.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 30/12/2022.
//

import UIKit

class FilterPriceTableViewCell: UITableViewCell {

//    @IBOutlet weak var LtHswitch: UISwitch!
//    @IBOutlet weak var HtLSwitch: UISwitch!
//    @IBOutlet weak var LtHLable: UILabel!
//    @IBOutlet weak var HtLLable: UILabel!
//
//    var transactions = [Transaction]()
//    var filteredTransactions: [Transaction] = []
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        if let saveTransaction=Transaction.loadTransaction(){
//            transactions=saveTransaction
//
//        }else{
//            transactions=Transaction.loadSampleTransacion()
//        }
//
//    }
    
//        @IBAction func switchPressedLtH(_ sender: UISwitch) {
//        }
    
//    @IBAction func HtLPressed(_ sender: UISwitch) {
//        if sender.isOn {
//
//                //low to high
//           // LtHswitch.setOn( false, animated: true)
//             filteredTransactions = transactions.sorted {
//                 $0.amount < $1.amount
//            }
//
//            }
//
//    }
//    @IBAction func LtHPressed(_ sender: UISwitch) {
//        if sender.isOn {
//                //low to high
//            HtLSwitch.setOn( false, animated: true)
//           filteredTransactions = transactions.sorted {
//                $0.amount < $1.amount
//            }
//
//            }
//    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
