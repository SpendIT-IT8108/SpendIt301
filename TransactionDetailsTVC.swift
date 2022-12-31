//
//  TransactionDetailsTVC.swift
//  SpendIt301
//
//  Created by A'laa Alekri on 29/12/2022.
//

import UIKit

class TransactionDetailsTVC: UITableViewController {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var coloredView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var transactionNameLabel: UILabel!
    @IBOutlet weak var categorySymbolLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var attachmentImageView: UIImageView!
    var transaction : Transaction
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if transaction.category.type == "Income" {
            coloredView.backgroundColor = UIColor(red: 224.0/255, green: 223.0/255, blue: 119.0/255, alpha: 1.0)
            categoryNameLabel.textColor = .black
            amountLabel.textColor = .black
            currencyLabel.textColor = .black
        }
        categorySymbolLabel.text = transaction.category.symbol
        categoryNameLabel.text = transaction.category.name
        transactionNameLabel.text = transaction.name
        typeLabel.text = transaction.category.type
        dateLabel.text = transaction.date.formatted(date: .numeric, time: .omitted)
        notesLabel.text = transaction.note
        amountLabel.text = String(format: "%.2f", transaction.amount)
        if let note = transaction.note {
            notesLabel.text = note
        } else{
            notesLabel.text = "Nothing"
        }
        if transaction.repeated  == true {
            if let interval = transaction.repeatingInterval, let from = transaction.repeatFrom?.formatted(date: .numeric, time: .omitted) {
                if let end = transaction.repeatUntil?.formatted(date: .numeric, time: .omitted) {
                    repeatLabel.text = "\(interval), Starting from \(from) Until \(end)"
                }
                repeatLabel.text = "\(interval), Starting from \(from)"
            }
        }
        else {
            repeatLabel.text = "Never"
        }
    }
    
    
    init? (coder: NSCoder, transaction: Transaction){
        self.transaction = transaction
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    @IBSegueAction func showForm(_ coder: NSCoder, sender: Any?) -> AddTransactionTVC? {
        return AddTransactionTVC(coder: coder, transaction: self.transaction)
        
    }
    
    @IBAction func unwindToDetails(segue: UIStoryboardSegue){
        if segue.identifier == "cancelEditUnwind", let sourceViewController = segue.source as? AddTransactionTVC, let transaction = sourceViewController.transaction {
            self.transaction = transaction
        }
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
