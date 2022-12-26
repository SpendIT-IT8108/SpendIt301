//
//  TrasactionFilterTableViewController.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 23/12/2022.
//

import UIKit

class TrasactionFilterTableViewController: UITableViewController {
    var transactions = TransactionTableViewController().searchedItem
    var filteredTransactions: [Transaction] = []
    @IBOutlet weak var LtHLable: UILabel!
    @IBOutlet weak var LtHSwith: UISwitch!
    @IBOutlet weak var filterSwitch: UISwitch!
    @IBOutlet weak var filterLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    @IBAction func switchPressedLtH(_ sender: UISwitch) {
        if sender.isOn {
                //low to high
            filterSwitch.setOn( false, animated: true)
           filteredTransactions = transactions.sorted {
                $0.amount < $1.amount
            }
            }
    }
    
    @IBAction func switchPressed(_ sender: UISwitch) {
        if sender.isOn {
            LtHSwith.setOn( false, animated: true)
           // high to low
            filteredTransactions = transactions.sorted {
                $0.amount > $1.amount
            }
            
            }
        
    }
    

}
