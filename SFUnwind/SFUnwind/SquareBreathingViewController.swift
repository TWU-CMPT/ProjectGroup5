//
// SquareBreathingController.swift - View Controller for the "Square Breathing" feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Berke Boz
// Contributing Programmers: Adam Badke
// Known issues: -
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import UIKit
import AudioToolbox


// Main SquareBreathing view controller object
class SquareBreathingViewController: UIViewController{
 
    // Buttons
    @IBOutlet weak var totalTimer: UILabel!
    @IBOutlet weak var sessionTimer: UILabel!
    

    
    // UI Timer Parameters
    var sessionTimeSeconds = 60                         //Set Seconds
    var sessionTimeMinute = 4                           //Set Minute
    var sessionTracker : Timer?
    var animationTimer : Timer?
    var sesssionTrackerActive: Bool = false             //A boolean statement is used to keep track of the state of RE/START button. sesssionTrackerActive acts like On/Off button

    var totalTimerSeconds: Int = 0
    var totalTimerMinute: Int = 0
    var circleOrderTracker: Int = 1
    var isAnimating = false
    
    var totalSessions:Int = 0
    var minSession: Double = 0
    var averageSession: Double = 1
    var maxSession: Double = 0
    var pathToAff: String? = nil
    var arrayOfMantra = [String]()
    var totalMantras: Int = 0
    var mantraAvailable = false
    var hasVisited = false
    
    var statsPageOpen: Bool = false
    
    var sessionStatistics: String = ""
    var sessionSecs:Double = 0
    
    @IBOutlet weak var topTitle: UILabel!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Present for first
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if(sesssionTrackerActive == true || reStartButtonText.currentTitle == "Stop"){
            restartButton(UIButton())
        }
        if(self.hasVisited == false){
            print("VISITED")
            let firstUse = UIAlertController(title: "Welcome to SFUnwind", message: "Click on the help button on the top right on any feature to obtain info.", preferredStyle: .alert)
            let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            firstUse.addAction(theOkAction)
            self.present(firstUse, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "firstTime")
            self.hasVisited = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Present First Use
        print("WP " + String(self.hasVisited))
        sesssionTrackerActive = false
        loadStatistics()
        let totalSec = loadSecondsTimer()
        let totalMin = loadMinutesTimer()
        var totalSecString = String(totalSec)
        if(totalSec < 10){
            totalSecString = "0" + totalSecString
        }
        var totalMinString = String(totalMin)
        if(totalMin < 10){
            totalMinString = "0" + totalMinString
        }
        totalTimer.text = totalMinString + ":" + totalSecString    //Keeps XX:XX format
        // Set affirmation appropiately
        let desiredFile = "affirmations.txt"
        let thePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let theURL = NSURL(fileURLWithPath: thePath)
        pathToAff = theURL.appendingPathComponent(desiredFile)?.path
        
        let theFileManager = FileManager.default
        if theFileManager.fileExists(atPath: self.pathToAff!){
            
            do {
                let getText = try String(contentsOfFile: self.pathToAff!)
                let tempArray = getText.components(separatedBy: "\n")
                if(tempArray[0] != ""){
                    self.arrayOfMantra = getText.components(separatedBy: "\n")
                }
                self.totalMantras = self.arrayOfMantra.count
                if(self.totalMantras != 0){
                    self.mantraAvailable = true
                }
            }
            catch {
                print("error loading contents of url \(self.pathToAff!)")
                print(error.localizedDescription)
            }
        }
        else {
            //UserDefaults.standard.set(false, forKey: "firstTime")
            //self.hasVisited = false
            // Attempt to open the file:
            guard let theFile = Bundle.main.path(forResource: "mantras", ofType: "txt", inDirectory: "positiveAffirmations") else {
                return // Return if the file can't be found
            }
            
            do {
                // Extract the file contents, and return them as a split string array
                let exportText = try String(contentsOfFile: theFile)
                let tempArray = exportText.components(separatedBy: "\n")
                if(tempArray[0] != ""){
                    self.arrayOfMantra = exportText.components(separatedBy: "\n")
                    if self.arrayOfMantra.last == "" {
                        self.arrayOfMantra.removeLast()
                    }
                }
                
                //write to file
                var toWrite = String()
                for stringInArray in self.arrayOfMantra {
                    if(stringInArray == self.arrayOfMantra.last!){
                        toWrite += (stringInArray)
                    }
                    else {
                        toWrite += (stringInArray + "\n")
                    }
                }
                try (toWrite).write(toFile: self.pathToAff!, atomically: false, encoding: .utf8)
                self.totalMantras = self.arrayOfMantra.count
                if(self.totalMantras != 0){
                    self.mantraAvailable = true
                }
                
                
            } catch let error as NSError { // Handle any exception: Return a nil if we have any issues
                print("error loading contents of url \(theFile)")
                print(error.localizedDescription)
            }
        }
        if let checker: Bool = UserDefaults.standard.value(forKey: "firstTime") as? Bool {
            self.hasVisited = checker
        }
        else {
            UserDefaults.standard.set(false, forKey: "firstTime")
            self.hasVisited = false
        }
        if(self.hasVisited == false){
            self.statisticsButton.isHidden = true
            self.statisticsButton.isEnabled = false
        }
        else{
            self.statisticsButton.isHidden = false
            self.statisticsButton.isEnabled = true
        }


    }
    @IBOutlet weak var statisticsButton: UIButton!
    
