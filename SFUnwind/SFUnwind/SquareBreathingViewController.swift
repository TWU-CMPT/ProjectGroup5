//
// SquareBreathingController.swift - View Controller for the "Square Breathing" feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Berke Boz
// Contributing Programmers:
// Known issues: ???????
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import UIKit

class SquareBreathingViewController: UIViewController{
 
    @IBOutlet weak var sessionTimer: UILabel!
    
    
    var sessionTimeSeconds = 0
    var sessionTimeMinute = 5
    var sessionTracker = Timer()
    var sesssionTrackerActive: Bool = false             //A boolean statement is used to keep track of the state of RE/START button. sesssionTrackerActive acts like On/Off button
    
    
    
    func sessionTimeManager(){
        
        sessionTimeSeconds-=1                                               //Decrement Seconds
        sessionTimer.text = "0" + String(sessionTimeMinute) + ":" + String(sessionTimeSeconds) ///Print time
        if(sessionTimeSeconds < 10){                                        //Keeps XX:XX format
            sessionTimer.text = "0" + String(sessionTimeMinute) + ":0" + String(sessionTimeSeconds)
            if(sessionTimeSeconds <= -1){                                   //Detects if timer is finished
                sessionTracker.invalidate()
                sessionTimer.text = "FINISHED"
            }
        }
        else if(sessionTimeSeconds == 60){                                   //If a min has passed
            sessionTimer.text = "0" + String(sessionTimeMinute)+":00"
        }
    }
    
    
    
    @IBAction func restartButton(_ sender: Any) {
    sessionTracker = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SquareBreathingViewController.sessionTimeManager), userInfo: nil, repeats: true)
        if(sessionTimeSeconds == 0 && sessionTimeMinute != 0){                 //If Remaining mins != 0
            sessionTimeMinute-=1                                               //Decrement Minutes
            sessionTimeSeconds = 60                                            //Decrement Seconds
        }
    
        else{                                               //If RESETED
            sessionTracker.invalidate()                         //Stop
            sessionTimeSeconds = 60                             //Reset
            sessionTimeMinute = 4                               //Reset
            sessionTimer.text = "05:00"                         //Print to screen
    
    
        }
    }
}

//Known issues
//
//
//      - Timer doesn't stop when page is changed.
//      - There is a slight latency when RE/START button is pressed on VM, must be tested in an actual iPhone.
//
//
//

//Missing Features
//
//      - Main Timer is not implemented yet
//      - Main Timer file I/O not implemented yet
//
//
//
//
