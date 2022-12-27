//
//  OverviewTableViewController.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 25/12/2022.
//

import UIKit

class OverviewTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //spaces between section
        tableView.sectionFooterHeight=6.0
        tableView.sectionHeaderHeight=6.0
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //check and register the chart cell
        if  indexPath.section == 0 && indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BarChartTableViewCell", for: indexPath) as! BarChartTableViewCell

        // Configure the cell...
            self.tableView.rowHeight = 290
        return cell
        }
        //check and register the most spent cell
        else if  indexPath.section == 1 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MostSpentTableViewCell", for: indexPath) as! MostSpentTableViewCell

            // Configure the cell...
                self.tableView.rowHeight = 160
            return cell
            //check and register the most tracked cell
        }else if  indexPath.section == 2 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MostTrackedTableViewCell", for: indexPath) as! MostTrackedTableViewCell

            // Configure the cell...
                self.tableView.rowHeight = 160
            return cell
        }
        
        
        else {
            return UITableViewCell()
        }
    }
    

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
