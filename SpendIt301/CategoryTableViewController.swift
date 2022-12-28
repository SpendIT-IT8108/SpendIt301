//
//  CategoryTableViewController.swift
//  SpendIt301
//
//  Created by Maryam Taraif on 22/12/2022.
//

import UIKit

class CategoryTableViewController: UITableViewController,UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
  
    @available(iOS 15, *)
       
        var categories = [[Category]] ()
        let sections = ["Expenses","Incomes"];
        let searchController = UISearchController()
        var scopebuttonPressed = false;
        var searching = false;
        var filteredCateegory: [[Category]] = Category.loadSampleCategories()
      
        override func viewDidLoad() {
            super.viewDidLoad()
         
            
            
            if let savedCategories = Category.loadCategories() {
                categories = savedCategories
            } else {
                categories = Category.loadSampleCategories()
            }
            
            navigationItem.leftBarButtonItem = editButtonItem
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            
            searchController.obscuresBackgroundDuringPresentation = false
        
            searchController.searchBar.showsScopeBar = true
            searchController.searchBar.delegate = self
            searchController.searchBar.placeholder = "Search by name"
            searchController.searchBar.scopeButtonTitles = ["All","Expenses","Incomes"]
            
            filteredCateegory = categories
            searchController.searchResultsUpdater = self

          
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
       
        override func viewWillAppear(_ animated: Bool) {
            tableView.reloadData()
        }
      

        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            if searching == true {
                return filteredCateegory.count
            }else{
                return categories.count
            }
            }
        

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            if searching == true {
                return filteredCateegory[section].count }
            else{
                    return categories[section].count
                }
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var category:Category
            //fetch model object to display
            category = filteredCateegory[indexPath.section][indexPath.row]
//            if searching == true {
//                if category.type == "Expense"{
//                    category = filteredCateegory[0][indexPath.row]
//                }else{
//                    category = filteredCateegory[1][indexPath.row]
//                }
//
//                 }else{
//                    category = filteredCateegory[indexPath.section][indexPath.row]
//
//                }
            //print(indexPath.section)
            
            
            //image based on category type
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
          //  let category = categories[indexPath.section][indexPath.row]
            //dequeue cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
         
            
            cell.imageView?.image = generateImageWithText(text: category.symbol)
            if searching == true {
                 //cell.textLabel?.text = categories[indexPath.section][indexPath.row].name
                cell.textLabel?.text = filteredCateegory[indexPath.section][indexPath.row].name
                 }
            else{
                cell.textLabel?.text = filteredCateegory[indexPath.section][indexPath.row].name
                }
                 
                 //disclosure indicator accessory
                cell.accessoryType = .disclosureIndicator
                cell.showsReorderControl = true
             

                 return cell
        }
        
//        // section title
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
////        if searching == true {
////            return " "
////        }else{
////            return "Expenses", "Incomes"?
////        }
//    }
//    func updateSearchResults(for searchController: UISearchController) {
//        searching = true
//        var result = categories.filter { (dataArray:[Category]) -> Bool in
//                    return dataArray.filter({ (category : Category) -> Bool in
//                        return category.name.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
//                        }).count > 0
//                        }
//                tableView.reloadData()
//
//
//
//    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searching = true
//        var result = categories.filter { (dataArray:[Category]) -> Bool in
//                    return dataArray.filter({ (category : Category) -> Bool in
//                        return category.name.localizedCaseInsensitiveContains(searchText)
//                        }).count > 0
//                        }
//        filteredCateegory = result
//        tableView.reloadData()
//    }
//
    
        
    

        
        
        
        

      
    //error index out of range
        
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Delete the row from the data source
                self.categories[indexPath.section].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        @IBAction  func unwindCategoryList (segue:UIStoryboardSegue){
            
        }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searching = true
        if selectedScope == 1 {
            var result = categories.filter { (dataArray:[Category]) -> Bool in
                        return dataArray.filter({ (category : Category) -> Bool in
                            return category.type.localizedCaseInsensitiveContains("Expense")
                            }).count > 0
                            }
            filteredCateegory = result
            tableView.reloadData()
        } else if selectedScope == 2{
            var result = categories.filter { (dataArray:[Category]) -> Bool in
                        return dataArray.filter({ (category : Category) -> Bool in
                            return category.type.localizedCaseInsensitiveContains("Income")
                            }).count > 0
                            }
            filteredCateegory = result
            tableView.reloadData()
        }else if selectedScope == 0{
            filteredCateegory = categories
            tableView.reloadData()
            
        }
        
    }
        
        
        
      
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            filteredCateegory = []
            searching = true
            if searchText == "" {
                filteredCateegory = categories
            }else {

            for (index, item) in categories.enumerated() {
                for category in item {
                    if category.name.localizedCaseInsensitiveContains(searchText){
                        filteredCateegory.append([category])
                        print(filteredCateegory)
                        print(category)
                }
            } }

            self.tableView.reloadData()
            searching = false

        }
        }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    

             searchBar.text = ""

            filteredCateegory = categories

            searchBar.endEditing(true)

            self.tableView.reloadData()

       
    }
    
    
    //add edit

    

    
      
    @IBSegueAction func addEditCategory(_ coder: NSCoder, sender: Any?) -> AddEditCategoryTableViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell){
            //editing category
            let categoryToEdit = categories[indexPath.section][indexPath.row]
            print(categoryToEdit)
            return AddEditCategoryTableViewController(coder: coder, category: categoryToEdit )
        }else{
            //add category
            return AddEditCategoryTableViewController(coder: coder, category: nil )
        }
    }
    //    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    //
    //    }
    //

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
