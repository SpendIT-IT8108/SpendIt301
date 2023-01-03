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
        categorySymbolLable.image=transaction.category.icon
            transactionNameLable.text=transaction.name
            transactionAmountLable.text=String(transaction.amount)
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
