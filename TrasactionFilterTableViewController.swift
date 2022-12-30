//
//  TrasactionFilterTableViewController.swift
//  SpendIt301
//
//  Created by Zainab Muneer on 23/12/2022.
//

import UIKit

class TrasactionFilterTableViewController: UITableViewController {
  //  @IBOutlet weak var doneButton: UIBarButtonItem!
//    @IBOutlet weak var cancelButton: UIBarButtonItem!
    var transactions = [Transaction]()
    var filteredTransactions: [Transaction] = []
//    @IBOutlet weak var LtHLable: UILabel!
//    @IBOutlet weak var LtHSwith: UISwitch!
 //   @IBOutlet weak var HtLSwitch: UISwitch!
//    @IBOutlet weak var HtLLable: UILabel!
//    @IBOutlet weak var CollectionViewCell: UICollectionView!
    
    @IBAction func HtLPressed(_ sender: UISwitch) {
        if sender.isOn {
                   //low to high
           // HtLSwitch.setOn( false, animated: true)
              filteredTransactions = transactions.sorted {
                   $0.amount > $1.amount
               }
   
               }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let saveTransaction=Transaction.loadTransaction(){
            transactions=saveTransaction

        }else{
            transactions=Transaction.loadSampleTransacion()
        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cat: Category
        let categories=[Category]()
       

        if indexPath.section == 0 {
            var filteredCateegory: [[Category]] = Category.loadSampleCategories()
           let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! FilterCatTableViewCell
            //let symbol = categories
 cell.catLbl?.text = filteredCateegory[indexPath.section][indexPath.row].symbol
            
            return cell
    
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath) as! FilterPriceTableViewCell
            
            return cell
        }
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let toTransactions = segue.destination as? TransactionTableViewController{
            toTransactions.transactions=filteredTransactions
            toTransactions.searchController.searchBar.selectedScopeButtonIndex=0
            
        }
                
        }
    

//    @IBAction func switchPressedLtH(_ sender: UISwitch) {
//        if sender.isOn {
//                //low to high
//           filterSwitch.setOn( false, animated: true)
//           filteredTransactions = transactions.sorted {
//                $0.amount < $1.amount
//            }
//
//            }
//    }

//    @IBAction func cancelButtonPressed(_ sender: Any) {
//
//
//    }
    // notification>>
    func scheduleNotifications(){
        // if notification when (+) button is pressed, if not just add in viewdidload()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted{
                // scheduleNotifications()
            }
           
        }
        
        
        UNUserNotificationCenter.current().getNotificationSettings{(settings) in
            if settings.authorizationStatus == .authorized{
                let content = UNMutableNotificationContent()
                    content.title="Spend It"
                    content.subtitle="Have you recorded your spending today?💲"
                    content.sound = .default
    
                var date = DateComponents()
                date.calendar = Calendar.current
                date.hour = 19 //everyday @7pm aka 19
                date.minute = 0
                //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(60), repeats: true)
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            
                }
            }
    }
//    @IBAction func switchPressed(_ sender: UISwitch) {
//        if sender.isOn {
//            LtHSwith.setOn( false, animated: true)
//           // high to low
//            filteredTransactions = transactions.sorted {
//                $0.amount > $1.amount
//            }
//
//            }
//
//    }
    

}
