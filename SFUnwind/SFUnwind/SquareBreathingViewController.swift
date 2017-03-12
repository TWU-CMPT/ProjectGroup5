//
// SquareBreathingController.swift - View Controller for the "Square Breathing" feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Berke Boz
// Contributing Programmers: Adam Badke
// Known issues: Timer does not stop when pages are changed, this won't be fixed until animation is implemented
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import UIKit



// Main SquareBreathing view controller object
class SquareBreathingViewController: UIViewController{
 
    // Buttons
    @IBOutlet weak var totalTimer: UILabel!
    @IBOutlet weak var sessionTimer: UILabel!
    
    // UI Timer Parameters
    var sessionTimeSeconds = 60                         //Set Seconds
    var sessionTimeMinute = 4                           //Set Minute
    var sessionTracker = Timer()
    var sesssionTrackerActive: Bool = false             //A boolean statement is used to keep track of the state of RE/START button. sesssionTrackerActive acts like On/Off button

    var totalTimerSeconds: Int = 0
    var totalTimerMinute: Int = 0

    
    // Called once when this object is first instanciated
    override func viewDidLoad() {
        super.viewDidLoad() // Call the super class
        
        // Load the timer data:
        var _ = loadSecondsTimer()
        var _ = loadMinutesTimer()
        
        // Format the timer output: Display the time correctly
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
        
        let customAnimation = Draw(frame: CGRect(x: 50, y: 110, width: 1000, height: 1000))   //Initialize a frame
        customAnimation.draw(CGRect(origin: CGPoint(x: 50, y: 50),size: CGSize(width: 0, height: 0))); //Draw the animation
        self.view.addSubview(customAnimation)
        
    }
    
    // Save the seconds value of the timer to the device
    func saveSecondsTimer(totalTimerSeconds: Int) -> Int{
        UserDefaults.standard.set(totalTimerSeconds, forKey: "totalSecs") //Set Seconds
        UserDefaults.standard.synchronize()
        return totalTimerSeconds
    }
    
    // Save the minutes value of the timer to the device
    func saveMinutesTimer(totalTimerMinute: Int) -> Int{
        UserDefaults.standard.set(totalTimerMinute, forKey: "totalMins")    //Set Minutes
        UserDefaults.standard.synchronize()
        return totalTimerMinute
    }
    
    // Load the seconds data from the device
    func loadSecondsTimer() -> Int{
        if let loadedSecs = UserDefaults.standard.value(forKey: "totalSecs") as? Int{    //Load seconds
            totalTimerSeconds = loadedSecs
        }
        return totalTimerSeconds
    }
    
    // Load the minutes data from the device
    func loadMinutesTimer() -> Int{
        if let loadedMins = UserDefaults.standard.value(forKey:  "totalMins") as? Int{    //Load minutes
            totalTimerMinute = loadedMins
            
        }
        return totalTimerMinute
    }
    
    // Handle the timer as it is being displayed on the screen:
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
    
    // Handle time control. Start/Restart the timer based on user input:
    @IBAction func restartButton(_ sender: Any) {               //Re/Start button

    sesssionTrackerActive = !(sesssionTrackerActive)            //Boolean statement acts like on/off button with reset functionality
        var _ = saveMinutesTimer(totalTimerMinute: totalTimerMinute)
        var _ = saveSecondsTimer(totalTimerSeconds:totalTimerSeconds)
        
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







