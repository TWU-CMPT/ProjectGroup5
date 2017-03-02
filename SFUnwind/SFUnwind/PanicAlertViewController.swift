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
    
    
    
    
    // Alert file paths (constants):
    let alertFile01 = "alert01"
    let alertFile02 = "alert02"
    let alertFile03 = "alert03"
    let alertFile04 = "alert04"
    let alertFile05 = "alert05"
    
    // Send buttons:
    //@IBOutlet weak var contact1BtnText: UIButton!
    
    
    // Contact name text labels:
    @IBOutlet weak var contact1Text: UILabel! //
    
    // Actions:
    
    @IBAction func contact1BtnPressed(_ sender: Any) {
        contact1Text.text = "Button pressed!"
    }
    
    
    
    // Class methods:
    //********************
    
    // View load: Initialize the screen. Called once, when the view is initialized
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the contact label text:
        print("DEBUG: \(alertFile01) FILE CONTENTS:")
        
        var contact1TextValues = getStoredAlerts(filename: alertFile01) // Load alert01.txt to alert05.txt
        
        contact1TextValues?.forEach{ // Loop through each value and print it, if the values are not nil
            print($0)
        }
    }
    
    // Load any pre-saved alerts stored in txt file. Called once per alert
    // Return: An array of strings read line by line from the file
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
