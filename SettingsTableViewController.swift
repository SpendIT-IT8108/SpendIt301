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
            mailComposer.setMessageBody("Hello, this is an email from the appI made.", isHTML: false)
       //present mail composer
            present(mailComposer, animated: true, completion: nil)

        }
    }
    

    //dismiss the mail compose view controller and return to the app.
    func mailComposeController(_ controller:
       MFMailComposeViewController, didFinishWith result:
       MFMailComposeResult, error: Error?) {

            dismiss(animated: true, completion: nil)
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


