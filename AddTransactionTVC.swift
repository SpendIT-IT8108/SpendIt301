//
//  AddTransactionTVC.swift
//  SpendIt301
//
//  Created by A'laa Alekri on 21/12/2022.
//

import UIKit

class AddTransactionTVC: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var NotestextView: UITextView!
    
    //repeat outlets and variables
    @IBOutlet weak var repeatOption: UISwitch!
    var intervalIsVisible : Bool = false
    var startIsVisible : Bool = false
    var endIsVisible : Bool = false
    
    
    var noteSpaceIsVisible : Bool = false
    
    var attachmentIsVisible : Bool = false
    
    @IBOutlet weak var attachmentImageView: UIImageView!
    
    
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
        
        //creating a tap gesture recognizer for the attachment UIImage to eb able to perform actions when it's tapped
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        attachmentImageView.addGestureRecognizer(tapGR)
        attachmentImageView.isUserInteractionEnabled = true
        
        
        //set end date after one month
        //endDatePicker.date = Calendar.current.date(byAdding: .month, value: 6, to: Date.now)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the  navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //function with actions to perform when UIImage view is tapped on
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            //create alert controller of type action sheet
            let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
            
                let alertController = UIAlertController(title:
                   nil, message: nil,
                   preferredStyle: .actionSheet)
            //if there is an image attached by user, add a delete option
            if !attachmentImageView.image!.isSymbolImage {
                let deleteAction = UIAlertAction(title: "Delete Photo",
                   style: .destructive, handler: nil)
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
                return 55
            case repeatStartCellIndexPath where startIsVisible == false:
                return 0
            case repeatStartCellIndexPath where startIsVisible == true:
                return 85
            case repeatEndCellIndexPath where endIsVisible == false:
                return 0
            case repeatEndCellIndexPath where endIsVisible == true:
                return 85
            case amountCellIndexPath:
                return 100
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
            case notesOptionCellIndexPath:
                noteSpaceIsVisible.toggle()
            case attachOptionCellIndexPath:
                attachmentIsVisible.toggle()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
