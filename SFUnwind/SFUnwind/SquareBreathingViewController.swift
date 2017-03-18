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

// Square Object (Contained by the main Square Breathing screen view controller)
class Draw: UIView {
    // Square visual code:
    //********************
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Draw the square on screen
    // Note: This is a visual UI element that must be checked manually
    override func draw(_ rect: CGRect)
    {
        self.backgroundColor = UIColor .clear           //Make backgound
        //Initialize Lines and Rectangles
        let lineLeft = UIGraphicsGetCurrentContext()
        let lineRight = UIGraphicsGetCurrentContext()
        let lineTop = UIGraphicsGetCurrentContext()
        let lineBot = UIGraphicsGetCurrentContext()
        let circleTopLeft = UIGraphicsGetCurrentContext()
        let circleTopRight = UIGraphicsGetCurrentContext()
        let circleBotLeft = UIGraphicsGetCurrentContext()
        let circleBotRight = UIGraphicsGetCurrentContext()

        let colorSpace = CGColorSpaceCreateDeviceRGB()  //Set color
        let components: [CGFloat] = [0.0, 0.0, 1.0, 1.0]//Set color
        let color = CGColor(colorSpace: colorSpace, components: components)
        
        lineLeft?.setLineWidth(4.0)                     //Adjust line width
        lineLeft?.setStrokeColor(color!)    //Set color
        lineLeft?.move(to: CGPoint(x: 40, y: 190))  //Move to coordinates
        lineLeft?.addLine(to: CGPoint(x: 40, y: 85))//Add line to given coordinates
        lineLeft?.strokePath()

        lineRight?.setLineWidth(4.0)//Adjust line width
        lineRight?.setStrokeColor(color!)//Set color
        lineRight?.move(to: CGPoint(x: 180, y: 190))
        lineRight?.addLine(to: CGPoint(x: 180, y: 85))  //Move to coordinates
        lineRight?.strokePath()//Add line to given coordinates
        
        lineTop?.setLineWidth(4.0)//Adjust line width
        lineTop?.setStrokeColor(color!)//Set color
        lineTop?.move(to: CGPoint(x: 67, y: 65))
        lineTop?.addLine(to: CGPoint(x: 150, y: 65))  //Move to coordinates
        lineTop?.strokePath()//Add line to given coordinates
        
        lineBot?.setLineWidth(4.0)//Adjust line width
        lineBot?.setStrokeColor(color!)//Set color
        lineBot?.move(to: CGPoint(x: 67, y: 205))
        lineBot?.addLine(to: CGPoint(x: 154, y: 205))  //Move to coordinates
        lineBot?.strokePath()//Add line to given coordinates
        
        circleTopLeft?.saveGState()
        circleTopLeft?.setLineWidth(4.0)//Adjust line width
        circleTopLeft?.setStrokeColor(UIColor.blue.cgColor)//Set color
        let rectangle = CGRect(x: 10,y: 25,width: 60,height: 60)//Set coordinates
        circleTopLeft?.addEllipse(in: rectangle)
        circleTopLeft?.strokePath()//Add line to given coordinates

        circleTopRight?.saveGState()
        circleTopRight?.setLineWidth(4.0)//Adjust line width
        circleTopRight?.setStrokeColor(UIColor.blue.cgColor)//Set color
        let rectangle2 = CGRect(x: 150,y: 25,width: 60,height: 60)//Set coordinates
        circleTopRight?.addEllipse(in: rectangle2)
        circleTopRight?.strokePath()//Add line to given coordinates

        circleBotLeft?.saveGState()
        circleBotLeft?.setLineWidth(4.0)//Adjust line width
        circleBotLeft?.setStrokeColor(UIColor.blue.cgColor)//Set color
        let rectangle3 = CGRect(x: 10,y: 190,width: 60,height: 60)//Set coordinates
        circleBotLeft?.addEllipse(in: rectangle3)
        circleBotLeft?.strokePath()//Add line to given coordinates

        circleBotRight?.saveGState()
        circleBotRight?.setLineWidth(4.0)//Adjust line width
        circleBotRight?.setStrokeColor(UIColor.blue.cgColor)//Set color
        let rectangle4 = CGRect(x: 150,y: 190,width: 60,height: 60)//Set coordinates
        circleBotRight?.addEllipse(in: rectangle4)
        circleBotRight?.strokePath()//Add line to given coordinates
    }
}

// Main SquareBreathing view controller object
class SquareBreathingViewController: UIViewController{
 
    // Buttons
    @IBOutlet weak var totalTimer: UILabel!
    @IBOutlet weak var sessionTimer: UILabel!
    
    // UI Timer Parameters
    var sessionTimeSeconds = 60                         //Set Seconds
    var sessionTimeMinute = 4                           // Set Minute
    var sessionTracker = Timer()
    var sesssionTrackerActive: Bool = false             //A boolean statement is used to keep track of the state of RE/START button. sesssionTrackerActive acts like On/Off button

    var totalTimerSeconds: Int = 0
    var totalTimerMinute: Int = 0

    
    // Called once when this object is first instanciated
    override func viewDidLoad() {
        super.viewDidLoad() // Call the super class
     
        
        squareOrderManager(currentCircle: 0).alpha = 0 // Set all images alpha to 0
        squareOrderManager(currentCircle: 1).alpha = 0
        squareOrderManager(currentCircle: 2).alpha = 0
        squareOrderManager(currentCircle: 3).alpha = 0
        
        
        
        
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
    
    // scaleAnimationManager calls all four steps of animation in order which are fadein, scalex2, scale to original and fade out. SquareOrderManager function is used to track the current image
    func scaleAnimationManager(){
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.squareOrderManager(currentCircle: self.circleOrderTracker).alpha = 1.0
        }, completion: nil)
        UIView.animate(withDuration: 2, delay: 1, options: .curveEaseOut, animations:{
            self.squareOrderManager(currentCircle: self.circleOrderTracker).transform = CGAffineTransform(scaleX: 2, y: 2)
        }, completion:nil)
        UIView.animate(withDuration: 2, delay: 3.2, options: .curveEaseOut, animations:{
            self.squareOrderManager(currentCircle: self.circleOrderTracker).transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { (finished: Bool) -> Void in
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                self.squareOrderManager(currentCircle: self.circleOrderTracker-1).alpha = 0.0
            }, completion: nil)
        })
        circleOrderTracker+=1
    }
    

    // Tracks the current image with switch statement
    func squareOrderManager(currentCircle:Int) -> UIImageView{
        let orderNumber = currentCircle % 4

        switch orderNumber{
            
        case 0:
            return circleTRight
        case 1:
            return circleImage
        case 2:
            return circleBLeft
        case 3:
            return circleBRight
          
        default:
            print("Input variable out of scope")
            return circleImage
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







