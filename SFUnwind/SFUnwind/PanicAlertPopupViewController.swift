//
// PanicAlertPopupViewController.swift - Popup View Controller for the Panic Alert Feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Adam Badke #301310785
// Contributing Programmers: David Magaril #301274978
// Known issues:
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import UIKit
import ContactsUI
import QuartzCore


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
    // Note: This is a UI function, and must be tested manually using an iOS device
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            print(ident)
            if ident == "saveBtnSegue" && (newContactName == "" || newContactNumber == "" || popupTextInput.text == "" ) {
                return false
            }
        }

        return true
    }
    
    // Handle the transition back to the PanicAlertViewController
    // Note: This is a UI function, and must be tested manually using an iOS device
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Handle transitions:
        if let theDestination = segue.destination as? PanicAlertViewController {
            // Handle save button
            if segue.identifier == "saveBtnSegue" {
                    theDestination.setStoredAlert(theName: newContactName, theNumber: newContactNumber, theMessage: popupTextInput.text, recievedAlertIndex: recievedAlertIndex)
            }
            // Handle delete btn
            else if segue.identifier == "deleteBtnSegue" {
                theDestination.setStoredAlert(theName: "", theNumber: "", theMessage: "", recievedAlertIndex: recievedAlertIndex)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    // Cancel Button
    @IBOutlet weak var cancelButton: UIButton!
    // Delete Button
    @IBOutlet weak var deleteButton: UIButton!
    // Save Button
    @IBOutlet weak var saveButton: UIButton!
    
    // Called once when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cancelButton.layer.cornerRadius = 15
        self.deleteButton.layer.cornerRadius = 15
        self.saveButton.layer.cornerRadius = 15
        self.popupSelectContactBtn.layer.cornerRadius = 15
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
    // Note: This is a UI function, and must be tested manually using an iOS device
    func textView(_ textView: UITextView, shouldChangeTextIn shouldChangeTextInRange: NSRange, replacementText: String) -> Bool {
        if(replacementText.isEqual("\n")) {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    // Update the UI when the user has made a new selection
    // Note: This is a UI function, and must be tested manually using an iOS device
    func updateUI() {
        popupSelectContactBtn.setTitle(newContactName, for: .normal)
    }


    
    // Handle contact selection:
    // Note: This is a UI function, and must be tested manually using an iOS device
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
