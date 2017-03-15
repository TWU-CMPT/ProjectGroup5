//
// PanicAlertPopupViewController.swift - Popup View Controller for the Panic Alert Feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Adam Badke #301310785
// Contributing Programmers:
// Known issues:
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import UIKit
import ContactsUI


// Popup class:
class PanicAlertPopupViewController: UIViewController, CNContactPickerDelegate, UITextViewDelegate {
    // Variables:
    //***********
    var recievedAlert: [String]? = []   // Passed by the PanicAlertViewController
    var recievedAlertIndex: Int = 0     // Passed by the PanicAlertViewController
    let alertFiles = ["alert01", "alert02", "alert03", "alert04", "alert05"] // Store the alert file names in a (constant) array, to allow easier iteration through each.    
    
    var newContactName: String = ""     // The contact name to display
    var newContactNumber: String = ""   // The contact number to use

    // UI Elements:
    //*************
    
    // Handle the cancel button:
    @IBAction func popupCancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // The currently selected contact name button:
    @IBOutlet weak var popupSelectContactBtn: UIButton!
    
    // The text input box:
    @IBOutlet weak var popupTextInput: UITextView!
    
    // Handle contact selection:
    @IBAction func popupSelectContactBtn(_ sender: Any) {
        
        let theContactView = CNContactPickerViewController()    // Create a CNContactPickerViewController object
        theContactView.delegate = self                          // Set the current class, which inherits from the CNContactPickerDelegate class, as the view's delegate
        
        // Restrict the information visible in the contact picker to names and mobile phone numbers
        theContactView.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        
        present(theContactView, animated:true, completion: nil) // Display the contact picker view within the current view, to allow the user to select a contact. Triggers the CNContactPickerDelegate protocol functions (below)
    }
    
    // Check the user has selected a contact name + number and input a message before allowing them to save
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "saveBtnSegue" && (newContactName == "" || newContactNumber == "" || popupTextInput.text == "" ) {
                return false
            }
        }
        return true
    }
    
    // Handle the transition back to the PanicAlertViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Handle transitions:
        if segue.destination is PanicAlertViewController {
            // Handle save button
            if segue.identifier == "saveBtnSegue" {
                    setStoredAlert(theName: newContactName, theNumber: newContactNumber, theMessage: popupTextInput.text)
            }
            // Handle delete btn
            else if segue.identifier == "deleteBtnSegue" {
                setStoredAlert(theName: "", theNumber: "", theMessage: "")
            }
        }
    }
    
    
    // Called once when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupTextInput.delegate = self
        
        // Insert the recieved alert into the UI:
        if recievedAlert == nil || (recievedAlert?.count)! < 3 { // Handle empty alerts (Create new)
            popupSelectContactBtn.setTitle("Select New Contact", for: .normal)
            popupTextInput.text = ""
            
        }
        else { // Handle pre-existing alerts (edit)
            newContactName = (recievedAlert?[0])!
            newContactNumber = (recievedAlert?[1])!
            
            popupSelectContactBtn.setTitle(recievedAlert?[0], for: .normal)
            popupTextInput.text = recievedAlert?[2]
        }
        
        // Add a gesture recognizer to detect if the users taps outside of the text input box:
        let dismissKB: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PanicAlertPopupViewController.closeKeyboard))
        view.addGestureRecognizer(dismissKB)
    }
    
    
    // Handle the user tapping outside of the text field
    func closeKeyboard() {
        view.endEditing(true)
    }

    // UITextView Delegate function: Catch newline characters, and close the keyboard:
    func textView(_ textView: UITextView, shouldChangeTextIn shouldChangeTextInRange: NSRange, replacementText: String) -> Bool {
        if(replacementText.isEqual("\n")) {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    // Update the UI when the user has made a new selection
    func updateUI() {
        popupSelectContactBtn.setTitle(newContactName, for: .normal)
    }


    // Save alert contact text data to a txt file. Called when creating/editing an alert
    // Argument: contactProperty - A CNContactProperty object, recieved from the CNContactPicker as selected by the user
    // Note: This function requires UI interaction and must be manually tested on a physical iOS device
    func setStoredAlert(theName: String, theNumber: String, theMessage: String){
    
        // Get the documents directory:
        if let theDocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        
            // Select the right filename
            var filename = String()
        
            switch recievedAlertIndex { // Use the recieved tracking variable to select the correct filename
            case 1:
                filename = alertFiles[0]
            case 2:
                filename = alertFiles[1]
            case 3:
                filename = alertFiles[2]
            case 4:
                filename = alertFiles[3]
            case 5:
                filename = alertFiles[4]
            default: // We should never reach this point
                filename = alertFiles[0] // Use the first entry as the default, just in case.
            }
        
            // Append the filename to the documents directory:
            let thePath = theDocumentsDirectory.appendingPathComponent(filename)
        
            // Write to the file
            do {
                var fileData: String
                if theName == "" && theNumber == "" && theMessage == "" {
                    fileData = ""
                }
                else {
                    fileData = theName + "\n" + theNumber + "\n" + theMessage // Assemble the extracted data for storage
                }
            
                // Update the alert file with the extracted information:
                try fileData.write(to: thePath, atomically: false, encoding: String.Encoding.utf8)
            
            }
            catch {
                //currentContact = 0 // Reset the tracker to the default value
                return
            }
        }    
    } // End file writing
    
    // Handle contact selection:
    public func contactPicker(_ picker: CNContactPickerViewController, didSelect theContactProperty: CNContactProperty){
        
        // Ensure the user has selected a phone number:
        if theContactProperty.key == CNContactPhoneNumbersKey {
            
            // Store the contact locally:
            //newContact = theContactProperty
            
            newContactName = theContactProperty.contact.givenName + " " + theContactProperty.contact.familyName
            newContactNumber = (theContactProperty.value as! CNPhoneNumber).stringValue
            
            // Update the UI
            updateUI()
        }
    }

} // End of class
