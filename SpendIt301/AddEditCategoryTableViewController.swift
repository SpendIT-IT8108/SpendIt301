//
//  AddEditCategoryTableViewController.swift
//  SpendIt301
//
//  Created by Mohammed Taraif on 28/12/2022.
//

import UIKit

class AddEditCategoryTableViewController: UITableViewController {
    var category: Category?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var symbolTextField: UITextField!
    init?(coder:NSCoder , category:Category?){
        self.category = category
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let category = category {
            symbolTextField.text = category.symbol
            nameTextField.text = category.name
            //limit
            //type
            title = "Edit Category"
        }
            else{
                title = "Add Category"
            }
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        let alert = UIAlertController (title: "Discard Changed", message: "Are you sure you want to discard any changes that you have made?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        
        alert.addAction(UIAlertAction(title: "Discard", style: .default, handler: {action in print("action 2 clicked")}))
        present(alert, animated: true, completion: nil)
        
    }
    func showAlertView(){
       
    }
    
       
     
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
//
//    /*
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
//    */

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
