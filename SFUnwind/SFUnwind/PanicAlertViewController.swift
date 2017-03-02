//
//  PanicAlertViewController.swift
//  SFUnwind
//
//  Created by A B on 2017-02-28.
//  Copyright © 2017 CMPT 276 - Group 5. All rights reserved.
//

import UIKit


// This is the main view controller for the SFUnwind "Panic Alert" feature
// Primary programmer: Adam
class PanicAlertViewController: UIViewController{
    
    // Properties:
    //******************
    
    // Panic Alert file names (constants). The name of each panic alert text file to be loaded:
    let alertFiles = ["alert01", "alert02", "alert03", "alert04", "alert05"] // Store the alert file names in a (constant) array, to allow easier iteration through each.
    
    // Send buttons:

    
    
    // Contact name text labels:
    @IBOutlet weak var contact1Text: UILabel! //
    @IBOutlet weak var contact2Text: UILabel!
    @IBOutlet weak var contact3Text: UILabel!
    @IBOutlet weak var contact4Text: UILabel!
    @IBOutlet weak var contact5Text: UILabel!
    
    // Actions:
    
    @IBAction func contact1BtnPressed(_ sender: Any) {
        contact1Text.text = "Button pressed!"
    }
    
    
    
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
                if (currentAlertText?.count)! < 3 { // Handle empty or malformed alert files: Set the label to blank
                    contact1Text.text = "Create" // Set the contact name text label to the first line in the alert file
                    
                } else{ // Otherwise, set the contact name text label to the first line in the alert file
                    contact1Text.text = currentAlertText?[0]
                }

            case 2: // Contact 2
                if (currentAlertText?.count)! < 3 { // Handle empty or malformed alert files: Set the label to blank
                    contact1Text.text = "Create" // Set the contact name text label to the first line in the alert file
                    
                } else{ // Otherwise, set the contact name text label to the first line in the alert file
                    contact2Text.text = currentAlertText?[0]
                }
                
            case 3: // Contact 3
                if (currentAlertText?.count)! < 3 { // Handle empty or malformed alert files: Set the label to blank
                    contact3Text.text = "Create" // Set the contact name text label to the first line in the alert file
                    
                } else{ // Otherwise, set the contact name text label to the first line in the alert file
                    contact3Text.text = currentAlertText?[0]
                }
                
            case 4: // Contact 4
                if (currentAlertText?.count)! < 3 { // Handle empty or malformed alert files: Set the label to blank
                    contact4Text.text = "Create" // Set the contact name text label to the first line in the alert file
                    
                } else{ // Otherwise, set the contact name text label to the first line in the alert file
                    contact4Text.text = currentAlertText?[0]
                }
                
            case 5: // Contact 5
                if (currentAlertText?.count)! < 3 { // Handle empty or malformed alert files: Set the label to blank
                    contact5Text.text = "Create" // Set the contact name text label to the first line in the alert file
                    
                } else{ // Otherwise, set the contact name text label to the first line in the alert file
                    contact5Text.text = currentAlertText?[0]
                }
                
            default: // We should never reach this point. Break.
                break
                
            }
        
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
