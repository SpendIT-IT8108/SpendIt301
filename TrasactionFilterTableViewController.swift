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

//
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        doneBtn.isEnabled=false
        clearBtn.isEnabled=false
        if let saveTransaction=Transaction.loadTransaction(){
            transactions=saveTransaction

        }else{
            transactions=Transaction.loadSampleTransacion()
        }
        
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
else if indexPath.row == 1 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath)

           //sortCell

            return cell
        }
            else {
           let cell = tableView.dequeueReusableCell(withIdentifier: "LtHCell", for: indexPath)
                
            return cell
        }
       
        
    
}
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    @IBAction func clearChoices(_ sender: Any) {
        //doneBtn.isEnabled=false
        if let isButton = sender as? UIButton{
            isButton.isEnabled = true
            isButton.isSelected = false
        }
        if let isSwitch = sender as? UISwitch {
            isSwitch.setOn(false, animated: true)
        }
        
    }
    
    @IBOutlet weak var clearBtn: UIBarButtonItem!
    
    @IBAction func categoryPressed(_ sender: UIButton) {
        //shows button's selected
    
        //choose transactions based on selected category
      filteredTransactions = transactions.filter(
            {item in
                item.category.name.localizedStandardContains(sender.currentTitle!)
            })
        
        // if selected catogory has no transactions
        if filteredTransactions.isEmpty {
            let alert = UIAlertController(title: "Category is empty", message: "There is no transactions with \(sender.currentTitle!) category", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
           present(alert, animated: true) {
               sender.isEnabled=true
               
           }
            filteredTransactions = transactions
        }
        else{
            doneBtn.isEnabled=true
            clearBtn.isEnabled=true
           
        }
            
//       if clearBtn.primaryAction != nil{
//            sender.isEnabled=true
//        }
        
        
     
        
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
            toTransactions.transactions=filteredTransactions
            toTransactions.searchController.searchBar.selectedScopeButtonIndex=0
        }
                
        }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           if indexPath.section == 0 {
                  return 80
           } else {
               return 50
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
            doneBtn.isEnabled=true
            clearBtn.isEnabled=true
            filteredTransactions = transactions.sorted {
              $0.amount < $1.amount
            }
      
            }
//        if clearBtn.isSelected{
//            sender.isOn=false
//        }
    }
    
    @IBAction func HtLSwitch(_ sender: UISwitch) {
    
        if sender.isOn {
           
            doneBtn.isEnabled=true
            clearBtn.isEnabled=true
            filteredTransactions = transactions.sorted {
              $0.amount > $1.amount
            }
      
         }
        else{
            
        }
        if clearBtn.isSelected{
            clearChoices(sender)
        }
//        clearChoices(sender)

    }
    
    

}
