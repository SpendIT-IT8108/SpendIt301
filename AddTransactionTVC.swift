//
//  AddTransactionTVC.swift
//  SpendIt301
//
//  Created by A'laa Alekri on 21/12/2022.
//

import UIKit

class AddTransactionTVC: UITableViewController {

    @IBOutlet weak var noteCell: UITableViewCell!
    @IBOutlet weak var imageCell: UITableViewCell!
    @IBOutlet weak var NotestextView: UITextView!
    @IBOutlet var addFormTable: UITableView!
    
    //repeat outlets and variables
    @IBOutlet weak var repeatOption: UISwitch!
    @IBOutlet weak var repeatIntervalCell: UITableViewCell!
    var intervalIsVisible : Bool = false
    @IBOutlet weak var repeatStart: UITableViewCell!
    var startIsVisible : Bool = false
    @IBOutlet weak var repeatEnd: UITableViewCell!
    var endIsVisible : Bool = false
    
    
    var noteSpaceIsVisible : Bool = false
    
    var attachmentIsVisible : Bool = false
    
  

    
    
    let repeatIntervalCellIndexPath = IndexPath(row: 1, section: 1)
    let repeatStartCellIndexPath = IndexPath(row: 2, section: 1)
    let repeatEndCellIndexPath = IndexPath(row: 3, section: 1)
    
    let attachOptionCellIndexPath = IndexPath(row: 4, section: 1)
    let attachmentCellIndexPath = IndexPath(row: 5, section: 1)
    
    let notesOptionCellIndexPath = IndexPath(row: 6, section: 1)
    let notesSpaceeCllIndexPath = IndexPath(row: 7, section: 1)

    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

  
    /*override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case notesSpaceeCllIndexPath:
            return 150
        default:
            return UITableView.automaticDimension
        }
    }*/
    
    
    @IBAction func repeatSwitchClicked(_ sender: UISwitch) {
        if sender.isOn {
            intervalIsVisible = true
            startIsVisible = true
            endIsVisible = true
        }
        else {
            intervalIsVisible = false
            startIsVisible = false
            endIsVisible = false
        }
        //intervalIsVisible.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath {
    case notesSpaceeCllIndexPath where noteSpaceIsVisible == false:
        return 0
    case notesSpaceeCllIndexPath where noteSpaceIsVisible == true:
        return 150
        
    case attachmentCellIndexPath where attachmentIsVisible == false:
        return 0
    case attachmentCellIndexPath where attachmentIsVisible == true:
        return 250
        
    case repeatIntervalCellIndexPath where intervalIsVisible == false:
        return 0
    case repeatIntervalCellIndexPath where intervalIsVisible == true:
        return 55
        
    case repeatStartCellIndexPath where startIsVisible == false:
        return 0
    case repeatStartCellIndexPath where startIsVisible == true:
        return 55
        
    case repeatEndCellIndexPath where endIsVisible == false:
        return 0
    case repeatEndCellIndexPath where endIsVisible == true:
        return 55
        
    default:
        return UITableView.automaticDimension
    }
        }
        
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case notesOptionCellIndexPath:
            noteSpaceIsVisible.toggle()
        case attachOptionCellIndexPath:
            attachmentIsVisible.toggle()
        default:
            return
        }
        //if user select the note option cell
        /*if indexPath == notesOptionCellIndexPath {
            //change the state of visibility
            noteSpaceIsVisible.toggle()
        }
        else {
            return
        }*/
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    
    
    

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

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

}
