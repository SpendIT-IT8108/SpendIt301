//
//  OverviewTableViewController.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 25/12/2022.
//

import UIKit
import Charts
class OverviewTableViewController: UITableViewController{

    @IBOutlet weak var overviewTitle: UINavigationItem!
    let barchartIndexPath = IndexPath(row: 0, section: 0)
    let mostspentIndexPath = IndexPath(row: 0, section: 1)
    let mosttarckedIndexPath = IndexPath(row: 0, section: 2)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loclaize the title
        overviewTitle.title = NSLocalizedString("Overview", comment: "")
       
        //spaces between section
        tableView.sectionFooterHeight=6.0
        tableView.sectionHeaderHeight=6.0
        tableView.allowsSelection = false
    }
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "BarChartTableViewCell", for: barchartIndexPath) as! BarChartTableViewCell
        cell1.customizeChart()
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "MostSpentTableViewCell", for: mostspentIndexPath) as! MostSpentTableViewCell
        cell2.addToCell()
        
         let cell3 = tableView.dequeueReusableCell(withIdentifier: "MostTrackedTableViewCell", for: mosttarckedIndexPath) as! MostTrackedTableViewCell
        cell3.addToCell()
        
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
        if  indexPath.section == 0 && indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BarChartTableViewCell", for: indexPath) as! BarChartTableViewCell

        // Configure the cell...
            self.tableView.rowHeight = 290
        return cell
        }
        else if  indexPath.section == 1 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MostSpentTableViewCell", for: indexPath) as! MostSpentTableViewCell

            // Configure the cell...
                self.tableView.rowHeight = 160
            return cell
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


}
