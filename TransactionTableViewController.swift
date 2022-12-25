//
//  TransactionTableViewController.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 21/12/2022.
//

import UIKit


class TransactionTableViewController: UITableViewController, UISearchResultsUpdating{
  
    
    @IBOutlet weak var filterBtn: UIButton!
    var transactions=[Transaction]()
    let searchController=UISearchController()
   // var filterdTransaction: [Transaction]=[]
 

    
   
    @IBAction func EditPressed(_ sender: Any) {
         let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
        navigationItem.rightBarButtonItem = editButtonItem
  
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
      title="Transactions"
        navigationItem.searchController=searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater=self
        
      

       

        if let saveTransaction=Transaction.loadTransaction(){
            transactions=saveTransaction

        }else{
            transactions=Transaction.loadSampleTransacion()
        }
    }
  
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
    
    
    var searchedItem: [Transaction] = Transaction.loadSampleTransacion()
    
   
    func updateSearchResults(for searchController: UISearchController){
       // print(searchedItem)
        if let searchString = searchController.searchBar.text,
           searchString.isEmpty==false {
            searchedItem = transactions.filter({ item in
                item.transactionName.localizedCaseInsensitiveContains(searchString)

            })
            }
            else{

                searchedItem = transactions
            }
                    tableView.reloadData()
        
        }
        
        
    
    
    //search
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchedItem.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionTableViewCell

//         Configure the cell...

        let transaction = searchedItem[indexPath.item]
        
        
        
        cell.update(with: transaction)

        return cell
    }
//
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Transaction Name"
        
    }

  
    
    
    

}
