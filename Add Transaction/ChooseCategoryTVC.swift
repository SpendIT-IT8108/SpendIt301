//
//  ChooseCategoryTVC.swift
//  Pods
//
//  Created by Kawthar Alakri on 28/12/2022.
//

import UIKit

class ChooseCategoryTVC: UITableViewController {

    //categories to be displayed in the list
    var categories : [Category] = []
    
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
        //get categories based on type
        for cat in Category.loadCategories()! {
            if cat.type == type {
                categories.append(cat)
            }
        }
        
        //create extra white space above the tableview for a better design
        self.tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0);
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // determine number or rows based on the number of categories
        categories.count
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //set the header of to the category type
        return self.type
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTVCell
        let category = categories[indexPath.row]
        
        // Configure the cell...
        cell.update(with: category)
        cell.showsReorderControl = true
      
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //unwind to the form once a category has been selected
        category = categories[indexPath.row]
        performSegue(withIdentifier: "DoneUnwind", sender: self)
    }
    
}
