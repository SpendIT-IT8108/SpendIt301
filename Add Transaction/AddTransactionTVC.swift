//
//  AddTransactionTVC.swift
//  SpendIt301
//
//  Created by Kawthar Alakri on 21/12/2022.
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
    
    
    //storyboard outlets and variables
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
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var editLbl: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var repeatLbl: UILabel!
    @IBOutlet weak var repeatSentenceLbl: UILabel!
    @IBOutlet weak var repeatintervalLbl: UILabel!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var untilLbl: UILabel!
    @IBOutlet weak var attachementLbl: UILabel!
    @IBOutlet weak var attachDescLbl: UILabel!
    @IBOutlet weak var notesLbl: UILabel!
    
    @IBOutlet weak var notesDecLbl: UILabel!
    var dateIsVisible : Bool = true
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
        //localization
        titleTextField.placeholder = NSLocalizedString("transTitle", comment: "")
        typeLbl.text = NSLocalizedString("type", comment: "")
        editLbl.titleLabel?.text = NSLocalizedString("edit", comment: "")
        dateLbl.text = NSLocalizedString("date", comment: "")
        repeatLbl.text  = NSLocalizedString("repeat", comment: "")
        repeatSentenceLbl.text = NSLocalizedString("letyourbill", comment: "")
        repeatintervalLbl.text = NSLocalizedString("repeatInterval", comment: "")
        fromLbl.text = NSLocalizedString("from", comment: "")
        untilLbl.text = NSLocalizedString("until", comment: "")
        attachementLbl.text = NSLocalizedString("attachment", comment: "")
        attachDescLbl.text = NSLocalizedString("taptoattach", comment: "")
        notesLbl.text = NSLocalizedString("notes", comment: "")
        notesDecLbl.text = NSLocalizedString("notesdec", comment: "")
        
        
        //creating a tap gesture recognizer for the attachment UIImage
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        attachmentImageView.addGestureRecognizer(tapGR)
        attachmentImageView.isUserInteractionEnabled = true
        
        //setup popUpButtons once page is loaded
        setupPopUpButton()
        
        //check if in edit or add mode
        if let transaction = self.transaction {
            //present transaction data to be edited
            navigationBar.title = "Edit Transaction"
            category = transaction.category
            categoryNameTextField.text = category?.name
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
            if let attachment = transaction.attachment?.image {
              attachmentImageView.image = attachment
            }
            if let notes = transaction.note {
                NotestextView.text = notes
            }
            
            //get repeat details if repeated
            if transaction.repeated {
                repeatOption.isOn = true
                //if not the original transaction or repeat has ended(no nextDate), disable editing repeat
                if transaction.nextDate == nil {
                    repeatOption.isEnabled = false
                }
                else {
                    //if original, let user edit the end option only
                    repeatOption.isEnabled = true
                    intervalPopUpButton.isUserInteractionEnabled = false
                    fromDatePicker.isUserInteractionEnabled = false
                }
                
                //set interval
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
                // if there is no end date
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
            
           
            
        }
        else {
            //set the default catgeory
            navigationBar.title = "Add Transaction"
            category = defaultCategory(type: "Expense")
            categoryNameTextField.text = self.category?.name
            symbolImageView.image = self.category?.icon?.image
        }
        
        //update save button by validating the fields
        updateSaveButton()
        
    }
    
    //creating pop-up Buttons for the repeat data
    func setupPopUpButton() {
    //first popUp Button (Repeating Interval)
        //specify the action to be taken after selection
        let setDate = {(action : UIAction) in self.setMinimumDate(interval:action.title, startDate: self.fromDatePicker.date) }
        //add actions to select from as options to the popupButton
        intervalPopUpButton.menu = UIMenu(children : [
            UIAction(title:"Monthly", state: .on, handler: setDate),
            UIAction(title:"Weekly", state: .off, handler: setDate),
            UIAction(title:"Daily", state: .off, handler: setDate)])
        //let the button track the selection
        intervalPopUpButton.showsMenuAsPrimaryAction = true
        intervalPopUpButton.changesSelectionAsPrimaryAction = true
        
        
    //Second popUp Button (End Reapet)
        let controlDatePicker = {(action : UIAction) in
            if action.title == "Specific Date"{
                self.endDatePickerIsVisisble = true
                let interval
                = self.intervalPopUpButton.menu?.selectedElements.first?.title ?? "Monthly"
                self.setMinimumDate(interval: interval, startDate: self.fromDatePicker.date)
            }
            else {
                self.endDatePickerIsVisisble = false
            }
            //update table cell height
            self.tableView.beginUpdates()
            self.tableView.endUpdates() }
        //add actions to select from as options to the popupButton
        endRepeatPopUpButton.menu = UIMenu(children : [
            UIAction(title:"Forever", state: .on, handler: controlDatePicker), UIAction(title:"Specific Date", state: .off, handler: controlDatePicker)])
        //let the button track the selection
        endRepeatPopUpButton.showsMenuAsPrimaryAction = true
        endRepeatPopUpButton.changesSelectionAsPrimaryAction = true
    }
    
    //update Save button to be enabled only when all required data is provided
    func updateSaveButton(){
        let amount = amountTextField.text ?? ""
        let title = titleTextField.text ?? ""
        saveButton.isEnabled = !amount.isEmpty && !title.isEmpty
    }
    
    //update the save while text fields are changing
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButton()
    }
    
    //update end date picker to avoid invalid input
    func setMinimumDate(interval:String, startDate: Date) {
        switch interval {
        case "Weekly":
            endDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
        case "Monthly" :
            endDatePicker.minimumDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
        case "Daily":
            endDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        default:
           return
        }
    }
    
    //change category once type is changed
    @IBAction func typeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            category = defaultCategory(type: "Expense")
        }else {
            category = defaultCategory(type: "Income")
        }
        categoryNameTextField.text = category?.name
        symbolImageView.image = category?.icon?.image
    }
    
    //get default element of each type
    func defaultCategory(type: String) -> Category {
        var list : [Category] = []
        for cat in Category.loadSampleCategories() {
            if cat.type == type {
                list.append(cat)
            }
        }
        return list.first!
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
    
    //get the selected image from the imagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        attachmentImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Hide and Show Collapsed rows
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case notesSpaceeCllIndexPath where noteSpaceIsVisible == false:
           // tableView.cellForRow(at: notesOptionCellIndexPath).se
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
        case dateCellIndexPath where dateIsVisible == true :
            return 55
        case dateCellIndexPath where dateIsVisible == false :
            return 0
        case repeatOptionCellIndexPath:
            return 55
        default:
            return UITableView.automaticDimension
        }
    }

    @IBAction func repeatSwitchClicked(_ sender: UISwitch) {
        if sender.isOn {
            intervalIsVisible = true
            startIsVisible = true
            endIsVisible = true
            dateIsVisible = false
        }
        else {
            intervalIsVisible = false
            startIsVisible = false
            endIsVisible = false
            dateIsVisible = true
        }
        //intervalIsVisible.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case repeatOptionCellIndexPath where repeatOption.isOn && repeatOption.isEnabled:
            //change the visisbility of its properties
            intervalIsVisible.toggle()
            startIsVisible.toggle()
            endIsVisible.toggle()
            //and hide all other sub-fields
            noteSpaceIsVisible = false
            attachmentIsVisible = false
        case repeatOptionCellIndexPath where repeatOption.isOn && !repeatOption.isEnabled:
            //show message box to let user edit repeat details in the original transaction
            editRepeatedAlert()

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
    

    //to show alert when user try to edit repeat info
    func editRepeatedAlert() {
        //restrict editing for repeated that already ended
        if let endDate = transaction?.repeatUntil {
            if endDate < Date() {
                let alertController = UIAlertController(title:
                                                            "Restricted Action", message: "You can't manage repeat preferences for repeated transactions that has already ended.",
                                                        preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK",
                                       style: .default, handler: nil )
                alertController.addAction(OK)
                present(alertController, animated: true, completion: nil)
            }
            else {
                let alertController = UIAlertController(title:
                                                            "Restricted Action", message: "You can't manage repeat on automatic records. Redirect you to the original transaction?",
                                                        preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Cancel",
                                           style: .cancel, handler: nil )
                alertController.addAction(cancel)
                
                let redirect = UIAlertAction(title: "Redirect",
                                             style: .default, handler: {action in
            
                    //get the original record and reload the form with its data
                    for tran in Transaction.loadTransactions() {
                        if tran.name == self.transaction?.name && tran.nextDate != nil {
                            self.transaction = tran
                            self.viewWillAppear(true)
                            self.viewDidLoad()
                        }
                    }
               
                } )
                
                alertController.addAction(redirect)
                
                present(alertController, animated: true, completion: nil)
            }
        }

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
            let repeatOption = repeatOption.isOn
            //define all optional values
            var date : Date
            var interval : String? = nil
            var from : Date? = nil
            var endOption : String? = nil
            var endDate : Date? = nil
            var nextDate : Date? = nil
            var attachment : UIImage? = nil
            var notes : String? = nil
            
        //collect optional values
            
            //repeated transaction data saving
            if repeatOption {
                interval = intervalPopUpButton.menu?.selectedElements.first?.title
                from = fromDatePicker.date
                endOption = endRepeatPopUpButton.menu?.selectedElements.first?.title
                if endOption == "Specific Date" {
                    endDate = endDatePicker.date
                }
                
                //saving data for edited repeated
                if let transaction = self.transaction {
                    //original record, don't overrite the nextDate
                    date = transactionDate.date
                    if let next = transaction.nextDate {
                        //only if it has end date, cancel next transaction if end date has changed to be before
                        if next > endDatePicker.date && endOption == "Specific Date" {
                            nextDate = nil
                        }
                        else {
                            //otherwise, keep it the same
                            nextDate = next
                        }
                    }
                    //automatic record, valid for date changing but not for nextDate
                    else {
                        date = transactionDate.date
                        nextDate = nil
                    }
                }
                //saving data for added repeated
                else {
                    //just added, set the transaction date = starting date, and calculate next based on it
                    date = fromDatePicker.date
                    nextDate = Transaction.calculateNext(interval: interval!, nextTime: date, endDate: endDate)
                }
                
            }
            //if not repeated collect the date from picker
            else {
               date = transactionDate.date
            }
            
            //save the attachment image only if it has been chnaged from the placeholder
            if attachmentImageView.image != UIImage(systemName: "photo.fill.on.rectangle.fill") {
                attachment = attachmentImageView.image
            }
            notes = NotestextView.text
            
            //get the selected category
            let cat = category
            
            //create new transaction instance
            transaction = Transaction(name: title, amount: doubleAmount, category: cat!, date: date, repeated: repeatOption, repeatingInterval: interval, repeatFrom: from, repeatUntil: endDate, note: notes, attachment: attachment, nextDate: nextDate)
            
            

            //requesting notification permission
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted{
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    self.scheduleNotifications()
                    self.checkingLimit()
                    
                }
                
            }
            
        }
    }
    
    
    //MARK: Notifications
    func scheduleNotifications(){
        
        
                let content = UNMutableNotificationContent()
                content.title="Spend It"
                content.subtitle="Have you recorded your spending today?💲"
                content.sound = .default
                
                var date = DateComponents()
                date.calendar = Calendar.current
                date.hour = 20 //everyday @8pm aka 20
                date.minute = 0
                date.second = 00
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                
            
        
    }
    
    func checkingLimit(){
        var sum = 0.0
        var reachedExpenseLimmit=false
            var reachedIncomeLimmit=false
        
        DispatchQueue.main.async {
            //get the amount entered
            if let count: Double = Double(self.amountTextField.text!){
          
            //get the name of the category
            let name = self.category!.name
            //search the transactions for the amount
            let trans =  Transaction.loadTransactions().filter({
                transItem in
                transItem.category.name.localizedStandardContains(name)
            })
         
          trans.forEach({
              //calculate sum
                transItem in
              sum = sum + transItem.amount
              
              
              if let limit = transItem.category.spendingLimit {
              //if the sum is greater than the limit
                  if (Double)(limit) < sum+count {
                     if transItem.category.type=="Expense" {
                          reachedExpenseLimmit=true
                      }
                      else{
                          reachedIncomeLimmit=true
                      }
                    
                  }
            }
          })
            //notification for expenses
            if reachedExpenseLimmit{
               
                let content = UNMutableNotificationContent()
                content.subtitle="You have reached \(self.category!.name)'s limit 🤑"
                    content.sound = .default


                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(5), repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }
                
                //notification for income
                if reachedIncomeLimmit {
                    let content = UNMutableNotificationContent()
                    content.subtitle="Cheers, you have reached \(self.category!.name)'s goal 💰"
                        content.sound = .default


                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(5), repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request)
                    
                }
              
          }
            
            
            }
          
            
            }
             
      
}

