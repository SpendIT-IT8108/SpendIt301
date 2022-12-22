//
//  CategoryTableViewController.swift
//  SpendIt301
//
//  Created by Mohammed Taraif on 22/12/2022.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    var searchedCountry = [String]()
       let sections = ["Expenses","Incomes"];
       var categories:[[Category]] = [
           //expenses
           [
               Category(name: "Food", symbol: "🍔", spendingLimit: nil),
               Category(name: "Transportaion", symbol: "🚆", spendingLimit: nil),
               Category(name: "Health Care", symbol: "🏥", spendingLimit: nil),
               Category(name: "Education", symbol: "🏫", spendingLimit: nil),
               Category(name: "Gifts", symbol: "🎁", spendingLimit: nil),
               Category(name: "Shopping", symbol: "🛍️", spendingLimit: nil),
               Category(name: "Clothing", symbol: "👚", spendingLimit: nil),
               Category(name: "Car", symbol: "🚘", spendingLimit: nil),
               Category(name: "Work", symbol: "👔", spendingLimit: nil),
           ] ,
           
           //incomes
           [
               Category(name: "Salary", symbol: "💵", spendingLimit: nil),
               Category(name: "Investments", symbol: "📈", spendingLimit: nil),
              
               
           ]
           
       ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  categories[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
             let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
           //  cell.textLabel?.text = categories[indexPath.section][indexPath.row].name + categories[indexPath.section][indexPath.row].symbol
            // cell.imageView?.image = categories[indexPath.section][indexPath.row].symbol
             let category = categories[indexPath.section][indexPath.row]
            // var content = cell.defaultContentConfiguration()
             //content.text = "\(category.symbol)  \(category.name)"
             cell.imageView?.image = generateImageWithText(text: category.symbol)
             cell.textLabel?.text = categories[indexPath.section][indexPath.row].name
            // cell.contentConfiguration = content
           //  cell.contentView.backgroundColor = UIColor.blue
             
             //disclosure indicator accessory
             cell.accessoryType = .disclosureIndicator
         
             // Configure the cell...

             return cell
    }
    
    
    // section title
       override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return sections[section]
       }
    
    
    func generateImageWithText(text: String) -> UIImage? {
            let image = UIImage(named: "Expense")!

            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)

            let label = UILabel(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            label.backgroundColor = UIColor.clear
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.text = text

            UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
            imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
            label.layer.render(in: UIGraphicsGetCurrentContext()!)
            let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return imageWithText
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
