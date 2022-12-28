//
//  AddTransactionTVC.swift
//  SpendIt301
//
//  Created by A'laa Alekri on 21/12/2022.
//

import UIKit

class AddTransactionTVC: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //CURRENT TRANSACTION OBJECT
    var transaction : Transaction?
    var category : Category?
    
    //user interface components (outlets and variables)
    @IBOutlet weak var categorySymbol: UILabel!
    @IBOutlet weak var categoryNameTextField: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var type: UISegmentedControl!
    @IBOutlet weak var transactionDate: UIDatePicker!
    @IBOutlet weak var attachmentImageView: UIImageView!
    @IBOutlet weak var intervalPopUpButton: UIButton!
    @IBOutlet weak var endRepeatPopUpButton: UIButton!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var NotestextView: UITextView!
    @IBOutlet weak var repeatOption: UISwitch!
    var intervalIsVisible : Bool = false
    var startIsVisible : Bool = false
    var endIsVisible : Bool = false
    var noteSpaceIsVisible : Bool = false
    var attachmentIsVisible : Bool = false
    var endDatePickerIsVisisble : Bool = false {
        didSet {
            endDatePicker.isHidden = !endDatePickerIsVisisble
        }
    }

    //Index Pathes for the table view cells
    //first section
    let amountCellIndexPath = IndexPath(row: 0, section: 0)
    let titleCellIndexPath = IndexPath(row: 1, section: 0)
    let typeCellIndexPath = IndexPath(row: 2, section: 0)
    let dateCellIndexPath = IndexPath(row: 3, section: 0)
    //second section
    let repeatOptionCellIndexPath = IndexPath(row: 0, section:  1)
    let repeatIntervalCellIndexPath = IndexPath(row: 1, section: 1)
    let repeatStartCellIndexPath = IndexPath(row: 2, section: 1)
    let repeatEndCellIndexPath = IndexPath(row: 3, section: 1)
    let attachOptionCellIndexPath = IndexPath(row: 4, section: 1)
    let attachmentCellIndexPath = IndexPath(row: 5, section: 1)
    let notesOptionCellIndexPath = IndexPath(row: 6, section: 1)
    let notesSpaceeCllIndexPath = IndexPath(row: 7, section: 1)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        //creating a tap gesture recognizer for the attachment UIImage
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        attachmentImageView.addGestureRecognizer(tapGR)
        attachmentImageView.isUserInteractionEnabled = true
        
        //setup popUpButtons once page is loaded
        setupPopUpButton()
    }
    
    
    // MARK: function to create the popUpButtons (drop-down menues)
    func setupPopUpButton() {
        //first popUp Button (Repeating Interval)
        //specify the action to be taken after selection
        let optionClosure = {(action : UIAction) in print(action.title)}
        //add actions to select from as options to the popupButton
        intervalPopUpButton.menu = UIMenu(children : [
            UIAction(title:"Monthly", state: .on, handler: optionClosure),
            UIAction(title:"Weekly", state: .on, handler: optionClosure),
            UIAction(title:"Daily", state: .on, handler: optionClosure)])
        //let the button track the selection 
        intervalPopUpButton.showsMenuAsPrimaryAction = true
        intervalPopUpButton.changesSelectionAsPrimaryAction = true
        
        //Second popUp Button (End Reapet)
        let optionClosure2 = {(action : UIAction) in
            if action.title == "Specific Date"{
                self.endDatePickerIsVisisble = true}
            else {
                self.endDatePickerIsVisisble = false
            }
            //update table cell height
            self.tableView.beginUpdates()
            self.tableView.endUpdates() }
        //add actions to select from as options to the popupButton
        endRepeatPopUpButton.menu = UIMenu(children : [
            UIAction(title:"Forever", state: .on, handler: optionClosure2), UIAction(title:"Specific Date", state: .on, handler: optionClosure2)])
        //let the button track the selection
        endRepeatPopUpButton.showsMenuAsPrimaryAction = true
        endRepeatPopUpButton.changesSelectionAsPrimaryAction = true
    }
    
    
    
    // MARK: function with actions to perform when UIImage view is tapped on
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        let placeholderImage = UIImage(systemName: "photo.fill.on.rectangle.fill")
        if sender.state == .ended {
            //create alert controller of type action sheet
            let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
            
                let alertController = UIAlertController(title:
                   nil, message: nil,
                   preferredStyle: .actionSheet)
            //if there is an image attached by user, add a delete option
            if attachmentImageView.image != placeholderImage {
                let deleteAction = UIAlertAction(title: "Delete Photo",
                                                 style: .destructive, handler:  { action in self.attachmentImageView.image = placeholderImage} )
                alertController.addAction(deleteAction)
            }
            
            //add a cancel option
                let cancelAction = UIAlertAction(title: "Cancel",
                   style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
            
            //add taking a photo option that has camera as the source
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let cameraAction = UIAlertAction(title: "Take Photo",
                       style: .default, handler: { action in
                        imagePicker.sourceType = .camera
                        self.present(imagePicker, animated: true, completion: nil)
                    })
                    alertController.addAction(cameraAction)
                }
            
            //add choosing an existing photo option that has photo library as the source
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let existingPhotoAction = UIAlertAction(title: "Choose Existing",
                       style: .default, handler: { action in
                        imagePicker.sourceType = .photoLibrary
                        self.present(imagePicker, animated: true, completion: nil)
                    })
                    alertController.addAction(existingPhotoAction)
                }
            
            //present the action sheet
                alertController.popoverPresentationController?.sourceView = attachmentImageView
                present(alertController, animated: true, completion: nil)
            
        }
    }
 
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        attachmentImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
        @IBAction func repeatSwitchClicked(_ sender: UISwitch) {
            if sender.isOn {
                intervalIsVisible = true
                startIsVisible = true
                endIsVisible = true
            }
            else {
                intervalIsVisible = false
                startIsVisible = false
                endIsVisible = false
            }
            //intervalIsVisible.toggle()
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
        
        
        // MARK: Table View Overriden Functions
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath {
            case notesSpaceeCllIndexPath where noteSpaceIsVisible == false:
                return 0
            case notesSpaceeCllIndexPath where noteSpaceIsVisible == true:
                return 150
                
            case attachmentCellIndexPath where attachmentIsVisible == false:
                return 0
            case attachmentCellIndexPath where attachmentIsVisible == true:
                return 250
            
            case repeatIntervalCellIndexPath where intervalIsVisible == false:
                return 0
            case repeatIntervalCellIndexPath where intervalIsVisible == true:
                return 65
            case repeatStartCellIndexPath where startIsVisible == false:
                return 0
            case repeatStartCellIndexPath where startIsVisible == true:
                return 85
            case repeatEndCellIndexPath where endIsVisible == false:
                return 0
            case repeatEndCellIndexPath where (endIsVisible == true && endDatePickerIsVisisble == true ):
                return 130
            case repeatEndCellIndexPath where (endIsVisible == true && endDatePickerIsVisisble == false):
                return 65
            case amountCellIndexPath:
                return 150
            case titleCellIndexPath:
                return 55
            case typeCellIndexPath:
                return 55
            case dateCellIndexPath:
                return 55
            case repeatOptionCellIndexPath:
                return 55
            default:
                return UITableView.automaticDimension
            }
        }
        
        
        
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            switch indexPath {
            case repeatOptionCellIndexPath where repeatOption.isOn:
                //change the visisbility of its properties
                intervalIsVisible.toggle()
                startIsVisible.toggle()
                endIsVisible.toggle()
                //and hide all other sub-fields
                noteSpaceIsVisible = false
                attachmentIsVisible = false
            case notesOptionCellIndexPath:
                //change the visisbility of its properties
                noteSpaceIsVisible.toggle()
                //and hide all other sub-fields
                intervalIsVisible = false
                startIsVisible = false
                endIsVisible = false
                attachmentIsVisible = false
            case attachOptionCellIndexPath:
                //change the visisbility of its properties
                attachmentIsVisible.toggle()
                //and hide all other sub-fields
                intervalIsVisible = false
                startIsVisible = false
                endIsVisible = false
                noteSpaceIsVisible = false
            default:
                return
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

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

    
    // MARK: - Navigation (Segues)
    
    @IBAction func unwindToAddForm(segue: UIStoryboardSegue){
        guard segue.identifier == "DoneUnwind",
                let sourceViewController = segue.source as? ChooseCategoryTVC else {return}
        //assign the category object recieved from the ChooseCategoryTVC to the current category
        self.category = sourceViewController.category
        categoryNameTextField.text = self.category?.name
        categorySymbol.text = self.category?.symbol
        
    }
    

    @IBSegueAction func editCategory(_ coder: NSCoder) -> UITableViewController? {
        let type = type.titleForSegment(at: type.selectedSegmentIndex)!
        return ChooseCategoryTVC(coder: coder, type: type)
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        /*switch segue.identifier{
        case "editCategory":
           var type = type.titleForSegment(at: type.selectedSegmentIndex)
        default:
            return
        }*/
        // Pass the selected type to the new view controller.
        
        
    }
    

}