    // Rotated the background image
    func rotateBG(targetView: UIView, duration: Double = 1.0){
        // Present for first
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: { targetView.transform = targetView.transform.rotated(by: CGFloat(M_PI))}) { finished in self.rotateBG(targetView: targetView, duration: duration)
        }
    }
    // Resets timer color
    func resetTimerColor(){
        let attAdd = NSMutableAttributedString.init(attributedString: self.sessionTimer.attributedText!)
        let range = ((self.sessionTimer.text as NSString?)!).range(of: self.sessionTimer.text!)
        attAdd.addAttribute(NSStrokeColorAttributeName, value: UIColor.white, range: range)
        attAdd.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: range)
        attAdd.addAttribute(NSStrokeWidthAttributeName, value: 2.5, range: range)
        self.sessionTimer.attributedText = NSAttributedString(attributedString: attAdd)
    }
    
    
    

    @IBOutlet weak var bgMantra: UIImageView!
    // Called once when this object is first instanciated
    override func viewDidLoad() {
        super.viewDidLoad() // Call the super class
        self.reStartButtonText.layer.cornerRadius = 10
        self.statisticsButton.layer.cornerRadius = 10
        self.statisticsButton.isHidden = false
        self.resetTimerColor() // Reset timer color
        self.topTitle.adjustsFontSizeToFitWidth = true
        //let offsetImage = topTitle.frame.height
        //let center = sessionTimer.frame.origin.y + (sessionTimer.frame.height/2)
        //let trueOffset = (center - offsetImage)*2
        //let background = UIImageView(frame: CGRect(x: 0, y: offsetImage, width: UIScreen.main.bounds.width, height: trueOffset))
        bgMantra.image = UIImage(named: "mantraFinal2.png")
        view.sendSubview(toBack: bgMantra)
        self.rotateBG(targetView: bgMantra, duration: 60)
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "SquareBreathing.png")!)
        //Path location is               /Library/Developer/CoreSimulator/Devices/B4F5BD79-F9B7-4AE8-91D1-E6DB8AA75CE7/data/Containers/Data/Application/68D1C1AE-7A3F-479D-BBB3-7493A421E8B7/Documents/timeStatistics..txt
        
        
        


        
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
        
        
    }
    //DO NOT DELETE UNLESS BERKE IS REALLY REALLY SURE
    func loadTotalStatistics() -> String{
        let fileName = "timeStatistics"
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension(".txt")
        
        
        var readString = "" // Used to store the file contents
        do {
            // Read the file contents
            readString = try String(contentsOf: fileURL)
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
        return readString
    
    }
    
    func saveRecentSesionTracker(){
        loadStatistics()
        var latestSessions = [Double]()
        if let previousSessions = UserDefaults.standard.value(forKey: "previousSessions"){
            latestSessions = previousSessions as! [Double]
        }
        if(sessionSecs != 0.0){
        latestSessions.append(sessionSecs)
        }
        if(latestSessions.count >= 11){
            latestSessions.remove(at: 0)
        }
        
        UserDefaults.standard.set(latestSessions, forKey: "previousSessions")
        print(latestSessions)
    }
    
    
    


    //DO NOT DELETE UNLESS BERKE IS REALLY REALLY SURE
    func setTotalStatistics(previousSesssion: String){
        
        let writeString:String
        
        if(previousSesssion == ""){
            writeString = String(sessionSecs)
        }
        else{
            writeString = previousSesssion + " " + String(sessionSecs)
        }

        
        let fileName = "timeStatistics"
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension(".txt")
        
        do {
            // Write to the file
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
    
    }

    
    func saveStatistics(){
        if(sessionSecs != 0.0){                                 // Session secs being equal to 0.00 causes bugs, best solution is to totally ignore the person who achieves to press Re/Start button twice in literally 0 seconds 0 miliseconds
            UserDefaults.standard.set(averageSession, forKey: "averageSession")
            UserDefaults.standard.set(minSession, forKey: "minSession")
            UserDefaults.standard.set(maxSession, forKey: "maxSession")
            UserDefaults.standard.set(totalSessions, forKey: "totalSessions")
            UserDefaults.standard.set(sessionSecs, forKey: "lastSession")
            UserDefaults.standard.synchronize()
        }
    }
    
    func loadStatistics(){
        if let avg:Double = UserDefaults.standard.value(forKey: "averageSession") as! Double?{
            averageSession = avg
        }
        if let minS:Double = UserDefaults.standard.value(forKey: "minSession") as! Double? {
            minSession = minS
        }
        if let maxS:Double = UserDefaults.standard.value(forKey: "maxSession") as! Double?{
            maxSession = maxS
        }
        if let totalS = UserDefaults.standard.value(forKey: "totalSessions") as! Int?{
            totalSessions = totalS
        }
        UserDefaults.standard.synchronize()
    }
    
    
    
    func syncStatistics(){
        if let numberOfSessions = UserDefaults.standard.value(forKey:  "totalSessions") as? Int{
         totalSessions = numberOfSessions
        }
        if(totalSessions == 0){                                 //Do not load
            averageSession = Double(sessionSecs)
            minSession = Double(sessionSecs)
            maxSession = Double(sessionSecs)
        }
        else{

            averageSession = (((averageSession*Double(totalSessions))+Double(sessionSecs))/Double((totalSessions+1)))

        }
        
        if(Double(sessionSecs) > maxSession){
            maxSession = Double(sessionSecs)
        }
        if(Double(sessionSecs) < minSession){
            minSession = Double(sessionSecs)
        }


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
        if self.reStartButtonText.currentTitle != "Stop" {
            animationTimer!.invalidate()
            sessionTracker!.invalidate()
            animationTimer = nil
            sessionTracker = nil
            return
        }
        sessionSecs+=1
        sessionTimeSeconds-=1                                                  //Decrement Seconds
        totalTimerSeconds+=1                                                   //Increment Seconds
        if(sessionTimeSeconds == 0 && sessionTimeMinute == 0){
            restartButton(UIButton())
            if(self.mantraAvailable == true){
                let dMantra = UIAlertController(title: "", message: self.arrayOfMantra[Int(arc4random_uniform(UInt32(self.arrayOfMantra.count)))], preferredStyle: .alert)
                let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                dMantra.addAction(theOkAction)
                present(dMantra, animated: true, completion: nil)
            }
            sessionTimer.text = "05:00"
        }
        
        else if(sessionTimeSeconds == 0 && sessionTimeMinute != 0){                 //If Remaining mins != 0
            sessionTimer.text = "0" + String(sessionTimeMinute)+":00"
            sessionTimeMinute-=1                                               //Decrement Minutes
            sessionTimeSeconds = 60                                            //Decrement Seconds
        }
            
        else if(sessionTimeSeconds < 10 && sessionTimeMinute == 0){             //If no mins left
            sessionTimer.text = "0" + String(sessionTimeMinute) + ":0" + String(sessionTimeSeconds)
            
            if(sessionTimeSeconds <= -1){                                       //Detects if timer is finished
                sessionTracker?.invalidate()                                     //Stops the timer
                sessionTimer.text = "05:00"
                
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
        var totalSecString = String(totalTimerSeconds)
        if(totalTimerSeconds < 10){
            totalSecString = "0" + totalSecString
        }
        var totalMinString = String(totalTimerMinute)
        if(totalTimerMinute < 10){
            totalMinString = "0" + totalMinString
        }
        totalTimer.text = totalMinString + ":" + totalSecString    //Keeps XX:XX format
        self.resetTimerColor() // Resets the color of timer
    }

    
    
    // scaleAnimationManager calls all four steps of animation in order which are fadein, scalex2, scale to original and fade out. SquareOrderManager function is used to track the current image
    func scaleAnimationManager(){
        if self.reStartButtonText.currentTitle != "Stop" {
            if(animationTimer != nil){
                animationTimer!.invalidate()
                animationTimer = nil
            }
            if(sessionTracker != nil){
                sessionTracker!.invalidate()
                sessionTracker = nil
            }
            return
        }
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations:{
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.isAnimating = true
            self.squareOrderManager(currentCircle: self.circleOrderTracker).transform = CGAffineTransform(scaleX: 2, y: 2) //Sets the selected image's scale to 2 in 2 seconds

        }, completion: { (finished: Bool) -> Void in
            if(self.sessionTracker != nil){
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        })
        UIView.animate(withDuration: 2, delay: 2.2, options: .curveEaseOut, animations:{
            self.squareOrderManager(currentCircle: self.circleOrderTracker).transform = CGAffineTransform(scaleX: 1, y: 1) //Rescales the image over time
        }, completion: {(finished: Bool) -> Void in
            self.isAnimating=false
        })

        circleOrderTracker+=1 //Rotates between images
    }
    

    // Tracks the current image with switch statement and returns it
    func squareOrderManager(currentCircle:Int) -> UIImageView{
        let orderNumber = currentCircle % 4

        switch orderNumber{
            
        case 0:
            return circleTRight
        case 1:
            return circleTLeft
        case 2:
            return circleBLeft
        case 3:
            return circleBRight
          
        default:
            print("Input variable out of scope")
            return circleTLeft
        }
        

    }
    
    // Handle time control. Start/Restart the timer based on user input:
    @IBAction func restartButton(_ sender: Any) {               //Re/Start button
        // Present for first
        print(self.hasVisited)
        self.statisticsButton.isHidden = false
        self.statisticsButton.isEnabled = true
        if(self.hasVisited == false){
            let firstUse = UIAlertController(title: "Welcome to SFUnwind", message: "Click on the help button on the top right on any feature to obtain info.", preferredStyle: .alert)
            let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            firstUse.addAction(theOkAction)
            self.present(firstUse, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "firstTime")
            self.hasVisited = true
            return
        }
        self.reStartButtonText.isEnabled = false                //BUG FIX // Case to disable Re/Start Button bashing
        if(self.reStartButtonText.isEnabled == true){
            return
        }
    sesssionTrackerActive = !(sesssionTrackerActive)            //Boolean statement acts like on/off button with reset functionality
        var _ = saveMinutesTimer(totalTimerMinute: totalTimerMinute)
        var _ = saveSecondsTimer(totalTimerSeconds:totalTimerSeconds)
        
        if(sesssionTrackerActive == true && self.isAnimating == false && sessionTracker == nil && animationTimer == nil){
            sessionTimeSeconds = 60                             //Reset
            sessionTimeMinute = 4
            while(reStartButtonText.currentTitle != "Stop"){
                reStartButtonText.setTitle("Stop", for: .normal)
            }
            sessionTracker = Timer()
            animationTimer = Timer()
            timeManager()                                       //Call timeManager()
            sessionTracker = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SquareBreathingViewController.timeManager), userInfo: nil, repeats: true)  //Call timeManager() once in every second
            scaleAnimationManager()                             //Call animation handler
            animationTimer = Timer.scheduledTimer(timeInterval: 4.2, target: self, selector: #selector(SquareBreathingViewController.scaleAnimationManager), userInfo: nil, repeats: true)
            

        }
        else if (sessionTracker != nil && animationTimer != nil){
            sessionTracker!.invalidate()                         //Stops timer
            sessionTimeSeconds = 0                             //Reset
            sessionTimeMinute = 5                               //Reset
            sessionTimer.text = "05:00"                         //Print to screen
            self.resetTimerColor()                              //Reset Timer Color
            animationTimer!.invalidate()                         //Stops timer for animation
            circleOrderTracker = 1                              //Reset image number
            reStartButtonText.setTitle("Start", for: .normal)//Set Reset button text
            sessionTracker = nil
            animationTimer = nil
            setTotalStatistics(previousSesssion: loadTotalStatistics())
            
            syncStatistics()
            totalSessions+=1
            saveStatistics()
            saveRecentSesionTracker()
            sessionSecs = 0

            
            
        
        }
        self.reStartButtonText.isEnabled = true
        
        
    }
    
    //Circles and Images
    @IBOutlet weak var reStartButtonText: UIButton!
    @IBOutlet weak var circleBLeft: UIImageView!
    @IBOutlet weak var circleTRight: UIImageView!
    @IBOutlet weak var circleTLeft: UIImageView!
    @IBOutlet weak var circleBRight: UIImageView!
}







