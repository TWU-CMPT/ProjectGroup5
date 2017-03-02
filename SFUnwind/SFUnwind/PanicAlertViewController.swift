//
//  PanicAlertViewController.swift
//  SFUnwind
//
//  Created by A B on 2017-02-28.
//  Copyright © 2017 CMPT 276 - Group 5. All rights reserved.
//

import UIKit
import ContactsUI

// This is the main view controller for the SFUnwind "Panic Alert" feature
// Primary programmer: Adam
class PanicAlertViewController: UIViewController, CNContactPickerDelegate {
    
    // Properties:
    //******************
    
    // Panic Alert file names (constants). The name of each panic alert text file to be loaded:
    let alertFiles = ["alert01", "alert02", "alert03", "alert04", "alert05"] // Store the alert file names in a (constant) array, to allow easier iteration through each.
    
    // UI buttons:
    
    // Contact 1: Create/send
    @IBOutlet weak var contact1CreateSendBtn: UIButton! // Outlet
    @IBAction func contact1CreateSendBtn(_ sender: UIButton) { // Action
        
    }
    
    // Contact 1: Edit
    @IBOutlet weak var contact1EditBtn: UIButton! // Outlet
    @IBAction func contact1EditBtn(_ sender: Any) { // Action
        let theContactView = CNContactPickerViewController()    // Create a CNContactPickerViewController object
        theContactView.delegate = self                          // Set the current class, which inherits from the CNContactPickerDelegate class, as the view's delegate
        present(theContactView, animated:true, completion: nil) // Display the view within the current view, to allow the user to select a contact
        
        // TO DO: Catch the information from the selected contact!!
        
        
    }
    
    
    // Contact 2: Create/send
    @IBOutlet weak var contact2CreateSendBtn: UIButton! // Outlet
    @IBAction func contact2CreateSendBtn(_ sender: Any) { // Action
    }
    // Contact 2: Edit
    @IBOutlet weak var contact2EditBtn: UIButton! // Outlet
    @IBAction func contact2EditBtn(_ sender: Any) { // Action
    }
    
    
    // Contact 3: Create/send
    @IBOutlet weak var contact3CreateSendBtn: UIButton! // Outlet
    @IBAction func contact3CreateSendBtn(_ sender: Any) { // Action
    }
    // Contact 3: Edit
    @IBOutlet weak var contact3EditBtn: UIButton! // Outlet
    @IBAction func contact3EditBtn(_ sender: Any) { // Action
    }
    
    
    // Contact 4: Create/send
    @IBOutlet weak var contact4CreateSendBtn: UIButton! // Outlet
    @IBAction func contact4CreateSendBtn(_ sender: Any) { // Action
    }
    // Contact 4: Edit
    @IBOutlet weak var contact4EditBtn: UIButton! // Outlet
    @IBAction func contact4EditBtn(_ sender: Any) { // Action
    }
    
    
    // Contact 5: Create/send
    @IBOutlet weak var contact5CreateSendBtn: UIButton! // Outlet
    @IBAction func contact5CreateSendBtn(_ sender: Any) { // Action
    }
    // Contact 5: Edit
    @IBOutlet weak var contact5EditBtn: UIButton! // Outlet
    @IBAction func contact5EditBtn(_ sender: Any) { // Action
    }
    
    
    
    // Contact name text labels:
    @IBOutlet weak var contact1Text: UILabel! // Contact 1
    @IBOutlet weak var contact2Text: UILabel! // Contact 2
    @IBOutlet weak var contact3Text: UILabel! // Contact 3
    @IBOutlet weak var contact4Text: UILabel! // Contact 4
    @IBOutlet weak var contact5Text: UILabel! // Contact 5
    
    

    
    
    
    // PanicAlertViewController Class methods/functions:
    //**************************************************
    
