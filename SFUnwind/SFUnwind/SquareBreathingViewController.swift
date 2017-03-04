//
//  SquareBreathingViewController.swift
//  SFUnwind
//
//  Created by A B on 2017-02-28.
//  Copyright © 2017 CMPT 276 - Group 5. All rights reserved.
//

import UIKit


// This is the main view controller for the SFUnwind "Square Breathing" feature
// Primary programmer: Berke
class SquareBreathingViewController: UIViewController{
 
    @IBOutlet weak var sessionTimer: UILabel!
    var sessionTimeSeconds = 0
    var sessionTimeMinute = 5
    var sessionTracker = Timer()
    var sesssionTrackerActive: Bool = false
    
    
    func sessionTimeManager(){
        
        sessionTimeSeconds-=1                                               //Decrement Seconds
        sessionTimer.text = "0" + String(sessionTimeMinute) + ":" + String(sessionTimeSeconds) ///Print time
        if(sessionTimeSeconds < 10){
            sessionTimer.text = "0" + String(sessionTimeMinute) + ":0" + String(sessionTimeSeconds)
            if(sessionTimeSeconds <= -1){
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
        if(sessionTimeSeconds == 0 && sessionTimeMinute != 0){
            sessionTimeMinute-=1
            sessionTimeSeconds = 60
        }
    
        else{                                               //If pressed again
            sessionTracker.invalidate()                         //Stop
            sessionTimeSeconds = 60                             //Reset
            sessionTimeMinute = 4                               //Reset
            sessionTimer.text = "05:00"                         //Print to screen
    
    
        }
    }
}
