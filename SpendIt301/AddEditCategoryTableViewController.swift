    //
    //  AddEditCategoryTableViewController.swift
    //  SpendIt301
    //
    //  Created by Maryam Taraif on 28/12/2022.
    //

    import UIKit

    class AddEditCategoryTableViewController: UITableViewController {
        var category: Category?
        
        @IBOutlet weak var nameTextField: UITextField!
        @IBOutlet weak var saveButton: UIBarButtonItem!
        @IBOutlet weak var spendingLimitTextField: UITextField!
        @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
        @IBOutlet weak var symbolTextField: UITextField!
        @IBOutlet weak var cancelButton: UIBarButtonItem!
        
       
        
        init?(coder:NSCoder , category:Category?){
            self.category = category
            super.init(coder: coder)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //add/edit
            if let category = category {
                //get data of selected category
                symbolTextField.text = category.symbol
                nameTextField.text = category.name
                
                if let spendingLimit = category.spendingLimit {
                    spendingLimitTextField.text = String (spendingLimit)
                }
                if category.type == "Expense"{
                    typeSegmentedControl.selectedSegmentIndex = 0
                    symbolTextField.tintColor = UIColor(red: 27/255, green: 87/255, blue: 95/255, alpha: 1)

                    
                }else {
                    typeSegmentedControl.selectedSegmentIndex = 1
                    symbolTextField.tintColor = UIColor(red: 224/255, green: 223/255, blue: 119/255, alpha: 1)


                }
                
                title = "Edit Category"
            }
                else {
                    title = "Add Category"
                    
                }

            
            updateSaveButtonState()
        
                }
            
            

            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
        

        
        //check fields to update save button state
        func updateSaveButtonState(){
            let symbolText = symbolTextField.text ?? ""
            let nameText = nameTextField.text ?? ""
            saveButton.isEnabled = !symbolText.isEmpty && !nameText.isEmpty
        }
        
       // text fields event to check if fields contains text
        @IBAction func textEditingChanged (_ sender:UITextField){
            updateSaveButtonState()
        }
        
        //use text provided by user to construct new Category instance
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            super.prepare(for: segue, sender: sender)
            guard segue.identifier == "saveSegue" else {return}
            let symbol = symbolTextField.text!
            let name = nameTextField.text!
            let categoryType = typeSegmentedControl.titleForSegment(at: typeSegmentedControl.selectedSegmentIndex)!
            let spendingLimit = Float(spendingLimitTextField.text!) ?? nil
            //set to category property
            category = Category(name: name, symbol: symbol, spendingLimit: spendingLimit, type: categoryType)
        }
        

        
        
        //change icon color based on selected category type
        @IBAction func segmentedChanged(_ sender: Any) {
            if typeSegmentedControl.selectedSegmentIndex == 0 {
                symbolTextField.tintColor = UIColor(red: 27/255, green: 87/255, blue: 95/255, alpha: 1)

            }else if typeSegmentedControl.selectedSegmentIndex == 1{
                symbolTextField.tintColor = UIColor(red: 224/255, green: 223/255, blue: 119/255, alpha: 1)
            }
            
        }
        
        
        @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
            showDiscardAlert()
        }
        func showDiscardAlert(){
            // create the alert
            let alert = UIAlertController(title: "Discard Changes", message: "Are you sure you want to discard changes?.", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                
            alert.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: { _ in self.performSegue(withIdentifier: "cancelSegue", sender: self.cancelButton) }))

                    // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
        
       
        
        
        
        
        
        // MARK: - Table view data source
     
        
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 1
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 3
    //    }

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

