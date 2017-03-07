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
    
    @IBOutlet weak var totalTimer: UILabel!
    
    var sessionTimeSeconds = 60                         //Set Seconds
    var sessionTimeMinute = 4                           //Set Minute
    var sessionTracker = Timer()
    var sesssionTrackerActive: Bool = false             //A boolean statement is used to keep track of the state of RE/START button. sesssionTrackerActive acts like On/Off button

    
    
    var totalTimerSeconds: Int = 0
    var totalTimerMinute: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
                                                //totalTimer.text = "00:00"
        loadTimer()
        //print(totalTimer)
        if(totalTimerMinute < 10 && totalTimerSeconds < 10 ){
            totalTimer.text = "0" + String(totalTimerMinute) + ":0" + String(totalTimerSeconds)
        }
        else if(totalTimerMinute < 10 && totalTimerSeconds >= 10){
            totalTimer.text = "0" + String(totalTimerMinute) + ":" + String(totalTimerSeconds)
        }
        
        else if(totalTimerMinute >= 10 && totalTimerSeconds < 10){
            totalTimer.text = String(totalTimerMinute) + ":0" + String(totalTimerSeconds)
        }
        
        else if(totalTimerMinute >= 10 && totalTimerSeconds >= 10){
            totalTimer.text = String(totalTimerMinute) + ":" + String(totalTimerSeconds)
        }
    }
    

    func saveTimer(){
        UserDefaults.standard.set(totalTimerMinute, forKey: "totalMins")
        UserDefaults.standard.set(totalTimerSeconds, forKey: "totalSecs")
        UserDefaults.standard.synchronize()

    
    }
    
    func loadTimer(){
        if let loadedMins = UserDefaults.standard.value(forKey:  "totalMins") as? Int{
            totalTimerMinute = loadedMins

        }
        if let loadedSecs = UserDefaults.standard.value(forKey: "totalSecs") as? Int{
            totalTimerSeconds = loadedSecs

        }
    }
    
    func timeManager(){
        
        sessionTimeSeconds-=1                                                  //Decrement Seconds
        totalTimerSeconds+=1                                                   //Increment Seconds
        

        if(sessionTimeSeconds == 0 && sessionTimeMinute != 0){                 //If Remaining mins != 0
            sessionTimer.text = "0" + String(sessionTimeMinute)+":00"
            sessionTimeMinute-=1                                               //Decrement Minutes
            sessionTimeSeconds = 60                                            //Decrement Seconds
        }
        
        else if(sessionTimeSeconds < 10 && sessionTimeMinute == 0){             //If no mins left
            sessionTimer.text = "0" + String(sessionTimeMinute) + ":0" + String(sessionTimeSeconds)

            if(sessionTimeSeconds <= -1){                                       //Detects if timer is finished
                sessionTracker.invalidate()                                     //Stops the timer
                sessionTimer.text = "FINISHED"

            }
        }
        else if(sessionTimeSeconds < 10 && sessionTimeMinute != 0 ){            //If Session Seconds is a one digit number
                sessionTimer.text = "0" + String(sessionTimeMinute) + ":0" + String(sessionTimeSeconds)
        }
        else{                                                                   //Casually prints time
            sessionTimer.text = "0" + String(sessionTimeMinute) + ":" + String(sessionTimeSeconds)
        }
            
            
        
        

        

        if(totalTimerSeconds == 60){                                            //Set 60 secs to 0 secs and increment min
            totalTimerSeconds = 0
            totalTimerMinute += 1
        }
        if(totalTimerMinute < 10 && totalTimerSeconds < 10){                    //If both Min&&Sec are one digit
            totalTimer.text = "0" + String(totalTimerMinute) + ":0" + String(totalTimerSeconds)     //Keeps XX:XX format
        }
        else if(totalTimerMinute < 10 && totalTimerSeconds >= 10){              //If min is one digit number
            totalTimer.text = "0" + String(totalTimerMinute) + ":" + String(totalTimerSeconds)      //Keeps XX:XX format
        }
        else{                                                                   //If both Min&&Sec aren't one digit
            totalTimer.text = String(totalTimerMinute) + ":" + String(totalTimerSeconds)

        }
   
    }
    
    
    
    @IBAction func restartButton(_ sender: Any) {               //Re/Start button
        
    sesssionTrackerActive = !(sesssionTrackerActive)            //Boolean statement acts like on/off button with reset functionality
    saveTimer()
        if(sesssionTrackerActive == true){
            sessionTracker = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SquareBreathingViewController.timeManager), userInfo: nil, repeats: true)  //Call timeManager() once in every second
            
        }
        else{
            
            
            
            sessionTracker.invalidate()                         //Stops timer
            sessionTimeSeconds = 60                             //Reset
            sessionTimeMinute = 4                               //Reset
            sessionTimer.text = "05:00"                         //Print to screen
        }

    }
    
    
    
}





//Known issues
//
//
//      - Timer doesn't stop when page is changed.          Boolean Statement added for fix which will be suggested to be used on other pages
//
//
//      - There is a slight latency when RE/START button is pressed on VM, must be tested in an actual iPhone.
//
//
//

