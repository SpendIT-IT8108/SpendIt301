//
//  TransactionDetailsTVC.swift
//  SpendIt301
//
//  Created by Kawthar Alakri on 29/12/2022.
//

import UIKit

class TransactionDetailsTVC: UITableViewController {
    
    //outlets
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
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var addedOnLbl: UILabel!
    @IBOutlet weak var repeatLbl: UILabel!
    @IBOutlet weak var notesLbl: UILabel!
    @IBOutlet weak var attachementLbl: UILabel!
    @IBOutlet weak var transDetailsLbl: UINavigationItem!
    //current transaction
    var transaction : Transaction
    
    init? (coder: NSCoder, transaction: Transaction){
        self.transaction = transaction
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        //localization
        titleLbl.text = NSLocalizedString("title", comment: "")
        typeLbl.text = NSLocalizedString("type", comment: "")
        addedOnLbl.text = NSLocalizedString("addedon", comment: "")
        repeatLbl.text = NSLocalizedString("repeat", comment: "")
        notesLbl.text = NSLocalizedString("notes", comment: "")
        attachementLbl.text = NSLocalizedString("attachment", comment: "")
        super.viewDidLoad()
        transDetailsLbl.title = NSLocalizedString("transdetails", comment: "")
        //modify colors based on the transaction type
        if transaction.category.type == "Income" {
            coloredView.backgroundColor = UIColor(red: 224.0/255, green: 223.0/255, blue: 119.0/255, alpha: 1.0)
            categoryNameLabel.textColor = .black
            amountLabel.textColor = .black
            currencyLabel.textColor = .black
        }
        
        //display transaction details into the fields
        categorySymbolLabel.text = transaction.category.symbol
        categoryNameLabel.text = transaction.category.name
        transactionNameLabel.text = transaction.name
        typeLabel.text = transaction.category.type
        dateLabel.text = transaction.date.formatted(date: .numeric, time: .omitted)
        notesLabel.text = transaction.note
        //format the amount to 2 decimal places
        amountLabel.text = String(format: "%.2f", transaction.amount)
        if let note = transaction.note {
            notesLabel.text = note
        } else{
            notesLabel.text = " "
        }
        if transaction.repeated  == true {
            if let interval = transaction.repeatingInterval, let from = transaction.repeatFrom?.formatted(date: .numeric, time: .omitted) {
                if let end = transaction.repeatUntil?.formatted(date: .numeric, time: .omitted) {
                    repeatLabel.text = "\(interval), Starting from \(from) Until \(end)"
                }
                else {
                    repeatLabel.text = "\(interval), Starting from \(from)"
                }
            }
        }
        else {
            repeatLabel.text = "Never"
        }
        if let attachment = transaction.attachment {
            attachmentImageView.image = attachment.image
        }
    }

    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 2
    }
    
    

    // MARK: - Navigation
    @IBSegueAction func showEditForm(_ coder: NSCoder, sender: Any?) -> UIViewController? {
        return AddTransactionTVC(coder: coder, transaction: self.transaction)
    }
   
    @IBAction func unwindToDetails(segue: UIStoryboardSegue){
        //unwind to the details controller once editing is cancelled
        if segue.identifier == "cancelEditUnwind", let sourceViewController = segue.source as? AddTransactionTVC, let transaction = sourceViewController.transaction {
            self.transaction = transaction
        }
    }
}
