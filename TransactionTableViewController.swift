//
//  TransactionTableViewController.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 21/12/2022.
//

import UIKit


class TransactionTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate{
  
    
    @IBOutlet weak var filterBtn: UIButton!
    var transactions=[Transaction]()
    let searchController=UISearchController()
    var searchedItem: [Transaction] = []
   
   
    @IBAction func EditPressed(_ sender: Any) {
         let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
        navigationItem.rightBarButtonItem = editButtonItem
  
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //
        
        //search bar properties
      title="Transactions"
        navigationItem.searchController=searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.showsScopeBar = true
        searchController.searchResultsUpdater=self
        searchController.searchBar.delegate=self
        searchController.searchBar.placeholder="Transaction Name"
        searchController.searchBar.scopeButtonTitles = ["All", "Expenses", "Incomes"]
       
        if let saveTransaction=Transaction.loadTransaction(){
            transactions=saveTransaction

        }else{
            transactions=Transaction.loadSampleTransacion()
        }
        searchedItem=transactions
    }
  

//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//
//    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func tableView(_ tableView: UITableView,
       commit editingStyle: UITableViewCell.EditingStyle,
       forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            transactions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
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
                let scopeMatch = (scopeButton == "All" || item.transactionType.localizedCaseInsensitiveContains(scopeButton))
            if(searchController.searchBar.text != "" ){
                let searchedTextMatch = item.transactionName.localizedCaseInsensitiveContains(searchText)
                return scopeMatch&&searchedTextMatch
            } else {
                return scopeMatch
            }
            })
        tableView.reloadData()

    }
    var isUnwind=false
    
    @IBAction func unwindFromFilter(sender: UIStoryboardSegue){
        tableView.reloadData()
        isUnwind=true
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        
        if searchController.isActive{
            return searchedItem.count
           
        } else if searchController.searchBar.selectedScopeButtonIndex==1 || searchController.searchBar.selectedScopeButtonIndex==2{
            return searchedItem.count
        }
        else{
            return transactions.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionTableViewCell

//         Configure the cell...
        var  transaction:Transaction
        if searchController.isActive{
            transaction=searchedItem[indexPath.row]
           
        } else if searchController.searchBar.selectedScopeButtonIndex==1 || searchController.searchBar.selectedScopeButtonIndex==2 {
            transaction=searchedItem[indexPath.row]
        }
        else{
            transaction=transactions[indexPath.row]
        }
       
        
        cell.update(with: transaction)

        return cell
    }
//
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Transaction"
    }

  
    
    
    

}
