//
//  ChooseCategoryTVC.swift
//  Pods
//
//  Created by A'laa Alekri on 28/12/2022.
//

import UIKit

class ChooseCategoryTVC: UITableViewController {

    //categories to be displayed in the list
    var categories : [Category] = Category.loadCategories()!
    
    //SELECTED CATEGORY
    var type : String
    var category : Category?
    
    init?(coder: NSCoder, type: String){
        self.type = type
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for cat in categories {
            if cat.type == type {
                categories.append(cat)
            }
        }
        
        self.tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0);

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // determine number or rows based on teh type
        categories.count
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.type
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTVCell
        let category = categories[indexPath.row]
        // Configure the cell...
        cell.update(with: category)
        cell.showsReorderControl = true
        
        //var content = cell.defaultContentConfiguration()
        //content.text = category.name
        //cell.contentConfiguration = content
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        category = categories[indexPath.row]
        performSegue(withIdentifier: "DoneUnwind", sender: self)
    }
    /*
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //get the selected category object from the category array and assign to the category instance
        category = categories[indexPath.row]
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

    
    // MARK: - Navigation (Segues)

    // In a storyboard-based application, you will often want to do a little
    /*preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        guard segue.identifier == "DoneUnwind", let selected =  tableView.indexPathForSelectedRow else { return }
        // Pass the selected object to the new view controller.
        if type == "Expense" {
            self.category = Category.loadSampleCategories()[0][  selected.row]
        }
        else {
            self.category = Category.loadSampleCategories()[1][  selected.row]
        }
      
        //get selected category details and assign it to category variable
    }
    */

}
