//
//  TransactionTableViewCell.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 22/12/2022.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var transactionNameLable: UILabel!
    @IBOutlet weak var transactionAmountLable: UILabel!
    @IBOutlet weak var categorySymbolLable: UIImageView!
    
    func update(with transaction: Transaction){
            //transactionSymbolLable.
        if transaction.category.type=="Expense"{
            transactionAmountLable.textColor=UIColor.red
            transactionAmountLable.text=("- \(String(transaction.amount))")
        }
        else if transaction.category.type=="Income"{
            transactionAmountLable.textColor=UIColor.systemGreen
            transactionAmountLable.text=("+ \(String(transaction.amount))")
        }
        categorySymbolLable.image=transaction.category.icon?.image
            transactionNameLable.text=transaction.name   }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
