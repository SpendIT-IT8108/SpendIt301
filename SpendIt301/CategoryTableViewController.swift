
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
            categories = Category.loadCategories()!
            
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
           // populateMenu()


          
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
            content.image = category.icon?.image
            cell.contentConfiguration = content
            cell.showsReorderControl = true
          

            //disclosure indicator accessory
            cell.accessoryType = .disclosureIndicator
            

             
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
                deleteShowAlert(indexPath: indexPath)
               
            }
        }
    
    
    func deleteShowAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: "Are you sure you'd like to delete this Category", preferredStyle: .alert)

        // delete Action
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            //delete category
            if self.searchController.isActive{
                self.categories.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                Category.saveCategories(self.categories)
                
               
            } else if self.searchController.searchBar.selectedScopeButtonIndex==1 || self.searchController.searchBar.selectedScopeButtonIndex == 2 {
                self.filteredCategories.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                Category.saveCategories(self.categories)
            }
            else{
                self.categories.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                Category.saveCategories(self.categories)
            }
            
        }

        alert.addAction(deleteAction)

        // cancel action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
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
    
    @IBOutlet weak var sortButton: UIButton!
    
    @IBAction func sortButtonClicked(_ sender: Any) {
        populateButton()
    }
    //populate pop up button with actions
    func populateButton(){
        //sort A-Z
        sortButton.menu = UIMenu(children : [
            UIAction(title:"Sort A-Z", state: .on, handler: { action in
                self.categories.sort(by: {$0.name < $1.name})
                self.searchController.searchBar.selectedScopeButtonIndex = 0
                self.tableView.reloadData()
              }),
            //sort Z-A
            UIAction(title:"Sort Z-A", state: .on, handler: { action in
                self.categories.sort(by: {$0.name > $1.name})
                self.searchController.searchBar.selectedScopeButtonIndex = 0
                self.tableView.reloadData()
               
                
            }),
           ])
            sortButton.showsMenuAsPrimaryAction = true
        
            sortButton.changesSelectionAsPrimaryAction = true
        
       
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
    
    //save emoji to tabke view and insert new row
    @IBAction func unwindToCategoryTableView(segue:UIStoryboardSegue){
        guard segue.identifier == "saveSegue" ,
        let sourceViewController = segue.source as? AddEditCategoryTableViewController,
        let category = sourceViewController.category else { return }
        
        //unwind for editing
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            categories[selectedIndexPath.row] = category
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        //add new category
        }else{
            //calculate index path for the new row
            let newIndexPath = IndexPath(row: categories.count, section: 0)
            //add item
            categories.append(category)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        Category.saveCategories(categories)
        
        
    }
    
    
    func populateMenu(){
    navigationItem.leftBarButtonItem = .init(systemItem: .edit)
        navigationItem.leftBarButtonItem!.menu = UIMenu(children : [
        UIAction(title:"Sort A-Z", state: .on, handler: { action in
            self.categories.sort(by: {$0.name < $1.name})
            self.tableView.reloadData()
        }),
        UIAction(title:"Sort Z-A", state: .on, handler: { action in
            self.categories.sort(by: {$0.name > $1.name})
            self.tableView.reloadData()
            
        }),
        UIAction(title:"Default", state: .on, handler: { action in
            self.filteredCategories = self.categories
            self.tableView.reloadData()
            
        } )])
        navigationItem.leftBarButtonItem?.changesSelectionAsPrimaryAction = true
       // navigationItem.leftBarButtonItem.showsMenuAsPrimaryAction = true
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


