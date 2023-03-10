//
//  TransactionTableViewController.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 21/12/2022.
//

import UIKit


class TransactionTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate{
    
    //properties
    @IBOutlet weak var filterBtn: UIButton!
    var transactions=[Transaction]()
    let searchController=UISearchController()
    var searchedItem: [Transaction] = []
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //search bar properties
        title="Transactions"
        navigationItem.searchController=searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.showsScopeBar = true
        searchController.searchResultsUpdater=self
        searchController.searchBar.delegate=self
        searchController.searchBar.placeholder="Search by name or amount"
        searchController.searchBar.scopeButtonTitles = ["All", "Expense", "Income"]
        
        //update repeated and load the transactions
        Transaction.updateRepeated()
        transactions=Transaction.loadTransactions()
        searchedItem=transactions
        
        //refresh page
        self.refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(refresh), for:  UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl!)
        
    }
    @objc func refresh(sender: UIRefreshControl){
        transactions=Transaction.loadTransactions()
        self.tableView.reloadData()
        self.refreshControl!.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
   
    

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

                //if expense
            if searchController.isActive || searchController.searchBar.selectedScopeButtonIndex==1 {
                //remove item
                searchedItem.remove(at: indexPath.row)
                //add income
                transactions=searchedItem+transactions.filter({
                    item in
                    item.category.type.localizedStandardContains("income")
                })
                    //save changes
                    tableView.deleteRows(at: [indexPath], with:.automatic)
                    Transaction.saveTransactions(transactions)
                  
            }
            //if income
          else if searchController.isActive || searchController.searchBar.selectedScopeButtonIndex==2 {
              //remove item
                searchedItem.remove(at: indexPath.row)
              //add expenses
                transactions=searchedItem+transactions.filter({
                    item in
                    item.category.type.localizedStandardContains("expense")
                })
              //save data
                    tableView.deleteRows(at: [indexPath], with:.automatic)
                    Transaction.saveTransactions(transactions)
                  
            }
            else {
            transactions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with:.automatic)
            Transaction.saveTransactions(transactions)
            }
            self.viewDidLoad()
//            transactions.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)

        }

       
        
    }


    
    
    
    
    func updateSearchResults(for searchController: UISearchController){
        
        let searchString = searchController.searchBar.text!
        let scopeButton = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
        filterForSearchAndScope(searchText: searchString, scopeButton: scopeButton)
        
    }
    //
    func filterForSearchAndScope(searchText: String, scopeButton: String = "All"){
        
        searchedItem = transactions.filter(
              { item in
                  let scopeMatch = (scopeButton == "All" || item.category.type.localizedCaseInsensitiveContains(scopeButton))
                  //if searcgbar is not empty
              if(searchController.searchBar.text != "" ){
                  // if searchbar is number
                  if Double(searchText) != nil{
                      //searches based on number
                      let  searchedTextMatch = ((String)(item.amount)).localizedCaseInsensitiveContains(searchText)
                      return scopeMatch&&searchedTextMatch
                      
                  } else {
                      
                      let searchedTextMatch = item.name.localizedCaseInsensitiveContains(searchText)
                      return scopeMatch&&searchedTextMatch
                  }
                  
                  
              } else {
                  return scopeMatch
              }
              })
          tableView.reloadData()
        
    }
   

    
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        if searchController.isActive{
            return searchedItem.count
            
        }
        else if searchController.searchBar.selectedScopeButtonIndex==1 || searchController.searchBar.selectedScopeButtonIndex==2{
            return searchedItem.count
        }
        else{
            return transactions.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //dequeing the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionTableViewCell
        var  transaction:Transaction
    
        //  if searched or use scope
        if searchController.isActive  || searchController.searchBar.selectedScopeButtonIndex==1 || searchController.searchBar.selectedScopeButtonIndex==2{
            transaction=searchedItem[indexPath.row]
            
        }
        
        else{
            transaction=transactions[indexPath.row]
        }
        
        //update cell's content
        cell.update(with: transaction)
        
        return cell
    }
    //
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Transactions"
    }
    
    
    
    
    //MARK: Navigation (Segue)
    
    @IBAction func EditPressed(_ sender: Any) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    
    @IBAction func unwindtoTransactionList(sender: UIStoryboardSegue){
        if sender.identifier == "doneIdentifier" {
            tableView.reloadData()
        }
        
        
    }
    @IBSegueAction func showDetails(_ coder: NSCoder, sender: Any?) -> TransactionDetailsTVC? {
        //redirect user to transaction details passing the selected transaction as a parameter
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            var transaction: Transaction
            if searchController.isActive{
                transaction=searchedItem[indexPath.row]
            } else if searchController.searchBar.selectedScopeButtonIndex==1 ||
                        searchController.searchBar.selectedScopeButtonIndex==2{
                transaction=searchedItem[indexPath.row]
                
            } else{
                transaction = transactions[indexPath.row]
            }
            
            
            return TransactionDetailsTVC(coder: coder, transaction: transaction)
        }
        else {
            return nil
        }
    }
    
    
    @IBAction func unwindToList(segue: UIStoryboardSegue){
        //unwind to this list after adding or updating a transaction
        guard segue.identifier == "saveUnwind", let sourceViewController = segue.source as? AddTransactionTVC, let transaction = sourceViewController.transaction else {return}
        //if table has a selected cell, it means we're back from editing the selected
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            //in case of unwind after being redirected to the original repeated record, get the original record index bath instead of previously selected and update it
            if transaction.nextDate != nil {
                for tran in Transaction.loadTransactions() {
                    if tran.name == transaction.name && tran.nextDate != nil {
                        let originalIndex = Transaction.loadTransactions().firstIndex(of: tran)
                        transactions[originalIndex!] = transaction
                        //reload the row to provide updating feedback to user
                        tableView.reloadRows(at: [IndexPath(row: originalIndex!, section: 0)], with: .automatic)
                    }
                }
            }
            else {
                //set the updated transaction record to the previously selected one
                transactions[selectedIndexPath.row] = transaction
                //reload the row to provide updating feedback to user
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            }
        }
        else {
            //add the transaction to the array, which will be saved and reloaded sorted by date that determines the new record position
            transactions.append(transaction)
        }
        //save list, update any possible repeats, and reload data after insert/edit
        Transaction.saveTransactions(transactions)
        Transaction.updateRepeated()
        transactions = Transaction.loadTransactions()
        tableView.reloadData()
        
        
    }
    
    //segue performed when transactions associated with category are removed
    @IBAction func unwindToRemoveAllTransactions(segue: UIStoryboardSegue){
        //tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        tableView.reloadData()
        viewDidLoad()
    }
    
}
