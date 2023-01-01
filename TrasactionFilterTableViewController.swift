//
//  TrasactionFilterTableViewController.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 23/12/2022.
//

import UIKit

class TrasactionFilterTableViewController: UITableViewController {

    var transactions = [Transaction]()
    var filteredTransactions: [Transaction] = []

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        if let saveTransaction=Transaction.loadTransaction(){
            transactions=saveTransaction

        }else{
            transactions=Transaction.loadSampleTransacion()
        }
        doneButton.isEnabled = false
        
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cat: Category
     //   let categories=[Category]()
       

        if indexPath.section == 0 {
//            var filteredCateegory: [[Category]] = Category.loadSampleCategories()
//           let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! FilterCatTableViewCell
//            //let symbol = categories
// cell.catLbl?.text = filteredCateegory[indexPath.section][indexPath.row].symbol
    let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! FilterCatTableViewCell
//            cell.collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
//            cell.catLbl?.text = cell.filteredCateegory[indexPath.section][indexPath.row].symbol
            // cell.catLbl?.text = filteredCateegory[indexPath.section][indexPath.row].symbol
            return cell
    
        }
        else if indexPath.row == 1{
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath)
            

            return cell
        } else {
           let cell = tableView.dequeueReusableCell(withIdentifier: "LtHCell", for: indexPath)
            return cell
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else{
            return 2
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let toTransactions = segue.destination as? TransactionTableViewController{
            print(toTransactions.transactions=filteredTransactions)
            toTransactions.searchController.searchBar.selectedScopeButtonIndex=0
        print(filteredTransactions)
        }
                
        }
  

    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Filtery by Catogries"
        }else {
            return "Filter by Price"
        }
    }

    
  
    
    
    @IBAction func LtHSwitch(_ sender: UISwitch) {
        
        if sender.isOn {
            doneButton.isEnabled=true
           
            filteredTransactions = transactions.sorted {
              $0.amount < $1.amount
            }
    
            }
            else{
                
                doneButton.isEnabled=false
             
                
            }
        
        
    }
   
    
    @IBAction func switchPressed(_ sender: UISwitch) {
        doneButton.isEnabled=true
        if sender.isOn {
           
          
           // high to low
            filteredTransactions = transactions.sorted {
              $0.amount > $1.amount
            }
      
            }
        else{
            sender.setOn(false, animated: true)
            doneButton.isEnabled=false
           
            
        }
    

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
               return 80
        } else {
            return 50
        }
      
        
    }
    

}