    // ViewDidLoad: This function is called once when the PanicAlertViewController.swift object is first initialized.
    // This function is used to trigger the various UI updates required to set up the screen
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call the alert list initialization function, which updates the UI elements with the correct text:
        initializeAlertList()
        

    }
    
    // Initialize the alert list. Loads the alert details from file, and sets up the UI to display the correct values
    func initializeAlertList() {
        
        // Set the contact label text:
        
        // Load each alert file:
        var contactNumber = 1
        for alert in alertFiles{ // Loop, loading each alert file listed in the array of alert filenames
            var currentAlertText = getStoredAlerts(filename: alert) // Load the current alert filename (ie. alert01.txt to alert05.txt), as an array of strings
            
            // Set the alert name text:
            switch contactNumber{
            case 1: // Contact 1
                if (currentAlertText?.count)! < 3 { // Handle empty or malformed alert files: Set the label to blank, and button to "create"
                    contact1Text.text = ""                            // Set the contact name text label to the first line in the alert file
                    contact1CreateSendBtn.setTitle("Create", for: .normal)    // Update the send/create button text
                    contact1EditBtn.isHidden = true
                    
                } else{ // Otherwise, set the contact name text label to the first line in the alert file
                    contact1Text.text = currentAlertText?[0]
                    contact1CreateSendBtn.setTitle("Send", for: .normal)
                    contact1EditBtn.isHidden = false
                }

            case 2: // Contact 2
                if (currentAlertText?.count)! < 3 { // Handle empty or malformed alert files: Set the label to blank
                    contact2Text.text = ""                            // Set the contact name text label to the first line in the alert file
                    contact2CreateSendBtn.setTitle("Create", for: .normal)    // Update the send/create button text
                    contact2EditBtn.isHidden = true
                    
                } else{ // Otherwise, set the contact name text label to the first line in the alert file
                    contact2Text.text = currentAlertText?[0]
                    contact2CreateSendBtn.setTitle("Send", for: .normal)
                    contact2EditBtn.isHidden = false
                }
                
            case 3: // Contact 3
                if (currentAlertText?.count)! < 3 { // Handle empty or malformed alert files: Set the label to blank
                    contact3Text.text = ""                            // Set the contact name text label to the first line in the alert file
                    contact3CreateSendBtn.setTitle("Create", for: .normal)    // Update the send/create button text
                    contact3EditBtn.isHidden = true
                    
                } else{ // Otherwise, set the contact name text label to the first line in the alert file
                    contact3Text.text = currentAlertText?[0]
                    contact3CreateSendBtn.setTitle("Send", for: .normal)
                    contact3EditBtn.isHidden = false
                }
                
            case 4: // Contact 4
                if (currentAlertText?.count)! < 3 { // Handle empty or malformed alert files: Set the label to blank
                    contact4Text.text = ""                            // Set the contact name text label to the first line in the alert file
                    contact4CreateSendBtn.setTitle("Create", for: .normal)    // Update the send/create button text
                    contact4EditBtn.isHidden = true
                    
                } else{ // Otherwise, set the contact name text label to the first line in the alert file
                    contact4Text.text = currentAlertText?[0]
                    contact4CreateSendBtn.setTitle("Send", for: .normal)
                    contact4EditBtn.isHidden = false
                }
                
            case 5: // Contact 5
                if (currentAlertText?.count)! < 3 { // Handle empty or malformed alert files: Set the label to blank
                    contact5Text.text = ""                            // Set the contact name text label to the first line in the alert file
                    contact5CreateSendBtn.setTitle("Create", for: .normal)    // Update the send/create button text
                     contact5EditBtn.isHidden = true
                    
                } else{ // Otherwise, set the contact name text label to the first line in the alert file
                    contact5Text.text = currentAlertText?[0]
                    contact5CreateSendBtn.setTitle("Send", for: .normal)
                    contact5EditBtn.isHidden = false
                }
                
            default: // We should never reach this point. Break.
                break
                
            }
            
            // TO DO :
            // Set edit buttons to myIBButton.hidden = true
        
//            // Debug: Spew the contents of the string array we recieved
//            print("DEBUG: \(alert) FILE CONTENTS:")
//            currentAlertText?.forEach{ // Loop through each value and print it, if the values are not nil
//                print($0)
//            }
            
            
            contactNumber += 1 // Increment the contact counter
        }// end for

    } // end initializeAlertList()
    
    // Load alert text data stored in a txt file. Called once per alert
    // Argument: filename - A string, containing the filename of the text file to be loaded. Note: Filename does NOT include the .txt extension, as this is passed as an argument to the iOS file manager bundle.
    // Return: An array of strings read line by line from the file, or nil if the file was empty
    func getStoredAlerts(filename: String) -> [String]? {
        // Attempt to open the file:
        guard let theFile = Bundle.main.path( forResource: filename, ofType: "txt", inDirectory: "PanicAlertFiles") else {
            return nil // Return nill if the file can't be found
        }
        
        do { // Extract the file contents, and return them as a split string array
            let fileContents = try String(contentsOfFile: theFile)
            return fileContents.components(separatedBy: "\n") // Return the file contents as an array, with each line as an element
        } catch _ as NSError { // Handle any exception: Return a nil if we have any issues
            return nil
        }
    }
    
    
} // End panic alert view controller class
