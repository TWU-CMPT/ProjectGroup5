//
// PositiveAffirmationViewController.swift - View Controller for the Positive Affirmation feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: David Magaril
// Contributing Programmers: Joseph Zhou, Adam Badke
// Known issues:
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import UIKit
import UserNotifications

class PositiveAffirmationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    //variable for functions
    var pathToAff: String? = nil
    var txtIndex = UITextField()
    var totalMantras: Int = 0
    var currentIndex: Int = 0
    var txt = "rrr"
    var blank = "\n"
    var arrayOfMantra = [String]()
    let alreadyInFile = UIAlertController(title: "Mantra already exists!", message: "This positive affirmation has already been entered.", preferredStyle: .alert)
    let notInFile = UIAlertController(title: "Not in List", message: "Mantra not found.", preferredStyle: .alert)
    let notEntered = UIAlertController(title: "Mantra Missing", message: "You must enter a positive affirmation.", preferredStyle: .alert)
    let notBoth = UIAlertController(title: "Notifications Cleared/Mantra Missing", message: "All notifications (if any) removed from this application. Please enter mantra.", preferredStyle: .alert)
    let notExist = UIAlertController(title: "Notifications Cleared", message: "All notifications (if any) removed from this application.", preferredStyle: .alert)
    let removeNot = UIAlertController(title: "Mantra Not Found", message: "Please enter mantra.", preferredStyle: .alert)
    let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    let notiSent = UIAlertController(title: "Positive Affirmation Confirmed", message: "Your mantra notification preferences have been saved.", preferredStyle: .alert)
    
    //Create button
    @IBAction func Create(_ sender: AnyObject) {
        //create an alert
        let alert = UIAlertController(title: "Enter a Custom Affirmation", message: "Please enter a new mantra", preferredStyle: UIAlertControllerStyle.alert)
        
        //add textField
        alert.addTextField { (textField) in textField.placeholder = "Insert Mantra..."
        }
        
        //Save aciton
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) -> Void in
            let saveText = (alert.textFields?[0])!.text  //take the input text
            
            // find file
            if(saveText != ""){
                let theFileManager = FileManager.default
                
                //read file
                if theFileManager.fileExists(atPath: self.pathToAff!) {
                    do {
                        let exportText = try String(contentsOfFile: self.pathToAff!)
                        let tempArray = exportText.components(separatedBy: "\n")
                        
                        //read from test, load as array
                        if(tempArray[0] != ""){
                            self.arrayOfMantra = exportText.components(separatedBy: "\n")
                        }
                        if self.arrayOfMantra.contains(saveText!) {
                            self.alreadyInFile.title = "Mantra Already Entered"
                            
                            // Present alert to user.
                            self.present(self.alreadyInFile, animated: true, completion: nil) //Present alert
                        }
                        else {
                            
                            //add the input text to array
                            self.arrayOfMantra.append(saveText!)
                            if(exportText == ""){
                                try (saveText!).write(toFile: self.pathToAff!, atomically: false, encoding: .utf8)
                            }
                                
                            //write to file
                            else {
                                try (exportText + "\n" + saveText!).write(toFile: self.pathToAff!, atomically: false, encoding: .utf8)
                            }
                            self.totalMantras+=1
                            self.currentIndex = self.totalMantras-1
                            
                        }
                    }
                    catch let error as NSError {
                        print("error loading contents of url \(self.pathToAff!)")
                        print(error.localizedDescription)
                    }
                    
                }
                else {
                    do {
                        //write to file
                        try (saveText!).write(toFile: self.pathToAff!, atomically: false, encoding: .utf8)
                        self.totalMantras+=1
                        self.currentIndex = self.totalMantras
                        let exportText = try String(contentsOfFile: self.pathToAff!)
                        self.arrayOfMantra = exportText.components(separatedBy: "\n")
                    }
                    catch let error as NSError {
                        print("error writing to url \(self.pathToAff!)")
                        print(error.localizedDescription)
                    }
                }
                self.txt = self.txtIndex.text!
                self.Label.text = saveText //change the label to the next same as the user input
            }
            else {
                self.notEntered.title = "Mantra Not Entered"
                self.present(self.notEntered, animated: true, completion: nil) //Present alert
            }
        })
        
        alert.addAction(saveAction) //run the save action
        
        //Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancelAction)   //run the cancel action
        
        self.present(alert, animated: true, completion: nil)    //present it
        
    }
    
    //Delete button
    @IBAction func DeleteAlert(_ sender: AnyObject) {
        let mantraRemove: String = self.Label.text!
        let theFileManager = FileManager.default
        
        //read file
        if theFileManager.fileExists(atPath: self.pathToAff!) {
            do {
                let exportText = try String(contentsOfFile: self.pathToAff!)
                self.arrayOfMantra = exportText.components(separatedBy: "\n")
                if self.arrayOfMantra.contains(mantraRemove) {
                    let theIndex = self.arrayOfMantra.index(of: mantraRemove)
                    self.arrayOfMantra.remove(at: theIndex!) //remove mantra from array
                    var toWrite = String()
                    for stringInArray in self.arrayOfMantra {
                        if(stringInArray == self.arrayOfMantra.last!){
                            toWrite += (stringInArray)
                        }
                        else {
                            toWrite += (stringInArray + "\n")
                        }
                    }
                    if(self.totalMantras > 0){
                        self.totalMantras-=1
                    }
                    else {
                        self.Label.text = ""
                    }
                    if (self.currentIndex >= self.totalMantras) {
                        self.currentIndex = self.totalMantras-1
                    }
                    if(self.totalMantras == 0){
                        self.Label.text = ""
                    }
                    else {
                        self.Label.text = self.arrayOfMantra[self.currentIndex] // change the label text as in array
                    }
                    try (toWrite).write(toFile: self.pathToAff!, atomically: false, encoding: .utf8)
                }
                else {
                    self.alreadyInFile.title = "Mantra Not Found"
                    
                    // Present alert to user.
                    self.present(self.notInFile, animated: true, completion: nil) //Present alert
                    
                }
            }
            catch let error as NSError {
                print("error loading contents of url \(self.pathToAff!)")
                print(error.localizedDescription)
            }
            
        }
        else {
            self.alreadyInFile.title = "Mantra Not Found"
            self.present(self.notInFile, animated: true, completion: nil) //Present alert
        }
        
        
    }
    @IBOutlet weak var helpButton: UIButton!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! HelpViewController
        nav.callingScreen = 2 // Notify the popup who's calling it: 0 = Square Breathing, 1 = Grounding, 2 = Positive Affirmations, 3 = Panic Alerts
    }
    
    //Previous button
    @IBAction func Previous(_ sender: AnyObject) {
        if(self.totalMantras > 0){
            self.currentIndex -= 1
            if(self.currentIndex < 0){
                self.currentIndex = self.totalMantras-1
            }
            self.Label.text = self.arrayOfMantra[self.currentIndex] //change label text to the previous one
        }
    }
    
    //Next button
    @IBAction func Next(_ sender: AnyObject) {
        if(self.totalMantras > 0){
            self.currentIndex += 1
            if (self.currentIndex >= self.totalMantras) {
                self.currentIndex = 0
            }
            self.Label.text = self.arrayOfMantra[self.currentIndex] //change label text to the next one
        }
    }
    
    //Label, textFiled, viewpicker, button
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var textTime: UITextField!
    @IBOutlet weak var weekday: UITextField!
    @IBOutlet weak var weekdayDrop: UIPickerView!
    @IBOutlet weak var hour: UITextField!
    @IBOutlet weak var hourDrop: UIPickerView!
    @IBOutlet weak var minute: UITextField!
    @IBOutlet weak var minuteDrop: UIPickerView!
    @IBOutlet weak var dataDrop: UIPickerView!
    @IBOutlet weak var atLabelText: UILabel!
    @IBOutlet weak var sepLabel: UILabel!
    @IBOutlet weak var notificationButton: UIButton!
    //options of the frequency
    var data = ["Never", "Weekly", "Daily", "Hourly"]
    //options of weekdays
    var weekDay = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    //options of hours
    var hr = ["12","1","2","3","4","5","6","7","8","9","10","11"]
    //options of minutes
    var min = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    //options of am or pm
    var mornAfter = ["AM","PM"]
    // UI Selectable Buttons
    //--
    @IBOutlet weak var createMantraButton: UIButton!
    @IBOutlet weak var deleteMantraButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    //--
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.notificationSet.sizeToFit()
        self.notificationSet.textAlignment = NSTextAlignment.center
    }
    
    // Called once when this view is loaded:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detectTap()
        //initialize the index for mantras.count
        totalMantras = 0
        currentIndex = 0
        self.notificationButton.layer.cornerRadius = 13
        self.createMantraButton.layer.cornerRadius = 13
        self.deleteMantraButton.layer.cornerRadius = 13
        self.previousButton.layer.cornerRadius = 13
        self.nextButton.layer.cornerRadius = 13
        let desiredFile = "affirmations.txt"
        let thePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let theURL = NSURL(fileURLWithPath: thePath)
        pathToAff = theURL.appendingPathComponent(desiredFile)?.path
        print(UIApplication.shared.scheduledLocalNotifications)
        sleep(1)
        // Set notification settings properly.
        if (UIApplication.shared.scheduledLocalNotifications?.count)! > 0 {
            let setNot = UIApplication.shared.scheduledLocalNotifications![0]
            let notDate = setNot.fireDate
            let minute = NSCalendar.current.component(.minute, from: notDate!)
            var AMPM = "A.M"
            var minuteString: String
            var hourString: String
            if(minute<=9){
                minuteString = "0" + String(minute)
            }
            else {
                minuteString = String(minute)
            }
            var hour = NSCalendar.current.component(.hour, from: notDate!)
            if(hour>=12){
                hour = hour - 12
                AMPM = "P.M"
            }
            if(hour==0){
                hour=12
            }
            if(hour<=9){
                hourString = "0" + String(hour)
            }
            else {
                hourString = String(hour)
            }
            let weekday = NSCalendar.current.component(.weekday, from: notDate!)
            if(setNot.repeatInterval == NSCalendar.Unit.hour){
                self.notificationSet.text = "Active Notification: Each hour at ##:" + minuteString
            }
            else if(setNot.repeatInterval == NSCalendar.Unit.day){
                self.notificationSet.text = "Active Notification: Each Day at " + hourString + ":" + minuteString + " " + AMPM
            }
            else {
                self.notificationSet.text = "Active Notification: Each " + self.weekDay[weekday-1] + " at " + hourString + ":" + minuteString + " " + AMPM
            }
            self.notificationSet.sizeToFit()
            self.notificationSet.textAlignment = NSTextAlignment.center
        }
        self.notificationSet.sizeToFit()
        self.notificationSet.textAlignment = NSTextAlignment.center
        //read file
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
                    self.Label.text = self.arrayOfMantra[0] //change label text as in array
                }
            }
            catch {
                print("error loading contents of url \(self.pathToAff!)")
                print(error.localizedDescription)
            }
        }
        else {
            
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
                    self.Label.text = self.arrayOfMantra[0] //present the first mantra in the array
                }

                
            } catch let error as NSError { // Handle any exception: Return a nil if we have any issues
                print("error loading contents of url \(theFile)")
                print(error.localizedDescription)
            }
        }
        
        //set up actions and properties
        alreadyInFile.addAction(theOkAction)
        notInFile.addAction(theOkAction)
        notEntered.addAction(theOkAction)
        notBoth.addAction(theOkAction)
        notExist.addAction(theOkAction)
        removeNot.addAction(theOkAction)
        notiSent.addAction(theOkAction)
        weekday.isHidden = true
        weekday.isEnabled = false
        hour.isHidden = true
        hour.isEnabled = false
        minute.isHidden = true
        minute.isEnabled = false
        atLabelText.isHidden = true
        sepLabel.isHidden = true
        AMPMSel.isHidden = true
        weekdayTitle.isHidden = true
        hourTitle.isHidden = true
        minuteTitle.isHidden = true
    }
    
    // Check if we've recieved a memory warning.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()// dispose of any resources that can be recreated.
    }
    
    //return the components of data
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func detectTap(){
        let theTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideSelection))
        theTap.cancelsTouchesInView = false
        view.addGestureRecognizer(theTap)
    }
    
    func hideSelection(){
        if(dataDrop.isHidden == false){
            self.pickerView(dataDrop, didSelectRow: self.dataDrop.selectedRow(inComponent: 0), inComponent: 0)
        }
        if(hourDrop.isHidden == false){
            self.pickerView(hourDrop, didSelectRow: self.hourDrop.selectedRow(inComponent: 0), inComponent: 0)
        }
        if(minuteDrop.isHidden == false){
            self.pickerView(minuteDrop, didSelectRow: self.minuteDrop.selectedRow(inComponent: 0), inComponent: 0)
        }
        if(weekdayDrop.isHidden == false){
            self.pickerView(weekdayDrop, didSelectRow: self.weekdayDrop.selectedRow(inComponent: 0), inComponent: 0)
        }
        if(AMPMSelPick.isHidden == false){
            self.pickerView(AMPMSelPick, didSelectRow: self.AMPMSelPick.selectedRow(inComponent: 0), inComponent: 0)
        }
    }
    
    //make the pickerview count rows in different textFields
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        var countrows : Int = data.count
        if pickerView == weekdayDrop{
            countrows = self.weekDay.count
        }
        else if pickerView == hourDrop{
            countrows = self.hr.count
        }
        else if pickerView == minuteDrop{
            countrows = self.min.count
        }
        else if pickerView == AMPMSelPick{
            countrows = self.mornAfter.count
        }
        return countrows
    }
    @IBOutlet weak var AMPMSel: UITextField!
    @IBOutlet weak var AMPMSelPick: UIPickerView!
    
    //return the option which the user selected in string type
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == dataDrop{
            let titleRow = data[row]
            return titleRow
        }
        else if pickerView == weekdayDrop{
            let titleRow = weekDay[row]
            return titleRow
        }
        else if pickerView == hourDrop{
            let titleRow = hr[row]
            return titleRow
        }
        else if pickerView == minuteDrop{
            let titleRow = min[row]
            return titleRow
        }
        else if pickerView == AMPMSelPick{
            let titleRow = mornAfter[row]
            return titleRow
        }
        return ""
    }
    
    @IBOutlet weak var weekdayTitle: UILabel!
    
    @IBOutlet weak var hourTitle: UILabel!
    
    @IBOutlet weak var minuteTitle: UILabel!
    @IBOutlet weak var notificationSet: UILabel!
    
    //make the pickerView shows the option which the user selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dataDrop{
            
            //hide certain picker views for different cases
            self.textTime.text = self.data[row]
            self.dataDrop.isHidden = true
            if textTime.text == "Weekly" {
                weekday.isHidden = false
                weekday.isEnabled = true
                hour.isHidden = false
                hour.isEnabled = true
                minute.isHidden = false
                minute.isEnabled = true
                atLabelText.isHidden = false
                sepLabel.isHidden = false
                AMPMSel.isHidden = false
                AMPMSel.isEnabled = true
                weekdayTitle.isHidden = false
                hourTitle.isHidden = false
                minuteTitle.isHidden = false
            }
            else if textTime.text == "Daily" {
                weekday.isHidden = true
                weekday.isEnabled = false
                hour.isHidden = false
                hour.isEnabled = true
                minute.isHidden = false
                minute.isEnabled = true
                atLabelText.isHidden = true
                sepLabel.isHidden = false
                AMPMSel.isHidden = false
                AMPMSel.isEnabled = true
                weekdayTitle.isHidden = true
                hourTitle.isHidden = false
                minuteTitle.isHidden = false
            }
            else if textTime.text == "Hourly" {
                weekday.isHidden = true
                weekday.isEnabled = false
                hour.isHidden = true
                hour.isEnabled = false
                minute.isHidden = false
                minute.isEnabled = true
                atLabelText.isHidden = true
                sepLabel.isHidden = true
                AMPMSel.isHidden = true
                AMPMSel.isEnabled = false
                weekdayTitle.isHidden = true
                hourTitle.isHidden = true
                minuteTitle.isHidden = false
            }
            else {
                weekday.isHidden = true
                weekday.isEnabled = false
                hour.isHidden = true
                hour.isEnabled = false
                minute.isHidden = true
                minute.isEnabled = false
                atLabelText.isHidden = true
                sepLabel.isHidden = true
                AMPMSel.isHidden = true
                AMPMSel.isEnabled = false
                weekdayTitle.isHidden = true
                hourTitle.isHidden = true
                minuteTitle.isHidden = true
            }
        }
        else if pickerView == weekdayDrop{
            self.weekday.text = self.weekDay[row]
            self.weekdayDrop.isHidden = true
        }
        else if pickerView == hourDrop{
            self.hour.text = self.hr[row]
            self.hourDrop.isHidden = true
        }
        else if pickerView == minuteDrop{
            self.minute.text = self.min[row]
            self.minuteDrop.isHidden = true
        }
        else if pickerView == AMPMSelPick{
            self.AMPMSel.text = self.mornAfter[row]
            self.AMPMSelPick.isHidden = true
        }
    }
    
    //hide the view picker when the textFiled end editing
    func textFieldDidBeginEditing(_ textFiled:UITextField){
        textFiled.isEnabled = false
        self.hideSelection()
        if (textFiled == self.textTime){
            textFiled.text = ""
            self.dataDrop.isHidden = false
        }
        else if (textFiled == self.weekday){
            textFiled.text = ""
            self.weekdayDrop.isHidden = false
        }
        else if (textFiled == self.hour){
            textFiled.text = ""
            self.hourDrop.isHidden = false
        }
        else if (textFiled == self.minute){
            textFiled.text = ""
            self.minuteDrop.isHidden = false
        }
        else if (textFiled == self.AMPMSel){
            textFiled.text = ""
            self.AMPMSelPick.isHidden = false
        }
        
        textFiled.isEnabled = true
    }
    
    //Schedule Notification
    @IBAction func scheduleNotification(_ sender: AnyObject) {
        self.hideSelection()
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_POSIX_US")
        let weekDaySymbols = calendar.weekdaySymbols
        var indexOfDay = weekDaySymbols.index(of: weekday.text!) // INSERT WEEKDAY STRING HERE
        if indexOfDay == nil {
            indexOfDay = weekDaySymbols.index(of: "Sunday")
        }
        let weekDay = indexOfDay! + 1
        var matchingComponents = DateComponents()
        var tfreq = ""
        
        //default as Never
        if textTime.text == "" {
            tfreq = "Never"
        }
        else {
            tfreq = textTime.text!
        }
        if tfreq == "Weekly" {
            matchingComponents.weekday = weekDay
        }
        
        //show hours and minutes only
        if tfreq != "Hourly" {
            if(hour.text != ""){
                matchingComponents.hour = Int(hour.text!)!%12
            }
            else {
                matchingComponents.hour = 0
            }
            if(AMPMSel.text == "PM"){
                matchingComponents.hour! += 12
            }
        }
        else {
            matchingComponents.hour = calendar.component(.hour, from: Date())
        }
        if(minute.text == ""){
            matchingComponents.minute = 0
        }
        else {
            matchingComponents.minute = Int(minute.text!) // must set, right?
        }
        
        //hide and present certain view picker for different cases
        if tfreq == "Hourly" && matchingComponents.minute! <= Calendar.current.component(.minute, from: Date()) {
            matchingComponents.hour! += 1
            matchingComponents.hour! = matchingComponents.hour! % 24
        }
        let nextDay = calendar.nextDate(after: Date(), matching: matchingComponents, matchingPolicy: .nextTime)
        //print(nextDay?.description)
        if(self.Label.text != ""){
            UIApplication.shared.cancelAllLocalNotifications()
            self.notificationSet.text = "No Active Notification"
        }
        if (tfreq != "Never" && self.Label.text != "") {
            let notification = UILocalNotification()
            let dict:NSDictionary = ["ID":"ID goes here"]
            notification.userInfo = dict as! [String : String]
            notification.alertBody = self.Label.text
            notification.alertAction = "Open"
            notification.fireDate = nextDay
            if tfreq == "Weekly" {
                notification.repeatInterval = .weekday
            }
            else if tfreq == "Daily" {
                notification.repeatInterval = .day
            }
            else {
                notification.repeatInterval = .hour // MINIMUM IS MINUTE
            }
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.scheduleLocalNotification(notification)
            if (UIApplication.shared.scheduledLocalNotifications?.count)! > 0 {
                let setNot = UIApplication.shared.scheduledLocalNotifications![0]
                let notDate = setNot.fireDate
                let minute = NSCalendar.current.component(.minute, from: notDate!)
                var AMPM = "A.M"
                var minuteString: String
                var hourString: String
                if(minute<=9){
                    minuteString = "0" + String(minute)
                }
                else {
                    minuteString = String(minute)
                }
                var hour = NSCalendar.current.component(.hour, from: notDate!)
                if(hour>=12){
                    hour = hour - 12
                    AMPM = "P.M"
                }
                if(hour==0){
                    hour=12
                }
                if(hour<=9){
                    hourString = "0" + String(hour)
                }
                else {
                    hourString = String(hour)
                }
                let weekday = NSCalendar.current.component(.weekday, from: notDate!)
                if(setNot.repeatInterval == NSCalendar.Unit.hour){
                    self.notificationSet.text = "Active Notification: Each hour at ##:" + minuteString
                }
                else if(setNot.repeatInterval == NSCalendar.Unit.day){
                    self.notificationSet.text = "Active Notification: Each Day at " + hourString + ":" + minuteString + " " + AMPM
                }
                else {
                    self.notificationSet.text = "Active Notification: Each " + self.weekDay[weekday-1] + " at " + hourString + ":" + minuteString + " " + AMPM
                }
                self.notificationSet.sizeToFit()
                self.notificationSet.textAlignment = NSTextAlignment.center
            }
            else {
                self.notificationSet.text = "ERROR!"
            }
            self.present(self.notiSent, animated: true, completion: nil) // Presnt alert
        }
        else if (self.Label.text == "" && tfreq == "Never") {
            // Present alert to user.
            self.present(self.notBoth, animated: true, completion: nil) //Present alert
        }
        else if(self.Label.text == ""){
            // Present alert to user.
            self.present(self.removeNot, animated: true, completion: nil) //Present alert
        }
        else {
            // Present alert to user.
            self.present(self.notExist, animated: true, completion: nil) //Present alert
        }
    }
}


