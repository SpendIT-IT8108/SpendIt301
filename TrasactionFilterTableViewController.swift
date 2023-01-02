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
    var HtLSwitchOutlet: UISwitch!
    var LtHSwitchOutlet: UISwitch!
    var repeated: UISwitch!
//
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        doneBtn.isEnabled=false
        clearBtn.isEnabled=true
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

    let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! FilterCatTableViewCell

            return cell
    
        }
else if indexPath.row == 0 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath) as! SortPriceTableViewCell

      HtLSwitchOutlet=cell.HtLSwitch!
  

            return cell
        }
        else if indexPath.row == 1 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "LtHCell", for: indexPath) as! SortPriceTableViewCell
                LtHSwitchOutlet=cell.LtHSwitch!
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "repeatedCell", for: indexPath) as! SortPriceTableViewCell
            repeated=cell.firstSwitch
            return cell
        }
       

    
}
    @IBOutlet weak var doneBtn: UIBarButtonItem!
   
    
    @IBAction func donePressed(_ sender: Any) {
      
    }
    @IBOutlet weak var clearBtn: UIBarButtonItem!
    
 
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
            HtLSwitchOutlet.setOn(false, animated: true)
            doneBtn.isEnabled=true
            clearBtn.isEnabled=true
            filteredTransactions = transactions.sorted {
              $0.amount < $1.amount
               
            }
      
        } else{
            doneBtn.isEnabled=false
           
        }

    }
    
    @IBAction func HtLSwitch(_ sender: UISwitch) {
    
        if sender.isOn {
            LtHSwitchOutlet.setOn(false, animated: true)
         doneBtn.isEnabled=true
            clearBtn.isEnabled=true
            filteredTransactions = transactions.sorted {
              $0.amount > $1.amount
            }
      
        } else{
            doneBtn.isEnabled=false
           
        }
        

    }
    @IBAction func clearPressed(_ sender: UIButton) {
        HtLSwitchOutlet.setOn(false, animated: true)
        LtHSwitchOutlet.setOn(false, animated: true)
        if repeated != nil{
            repeated.setOn(false, animated: true)
        }
        else {
            print(repeated)
        }

      
    }
    @IBAction func repeatedPresed(_ sender: UISwitch) {
        if sender.isOn{
            doneBtn.isEnabled=true
        filteredTransactions = transactions.filter(
              {item in
                  item.repeated==true
              })
        } else{
            doneBtn.isEnabled=false
        }
        
    }
    
    

    @IBAction func categoryPressed(_ sender: UIButton) {
        var countClickedButtons = 0
         //shows button's selected
        if sender.isSelected {
                 countClickedButtons -= 1     // It will be deselected
           

             } else {
                 countClickedButtons += 1    // It will be selected
                 doneBtn.isEnabled=true
        
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
                         
                         sender.isSelected = !sender.isSelected
                     }
                      filteredTransactions = transactions
                  }
                  else{
          //            doneBtn.isEnabled=true
                      clearBtn.isEnabled=true
                     
                  }
                
                      

          }
             sender.isSelected = !sender.isSelected
        

          
         
     }

     
     override func numberOfSections(in tableView: UITableView) -> Int {
         return 2
     }


     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if section == 0 {
             return 1
         } else{
             return 3
             
         }
     }
}
