//
// HelpViewController.swift - Help view Controller for all screens
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: All
// Contributing Programmers: All
// Known issues: 
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import Foundation

import UIKit


class HelpViewController: UIViewController {
    
    @IBAction func closeHelpScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // Called once the first time this view is displayed
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("DEBUG: Help screen viewDidLoad called!!!")
        
    }

} // End Help view controller
