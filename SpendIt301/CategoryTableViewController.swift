
//
//  CategoryTableViewController.swift
//
//  Created by Maryam Taraif on 26/12/2022.
//

import UIKit

class CategoryTableViewController: UITableViewController,UISearchBarDelegate,UISearchResultsUpdating {

    @available(iOS 15, *)
       
        //categories list
        var categories = [Category] ()
        var filteredCategories: [Category] = []
        
        //search controller
        let searchController = UISearchController()
        var scopebuttonPressed = false;

      
        override func viewDidLoad() {
            super.viewDidLoad()
         
            //load categories
            if let savedCategories = Category.loadCategories() {
                categories = savedCategories
            } else {
                categories = Category.loadSampleCategories()
            }
            
            
            navigationItem.leftBarButtonItem = editButtonItem
            
            //search controller proprties
            searchController.searchBar.delegate = self
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search by name"
            searchController.searchResultsUpdater = self
            
            
            //scope bars
            searchController.searchBar.showsScopeBar = true
            searchController.searchBar.scopeButtonTitles = ["All","Expense","Income"]
            
    
            filteredCategories = categories
            


          
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
                return 1
            }
        

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
            //check if user is searching
            if (searchController.isActive) {
                //count the filtered categories list
                return filteredCategories.count
               
            } else if searchController.searchBar.selectedScopeButtonIndex == 1 || searchController.searchBar.selectedScopeButtonIndex == 2{
                //count the filtered categories list
                return filteredCategories.count
            }
            else {
                //count the original categories list
                return categories.count
            }
        }
            
        

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var category:Category
            
            //fetch model object to display
            if searchController.isActive{
                category=filteredCategories[indexPath.row]
               
            } else if searchController.searchBar.selectedScopeButtonIndex==1 || searchController.searchBar.selectedScopeButtonIndex==2 {
               category=filteredCategories[indexPath.row]
            }
            else{
               category=categories[indexPath.row]
            }
            

            //dequeue cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
         
            //content configuration
            var content = cell.defaultContentConfiguration()
            content.text = category.name
            content.image = category.icon
            cell.contentConfiguration = content
          

            //disclosure indicator accessory
            cell.accessoryType = .disclosureIndicator
            
            cell.showsReorderControl = true
             
            return cell
            
        }
        
        // title for header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchController.isActive {
            return ""
            //expense scope bar
        }else if searchController.searchBar.selectedScopeButtonIndex == 1 {
            return "Expenses"
            //income scope bar
        }else if searchController.searchBar.selectedScopeButtonIndex == 2 {
            return "Income"
        }else{
            //all scope bar
            return "All Categories"
        }
     
    }
    

        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            //delete row
            if editingStyle == .delete {
                if searchController.isActive{
                    self.categories.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                   
                } else if searchController.searchBar.selectedScopeButtonIndex==1 || searchController.searchBar.selectedScopeButtonIndex==2 {
                    self.categories.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                else{
                    self.categories.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
               
               
            }
        }
 
    //search results update
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButtton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButtton:scopeButtton)
        
    }
    
    //scope bar and filters
    func filterForSearchTextAndScopeButton(searchText:String, scopeButtton:String="All") {
        filteredCategories = categories.filter ( {
            category in let scopeMatch = ( scopeButtton == "All" || category.type.localizedCaseInsensitiveContains(scopeButtton))
            if (searchController.searchBar.text != ""){
                let searchTextMatch = category.name.localizedCaseInsensitiveContains(searchText)
                return scopeMatch && searchTextMatch
                
            }else{
                return scopeMatch
            }
        } )
        tableView.reloadData()
        
    }
    
    
    //add edit
    @IBSegueAction func addEditCategory(_ coder: NSCoder, sender: Any?) -> AddEditCategoryTableViewController? {
        var categoryToEdit:Category
            if let cell = sender as? UITableViewCell,
               let indexPath = tableView.indexPath(for: cell){
                //editing emoji
                if searchController.isActive{
                    categoryToEdit=filteredCategories[indexPath.row]
                   
                } else if searchController.searchBar.selectedScopeButtonIndex==1 || searchController.searchBar.selectedScopeButtonIndex==2 {
                    categoryToEdit=filteredCategories[indexPath.row]
                }
                else{
                    categoryToEdit = categories[indexPath.row]
                }
               
                
                return AddEditCategoryTableViewController(coder: coder, category: categoryToEdit )
            }else{
                //adding emoji
                return AddEditCategoryTableViewController(coder: coder, category: nil )
            }
    }
    
    //sabe emoji to tabke view and insert new row
    @IBAction func unwindToCategoryTableView(segue:UIStoryboardSegue){
        guard segue.identifier == "saveSegue" else {return}
        let sourceViewController = segue.source as! AddEditCategoryTableViewController
        
        if let category = sourceViewController.category {
            let newIndexPath = IndexPath(row: categories.count, section: 0)
            categories.append(category)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
  
        
    }
    
      

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


