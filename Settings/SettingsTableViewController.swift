//
//  SettingsTableViewController.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 28/12/2022.
//

import UIKit
import SafariServices
import MessageUI

class SettingsTableViewController: UITableViewController,MFMailComposeViewControllerDelegate  {

    //index pathes
    //first section
    let profileIndexPath = IndexPath(row: 0, section: 0)
    
    //second section
    let notificationIndexPath = IndexPath(row: 0, section: 1)
    let languageIndexPath = IndexPath(row: 1, section: 1)
    let currencyIndexPath = IndexPath(row: 2, section: 1)
    let darkModeIndexPath = IndexPath(row: 3, section: 1)
    let emailIndexPath = IndexPath(row: 4, section: 1)
    let guideIndexPath = IndexPath(row: 5, section: 1)
    let aboutUsIndexPath = IndexPath(row: 6, section: 1)
    let exportToCsvPath = IndexPath(row: 0, section: 2)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == emailIndexPath {
            guard MFMailComposeViewController.canSendMail() else { return }
            //Create an instance of MFMailComposeViewController and set the view controller as the mailComposeDelegate
           
                let mailComposer = MFMailComposeViewController()
                mailComposer.mailComposeDelegate = self
            //set email parts
            mailComposer.setToRecipients(["example@example.com"])
            mailComposer.setSubject("Look at this")
            mailComposer.setMessageBody("Hello, this is an email from the appI made.", isHTML: false)        //present mail composer
            present(mailComposer, animated: true, completion: nil)

        }
        
        
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
            let currentLang = Locale.current.languageCode
            let newLanguage = currentLang == "en" ? "en" : "en"
            UserDefaults.standard.setValue([newLanguage], forKey: "AppleLanguages")
            
            exit(0)
        break
            //arabic
    case 1:
            languageSegment.selectedSegmentIndex = 1
            languageSegment.selectedSegmentIndex = UISegmentedControl.noSegment
            let currentLang = Locale.current.languageCode
            let newLanguage = currentLang == "ar" ? "en" : "ar"
            UserDefaults.standard.setValue([newLanguage], forKey: "AppleLanguages")
            exit(0)
         
        break
        default:
            break
        }
    }
    
    @IBAction func currencySegmentHasChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
    case 0:
            let usrRegionCode = Locale.current.currencyCode!
print(usrRegionCode)
        break
    case 1:
        break
        default:
            break
        }
    }
    
    @IBAction func notificationSwitchHasChanged(_ sender: UISwitch) {
    }
    
    func openSharedFilesApp() {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sharedurl = documentsUrl.absoluteString.replacingOccurrences(of: "file://", with: "shareddocuments://")
        let furl:URL = URL(string: sharedurl)!
        if UIApplication.shared.canOpenURL(furl) {
            UIApplication.shared.open(furl, options: [:])
        }
    }
    
    
    
    

}


    // MARK: - Table view data source


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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


