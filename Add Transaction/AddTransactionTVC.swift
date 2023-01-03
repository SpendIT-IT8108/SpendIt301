//
//  AddTransactionTVC.swift
//  SpendIt301
//
//  Created by A'laa Alekri on 21/12/2022.
//

import UIKit

class AddTransactionTVC: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //INITIALIZERS
    init?(coder: NSCoder, transaction : Transaction?){
        self.transaction = transaction
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //CURRENT TRANSACTION OBJECT
    var transaction : Transaction?
    var category : Category?
    
    
    //user interface components (outlets and variables)
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var symbolImageView: UIImageView!
    @IBOutlet weak var categoryNameTextField: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var type: UISegmentedControl!
    @IBOutlet weak var transactionDate: UIDatePicker!
    @IBOutlet weak var attachmentImageView: UIImageView!
    @IBOutlet weak var intervalPopUpButton: UIButton!
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var endRepeatPopUpButton: UIButton!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var NotestextView: UITextView!
    @IBOutlet weak var repeatOption: UISwitch!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
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
        
        //check if in edit or add mode
        if let transaction = self.transaction {
            navigationBar.title = "Edit Transaction"
            category = transaction.category
            symbolImageView.image = category?.icon?.image
            amountTextField.text = String(format: "%.2f", transaction.amount)
            titleTextField.text = transaction.name
            transactionDate.date = transaction.date
            if transaction.category.type == "Expense" {
                type.selectedSegmentIndex = 0
            }
            else {
                type.selectedSegmentIndex = 1
            }
            if transaction.repeated {
                repeatOption.isOn = true
                // set interval
                if let menu = intervalPopUpButton.menu {
                    for item in menu.children {
                        if let action = item as? UIAction {
                            if action.title == transaction.repeatingInterval {
                                action.state = .on
                            }
                            else {
                                action.state = .off
                            }
                        }
                    }
                }
                
                fromDatePicker.date = transaction.repeatFrom!
                //if there is an end date
                if transaction.repeatUntil != nil {
                    //set the selected option in the menu to specific date
                    if let menu = endRepeatPopUpButton.menu {
                        for item in menu.children {
                            if let action = item as? UIAction {
                                if action.title == "Specific Date" {
                                    action.state = .on
                                }
                                else {
                                    action.state = .off
                                }
                            }
                        }
                    }
                    endDatePickerIsVisisble = true
                    endDatePicker.date = transaction.repeatUntil!
                }
                // if end date is nil
                else {
                    //set selected action to forever
                    if let menu = endRepeatPopUpButton.menu {
                        for item in menu.children {
                            if let action = item as? UIAction {
                                if action.title == "Forever" {
                                    action.state = .on
                                }
                                else {
                                    action.state = .off
                                }
                            }
                        }
                    }
                    
                }
            }
            
            attachmentImageView.image = transaction.attachment?.image
        }
        else {
            //set the default catgeory to the most tracked (temporarly first element for testing)
            navigationBar.title = "Add Transaction"
            category = Category.loadSampleCategories().first
            categoryNameTextField.text = self.category?.name
            symbolImageView.image = self.category?.icon?.image
        }
        
        updateSaveButton()
    }
    
    //creating popUpButtons
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
            UIAction(title:"Forever", state: .on, handler: optionClosure2), UIAction(title:"Specific Date", state: .off, handler: optionClosure2)])
        //let the button track the selection
        endRepeatPopUpButton.showsMenuAsPrimaryAction = true
        endRepeatPopUpButton.changesSelectionAsPrimaryAction = true
    }
    
    
    //update Save button to be enabled only when all data is provided
    func updateSaveButton(){
        let amount = amountTextField.text ?? ""
        let title = titleTextField.text ?? ""
        saveButton.isEnabled = !amount.isEmpty && !title.isEmpty
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButton()
    }
    
    
    // MARK: attachment process
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
    
    
    
    // MARK: Hide and Show Collapsed rows
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
    
    
    
    
    // MARK: - Navigation (Segues)
    
    
    @IBAction func cancelForm(_ sender: Any) {
        if self.transaction != nil {
            discardChanges()
        }
        else {
            performSegue(withIdentifier: "cancelAddUnwind", sender: self)
        }
    }
    
    func discardChanges() {
        let alertController = UIAlertController(title:
                                                    "Discard Changes", message: "Are you sure you want to discard any chnages that you have made?",
                                                preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel",
                                   style: .cancel, handler: nil )
        alertController.addAction(cancel)
        
        let discard = UIAlertAction(title: "Discard",
                                    style: .destructive, handler: {action in self.performSegue(withIdentifier: "cancelEditUnwind", sender: self.cancelButton)} )
        alertController.addAction(discard)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBSegueAction func editCategory(_ coder: NSCoder) -> UITableViewController? {
        let type = type.titleForSegment(at: type.selectedSegmentIndex)!
        return ChooseCategoryTVC(coder: coder, type: type)
    }
    /*
     @IBSegueAction func editCategory(_ coder: NSCoder) -> UITableViewController? {
     let type = type.titleForSegment(at: type.selectedSegmentIndex)!
     return ChooseCategoryTVC(coder: coder, type: type)
     }
     */
    //back from editing category
    @IBAction func unwindToAddForm(segue: UIStoryboardSegue){
        guard segue.identifier == "DoneUnwind",
              let sourceViewController = segue.source as? ChooseCategoryTVC else {return}
        //assign the category object recieved from the ChooseCategoryTVC to the current category
        self.category = sourceViewController.category
        categoryNameTextField.text = self.category?.name
        symbolImageView.image = category?.icon?.image
    }
    
    //collect data from fields and prepare for saving
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveUnwind" {
            //get the data from fields and create new object
            let amount = amountTextField.text!
            let doubleAmount = Double(amount)!
            let title = titleTextField.text!
            let date = transactionDate.date
            let repeatOption = repeatOption.isOn
            //define all optional values
            var interval : String? = nil
            var from : Date? = nil
            var endOption : String? = nil
            var endDate : Date? = nil
            var attachment : UIImage? = nil
            var notes : String? = nil
            //collect optional values
            if repeatOption {
                interval = intervalPopUpButton.menu?.selectedElements.first?.title
                from = fromDatePicker.date
                endOption = endRepeatPopUpButton.menu?.selectedElements.first?.title
                if endOption == "Specific Date" {
                    endDate = endDatePicker.date
                }
            }
            attachment = attachmentImageView.image
            notes = NotestextView.text
            //get the first category for testing only
            let cat = category
            //create new transaction instance
            transaction = Transaction(name: title, amount: doubleAmount, category: cat!, date: date, repeated: repeatOption, repeatingInterval: interval, repeatFrom: from, repeatUntil: endDate, note: notes, attachment: attachment)
            
            //requesting notification permission
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted{
                    self.scheduleNotifications()
                }
                
            }
            
        }
    }
    
    func scheduleNotifications(){
        
        UNUserNotificationCenter.current().getNotificationSettings{(settings) in
            if settings.authorizationStatus == .authorized{
                let content = UNMutableNotificationContent()
                content.title="Spend It"
                content.subtitle="Have you recorded your spending today?💲"
                content.sound = .default
                
                var date = DateComponents()
                date.calendar = Calendar.current
                date.hour = 19 //everyday @7pm aka 19
                date.minute = 0
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                
            }
        }
    }
}

