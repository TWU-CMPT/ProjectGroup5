//
// SquareBreathingController.swift - View Controller for the "Square Breathing" feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Berke Boz
// Contributing Programmers:
// Known issues: Timer does not stop when pages are changed, this won't be fixed until animation is implemented
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import UIKit


class Draw: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect)
    {
        self.backgroundColor = UIColor .clear           //Make backgound transparent
        
        
        let lineLeft = UIGraphicsGetCurrentContext()            //Initialize Lines and Rectangles
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

class SquareBreathingViewController: UIViewController{
 
    
    
    @IBOutlet weak var totalTimer: UILabel!
    @IBOutlet weak var sessionTimer: UILabel!
    
    var sessionTimeSeconds = 60                         //Set Seconds
    var sessionTimeMinute = 4                           //Set Minute
    var sessionTracker = Timer()
    var sesssionTrackerActive: Bool = false             //A boolean statement is used to keep track of the state of RE/START button. sesssionTrackerActive acts like On/Off button


    
    var totalTimerSeconds: Int = 0
    var totalTimerMinute: Int = 0


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var _ = loadSecondsTimer()
        var _ = loadMinutesTimer()
        
        //Statements for displaying the time correctly
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
    

    func saveSecondsTimer(totalTimerSeconds: Int) -> Int{
        UserDefaults.standard.set(totalTimerSeconds, forKey: "totalSecs") //Set Seconds
        UserDefaults.standard.synchronize()
        return totalTimerSeconds
    }

    func saveMinutesTimer(totalTimerMinute: Int) -> Int{
        UserDefaults.standard.set(totalTimerMinute, forKey: "totalMins")    //Set Minutes
        UserDefaults.standard.synchronize()
        return totalTimerMinute
    }
    
    
    func loadSecondsTimer() -> Int{
        if let loadedSecs = UserDefaults.standard.value(forKey: "totalSecs") as? Int{    //Load seconds
            totalTimerSeconds = loadedSecs
        }
        return totalTimerSeconds
    }
    
    func loadMinutesTimer() -> Int{
        if let loadedMins = UserDefaults.standard.value(forKey:  "totalMins") as? Int{    //Load minutes
            totalTimerMinute = loadedMins
            
        }
        return totalTimerMinute
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







