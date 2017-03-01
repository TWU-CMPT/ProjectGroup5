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
    
    // Send buttons:
    @IBOutlet weak var contact1BtnText: UIButton!


    
    // Contact name text:
    @IBOutlet weak var contact1Text: UILabel! // Debug: Trying to make the text change when I press a button

    

    // Actions:
    //******************

    @IBAction func contact1BtnPressed(_ sender: Any) {
        contact1Text.text = "Button pressed!"
    }
    

    
}
