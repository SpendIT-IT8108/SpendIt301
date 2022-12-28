//
//  AddEditCategoryTableViewController.swift
//  SpendIt301
//
//  Created by Mohammed Taraif on 28/12/2022.
//

import UIKit

class AddEditCategoryTableViewController: UITableViewController {
    var category: Category?
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    //@IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var spendingLimitTextField: UITextField!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
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
           // symbolTextField.text = category.symbol
            nameTextField.text = category.name
            if let spendingLimit = category.spendingLimit {
                spendingLimitTextField.text = String (spendingLimit)
            }
            if category.type == "Expense"{
                typeSegmentedControl.selectedSegmentIndex = 0
                typeSegmentedControl.backgroundColor = UIColor(red: 27/255, green: 87/255, blue: 95/255, alpha: 1)
                
            }else{
                typeSegmentedControl.selectedSegmentIndex = 1
                typeSegmentedControl.backgroundColor = UIColor(red: 224/255, green: 223/255, blue: 119/255, alpha: 1)
              
            }
            
            func generateImageWithText(text: String) -> UIImage? {
                var image:UIImage
                if category.type == "Expense" {
                   image = UIImage(named: "Expense")!
                } else {
                    image = UIImage(named: "Income")!
                }
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
            
            categoryImage.image = generateImageWithText(text: category.symbol)
            
            
            
            
            title = "Edit Category"
        }
            else{
                title = "Add Category"
            }
        
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        showAlertView()
    }
    func showAlertView(){
        let alert = UIAlertController (title: "Discard Changed", message: "Are you sure you want to discard any changes that you have made?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        
        alert.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: {action in print("action 2 clicked")}))
        present(alert, animated: true, completion: nil)
        
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
