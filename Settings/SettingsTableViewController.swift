//
//  SettingsTableViewController.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 28/12/2022.
//

import UIKit
import SafariServices
import MessageUI
import Firebase
import FirebaseAuth

class SettingsTableViewController: UITableViewController,MFMailComposeViewControllerDelegate  {

    
    //index pathes
    //first section
    let profileIndexPath = IndexPath(row: 0, section: 0)
    
    //second section
    let languageIndexPath = IndexPath(row: 0, section: 1)
    let currencyIndexPath = IndexPath(row: 1, section: 1)
    let emailIndexPath = IndexPath(row: 2, section: 1)
    let aboutUsIndexPath = IndexPath(row: 3, section: 1)
    //third section
    let exportToCsvPath = IndexPath(row: 0, section: 2)
    //fifth section
    let resetApp = IndexPath(row: 0, section: 3)
    

        //declare user defaults
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var nameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //language segments changing according to the user choice + language displayed
        let currentLang = Locale.current.languageCode
        if currentLang == "ar" {
            languageSegment.selectedSegmentIndex = 1
        }
        else {
            languageSegment.selectedSegmentIndex = 0
        }
        //set the email in the label
       let userEmail = Auth.auth().currentUser?.email
        if (userEmail != ""){
            nameLbl.text = userEmail
        }
        
        //get the value of the language from user setup, and change its state

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == emailIndexPath {
            guard MFMailComposeViewController.canSendMail() else { return }
            //Create an instance of MFMailComposeViewController and set the view controller as the mailComposeDelegate
           
                let mailComposer = MFMailComposeViewController()
                mailComposer.mailComposeDelegate = self
            //set email parts
            mailComposer.setToRecipients(["spend@it.com"])
            mailComposer.setSubject("Look at this")
            mailComposer.setMessageBody("Hello, this is an email from the appI made.", isHTML: false)        //present mail composer
            present(mailComposer, animated: true, completion: nil)

        }
        
        //code for export csv
        if indexPath == exportToCsvPath {
            //stream data to memory
            let output = OutputStream.toMemory()
            //csv writer
            let csvWriter = CHCSVWriter(outputStream: output, encoding: String.Encoding.utf8.rawValue, delimiter: ",".utf16.first!)
            //file name
            let sFileName = "transactions.csv"
            //documet directory path
            let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0] as String
            
            let documentURL = URL(fileURLWithPath: documentDirectoryPath).appendingPathComponent(sFileName)
            
            //create csv file
            //header for csv writer
            csvWriter?.writeField("Transaction Name")
            csvWriter?.writeField("Transaction Type")
            csvWriter?.writeField("Transaction Amount")
            csvWriter?.writeField("Transaction Category")
            csvWriter?.writeField("Repeated")
            csvWriter?.writeField("Repeating interval")
            csvWriter?.writeField("Repeating From")
            csvWriter?.writeField("Repeating Until")
            csvWriter?.writeField("Transaction Note")
            //new row
            csvWriter?.finishLine()
            
            
            //array of transactions
            let arrayOfTransactions = Transaction.loadTransactions()
            
            for transaction in arrayOfTransactions {
                //name
                csvWriter?.writeField(transaction.name)
                
                //Type and amount (based on transaction's category type)
                if transaction.category.type == "Expense"{
                    csvWriter?.writeField("Expense")
                    csvWriter?.writeField("- \(transaction.amount)")
                }else{
                    csvWriter?.writeField("Income")
                    csvWriter?.writeField(transaction.amount)
                }
               
                //category
                csvWriter?.writeField(transaction.category.name + transaction.category.symbol)
                //repated
                if transaction.repeated == true {
                    csvWriter?.writeField("yes")
                }else{
                    csvWriter?.writeField("no")
                }
                //from //until
                csvWriter?.writeField(transaction.repeatingInterval)
                csvWriter?.writeField(transaction.repeatFrom)
                csvWriter?.writeField(transaction.repeatUntil)
                //note
                csvWriter?.writeField(transaction.note)

                csvWriter?.finishLine()
            }
            
            csvWriter?.closeStream()
            
            //save to file
            let buffer = (output.property(forKey: .dataWrittenToMemoryStreamKey) as? Data)!
            do {
                try buffer.write(to: documentURL)
            }catch{
                
            }
            // create the alert
            let alert = UIAlertController(title: "SpendIt Would you like to acceess your files app", message: "Allow access to files to preview your csv file", preferredStyle: UIAlertController.Style.alert)

            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Allow", style: UIAlertAction.Style.default, handler: {action in self.openSharedFilesApp()}))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
        //reset app
         if indexPath == resetApp {
             //get transaction list
           var transactions = Transaction.loadTransactions()
             //get category list
            var categories = Category.loadCategories()!
             // create the alert
            let alert = UIAlertController(title: "Remove All Data", message: "This action will 'permanently' delete all your data and the app will quit to perform action", preferredStyle: UIAlertController.Style.alert)
                     // add the actions (buttons)
             alert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: {action in
                 //remove all elemnts in list
                 transactions.removeAll()
                 categories.removeAll()
                  //save
                 Transaction.saveTransactions(transactions)
                 Category.saveCategories(categories)
                 //quit app
                exit(0)
             }))
             alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                     // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    

    //dismiss the mail compose view controller and return to the app.
    func mailComposeController(_ controller:
       MFMailComposeViewController, didFinishWith result:
       MFMailComposeResult, error: Error?) {

            dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBOutlet weak var languageSegment: UISegmentedControl!
    @IBAction func languageSegmentHasChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            //english
    case 0:
            //save the current language in a let
            let currentLang = Locale.current.languageCode
            //check the current language and change it according to the choice
            let newLanguage = currentLang == "en" ? "ar" : "en"
            //call the function
            languageAlert(newLanguage: newLanguage)

            //arabic
    case 1:
            //save the current language in a let
            let currentLang = Locale.current.languageCode
            //check the current language and change it according to the choice
            let newLanguage = currentLang == "ar" ? "en" : "ar"
            //call the function
            languageAlert(newLanguage: newLanguage)
   
        default:
            break
        }
    }

    @IBAction func notificationSwitchHasChanged(_ sender: UISwitch) {
        if sender.isOn{
        let content = UNMutableNotificationContent()
        content.title="Spend It"
        content.subtitle="Have you recorded your spending today?????"
        content.sound = .default
        
        var date = DateComponents()
        date.calendar = Calendar.current
        date.hour = 20 //everyday @8pm aka 20
        date.minute = 28
        date.second = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    
        }
    }
    
    func openSharedFilesApp() {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sharedurl = documentsUrl.absoluteString.replacingOccurrences(of: "file://", with: "shareddocuments://")
        let furl:URL = URL(string: sharedurl)!
        if UIApplication.shared.canOpenURL(furl) {
            UIApplication.shared.open(furl, options: [:])
        }
    }
    
    //function to alert the user about changing the language action process and setting the value in user defaults
    func languageAlert(newLanguage:String){
        // create the alert
        let alert = UIAlertController(title: "Lnaguage switching", message: "Are you sure that you want to change the language? The app needs to quit and reopen to change it. Therefore, do these steps! ", preferredStyle: UIAlertController.Style.alert)
//"The app needs to quit and reopen to change the language. Therefore, do these steps!"
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            UserDefaults.standard.setValue([newLanguage], forKey: "AppleLanguages")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    

}


