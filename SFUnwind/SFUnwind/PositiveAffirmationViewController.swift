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
    
    //Variables for functions
    // String for path
    var pathToAff: String? = nil
    // Count of total mantras
    var totalMantras: Int = 0
    // Current index of mantras
    var currentIndex: Int = 0
    // Current array of mantas
    var arrayOfMantra = [String]()
   
    
    //Create button
    // Input: Sender
    // Output: None
    // No dependencies
    @IBAction func Create(_ sender: AnyObject) {
        // Create alerts
        // ---
        let alreadyInFile = UIAlertController(title: "Mantra already exists!", message: "This positive affirmation has already been entered.", preferredStyle: .alert)
        let notInFile = UIAlertController(title: "Not in List", message: "Mantra not found.", preferredStyle: .alert)
        let notEntered = UIAlertController(title: "Mantra Missing", message: "You must enter a positive affirmation.", preferredStyle: .alert)
        // ---
        // Create user response
        let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        // Add response to each alert
        notEntered.addAction(theOkAction)
        notInFile.addAction(theOkAction)
        alreadyInFile.addAction(theOkAction)
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
                            alreadyInFile.title = "Mantra Already Entered"
                            
                            // Present alert to user.
                            self.present(alreadyInFile, animated: true, completion: nil) //Present alert
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
                    } // Display error
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
                self.Label.text = saveText //change the label to the next same as the user input
            }
            else { // Find no mantra entered, show user
                notEntered.title = "Mantra Not Entered"
                self.present(notEntered, animated: true, completion: nil) //Present alert
            }
        })
        
        alert.addAction(saveAction) //run the save action
        
        //Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancelAction)   //run the cancel action
        
        self.present(alert, animated: true, completion: nil)    //present it
        
    }
    
    //Delete button
    // Input: Sender
    // Output: None
    // No dependencies
    @IBAction func DeleteAlert(_ sender: AnyObject) {
        // Create alerts
         let alreadyInFile = UIAlertController(title: "Mantra already exists!", message: "This positive affirmation has already been entered.", preferredStyle: .alert)
        let notInFile = UIAlertController(title: "Not in List", message: "Mantra not found.", preferredStyle: .alert)
        // Create user response
        let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        // Add responses
        notInFile.addAction(theOkAction)
        alreadyInFile.addAction(theOkAction)
        // Get mantra to remove
        let mantraRemove: String = self.Label.text!
        // Obtain default file manager
        let theFileManager = FileManager.default
        
        //read file
        if theFileManager.fileExists(atPath: self.pathToAff!) {
            do {
                let exportText = try String(contentsOfFile: self.pathToAff!)
                self.arrayOfMantra = exportText.components(separatedBy: "\n")
                if self.arrayOfMantra.contains(mantraRemove) {
                    // Get index
                    let theIndex = self.arrayOfMantra.index(of: mantraRemove)
                    self.arrayOfMantra.remove(at: theIndex!) //remove mantra from array
                    // Set to write for file refresh
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
                        // Check if any mantas
                        self.totalMantras-=1
                    }
                    else {
                        // If not do nothing
                        self.Label.text = ""
                    }
                    // Check if reach end, go back 1 if so
                    if (self.currentIndex >= self.totalMantras) {
                        self.currentIndex = self.totalMantras-1
                    } // Check if 0, display nothing
                    if(self.totalMantras == 0){
                        self.Label.text = ""
                    }
                    else {
                        self.Label.text = self.arrayOfMantra[self.currentIndex] // change the label text as in array
                    } // Write to file
                    try (toWrite).write(toFile: self.pathToAff!, atomically: false, encoding: .utf8)
                }
                else { // If no mantra found
                    alreadyInFile.title = "Mantra Not Found"
                    // Present alert to user.
                    present(notInFile, animated: true, completion: nil) //Present alert
                    
                }
            } // Show error
            catch let error as NSError {
                print("error loading contents of url \(self.pathToAff!)")
                print(error.localizedDescription)
            }
            
        }
        else { // Show if no mantra
            alreadyInFile.title = "Mantra Not Found"
            self.present(notInFile, animated: true, completion: nil) //Present alert
        }
        
        
    }
    //Button that shows help to user
    @IBOutlet weak var helpButton: UIButton!
    
    // Prepare for segue to help screen
    // Input: Storyboard Segue, Sender
    // Output: None
    // No dependencies
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! HelpViewController
        nav.callingScreen = 2 // Notify the popup who's calling it: 0 = Square Breathing, 1 = Grounding, 2 = Positive Affirmations, 3 = Panic Alerts
    }
    
    //Previous button
    // Input: Sender
    // Output: None
    // No dependencies
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
    // Input: Sender
    // Output: None
    // No dependencies
    @IBAction func Next(_ sender: AnyObject) {
        if(self.totalMantras > 0){
            self.currentIndex += 1
            if (self.currentIndex >= self.totalMantras) {
                self.currentIndex = 0
            }
            self.Label.text = self.arrayOfMantra[self.currentIndex] //change label text to the next one
        }
    }
    
    // Mantra Shower Label
    @IBOutlet weak var Label: UILabel!
    // Time in textfield
    @IBOutlet weak var textTime: UITextField!
    // Time for weekday
    @IBOutlet weak var weekday: UITextField!
    // Dropper for weekdrop
    @IBOutlet weak var weekdayDrop: UIPickerView!
    // Time for hour
    @IBOutlet weak var hour: UITextField!
    // Dropper for hour
    @IBOutlet weak var hourDrop: UIPickerView!
    // Time for minute
    @IBOutlet weak var minute: UITextField!
    // Dropper for minute
    @IBOutlet weak var minuteDrop: UIPickerView!
    // Dropper for frequency
    @IBOutlet weak var dataDrop: UIPickerView!
    // "At" text label
    @IBOutlet weak var atLabelText: UILabel!
    // ":" text label
    @IBOutlet weak var sepLabel: UILabel!
    // Notification button
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
    // Operate on appearance of controller
    // Input: Animation Boolean
    // Output: None
    // No dependencies
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.notificationSet.textAlignment = NSTextAlignment.center
    }
    
    // Called once when this view is loaded:
    // Input: None
    // Output: None
    // No dependencies
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
        // Get path
        let thePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let theURL = NSURL(fileURLWithPath: thePath)
        pathToAff = theURL.appendingPathComponent(desiredFile)?.path
        // Set notification settings properly.
        if (UIApplication.shared.scheduledLocalNotifications?.count)! > 0 {
            // Find notification
            let setNot = UIApplication.shared.scheduledLocalNotifications![0]
            // Get date
            let notDate = setNot.fireDate
            // Get minute
            let minute = NSCalendar.current.component(.minute, from: notDate!)
            // Find a.m./p.m.
            var AMPM = "A.M"
            // String for minute
            var minuteString: String
            // String for hour
            var hourString: String
            // Get minute
            if(minute<=9){
                minuteString = "0" + String(minute)
            }
            else {
                minuteString = String(minute)
            }
            // Get hour
            var hour = NSCalendar.current.component(.hour, from: notDate!)
            if(hour>=12){
                hour = hour - 12
                AMPM = "P.M"
            }
            // Set hour appropiately
            if(hour==0){
                hour=12
            }
            if(hour<=9){
                hourString = "0" + String(hour)
            }
            else {
                hourString = String(hour)
            }
            // Get weekday
            let weekday = NSCalendar.current.component(.weekday, from: notDate!)
            // Set reminder text
            if(setNot.repeatInterval == NSCalendar.Unit.hour){
                self.notificationSet.text = "Active Reminder: Each hour at --:" + minuteString
            }
            else if(setNot.repeatInterval == NSCalendar.Unit.day){
                self.notificationSet.text = "Active Reminder: Each Day at " + hourString + ":" + minuteString + " " + AMPM
            }
            else {
                self.notificationSet.text = "Active Reminder: Each " + self.weekDay[weekday-1] + " at " + hourString + ":" + minuteString + " " + AMPM
            }// Centre align the text
            self.notificationSet.textAlignment = NSTextAlignment.center
        }
        self.notificationSet.textAlignment = NSTextAlignment.center
        //read file
        let theFileManager = FileManager.default
        // check if exist
        if theFileManager.fileExists(atPath: self.pathToAff!){
            do {
                // Obtain for
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
            // else attempt get default from project
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
        
        //set up actions and properties of controller
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
    // Input: None
    // Output: None
    // No dependencies
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()// dispose of any resources that can be recreated.
    }
    
    //return the components of data
    // Input: UIPickerView
    // Output: None
    // No dependencies
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // Detect tap to remove all droppers
    // Input: None
    // Output: None
    // No dependencies
    func detectTap(){
        let theTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideSelection))
        theTap.cancelsTouchesInView = false
        view.addGestureRecognizer(theTap)
    }
    
    // Hide selection of droppers
    // Input: None
    // Output: None
    // No dependencies
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
    // Input: None
    // Output: None
    // No dependencies
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        var countrows : Int = data.count
        // Check count of every dropper
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
    
    // Selectors for AM/PM for notification
    @IBOutlet weak var AMPMSel: UITextField!
    @IBOutlet weak var AMPMSelPick: UIPickerView!
    
    //return the option which the user selected in string type
    // Input: UIPickerView, row, component
    // Output: None
    // No dependencies
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Update title row for each dropper
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
    
    // Titles for weekday, hour and minute
    @IBOutlet weak var weekdayTitle: UILabel!
    @IBOutlet weak var hourTitle: UILabel!
    @IBOutlet weak var minuteTitle: UILabel!
    // Label for displaying notification settings
    @IBOutlet weak var notificationSet: UILabel!
    
    //make the pickerView shows the option which the user selected
    // Input: UIPickerView, row, component
    // Output: None
    // No dependencies
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
        // Check if not for notification slider
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
    // Input: UITextField
    // Output: None
    // No dependencies
    func textFieldDidBeginEditing(_ textFiled:UITextField){
        // Disables editing, rather, use textfield as button
        textFiled.isEnabled = false
        self.hideSelection()
        // Set to none, add selector in place for each
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
    // Input: Sender
    // Output: None
    // No dependencies
    @IBAction func scheduleNotification(_ sender: AnyObject) {
        // Create alerts
        // ---
        let notBoth = UIAlertController(title: "Reminders cleared/Mantra missing", message: "All notifications have been cleared. Please enter a mantra.", preferredStyle: .alert)
        let notExist = UIAlertController(title: "Reminders cleared", message: "Notifications have been cleared.", preferredStyle: .alert)
        let removeNot = UIAlertController(title: "Mantra Not Found", message: "Please enter a mantra.", preferredStyle: .alert)
        let notiSent = UIAlertController(title: "Positive affirmation confirmed", message: "Your mantra reminder preferences have been saved.", preferredStyle: .alert)
        // ---
        // Create user response
        let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        // Add user response to buttons
        notBoth.addAction(theOkAction)
        notExist.addAction(theOkAction)
        removeNot.addAction(theOkAction)
        notiSent.addAction(theOkAction)
        // Hide selection
        self.hideSelection()
        // Set up calander and variables
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_POSIX_US")
        let weekDaySymbols = calendar.weekdaySymbols
        var indexOfDay = weekDaySymbols.index(of: weekday.text!)
        // Check if weekday found
        if indexOfDay == nil {
            indexOfDay = weekDaySymbols.index(of: "Sunday")
        }
        // Adjust index
        let weekDay = indexOfDay! + 1
        // Get components
        var matchingComponents = DateComponents()
        // Get frequency
        var tfreq = ""
        
        //default as Never
        if textTime.text == "" {
            tfreq = "Never"
        }
        else {
            tfreq = textTime.text!
        }
        // Check if weekly
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
        } // Show hour of current or next
        else {
            matchingComponents.hour = calendar.component(.hour, from: Date())
        } // Get minute if none -- default
        if(minute.text == ""){
            matchingComponents.minute = 0
        }
        else {
            matchingComponents.minute = Int(minute.text!) // Must set always
        }
        
        //hide and present certain view picker for different cases
        // Get next
        if tfreq == "Hourly" && matchingComponents.minute! <= Calendar.current.component(.minute, from: Date()) {
            matchingComponents.hour! += 1
            matchingComponents.hour! = matchingComponents.hour! % 24
        }
        // Get next time
        let nextDay = calendar.nextDate(after: Date(), matching: matchingComponents, matchingPolicy: .nextTime)
        //print(nextDay?.description) // Useful for finding what date exactly as defined by system
        // Find if label exists -- remove all notifications
        if(self.Label.text != ""){
            UIApplication.shared.cancelAllLocalNotifications()
            self.notificationSet.text = "No Active Reminder"
        }
        // Create notification
        if (tfreq != "Never" && self.Label.text != "") {
            // Create blank
            let notification = UILocalNotification()
            // Get settings
            let dict:NSDictionary = ["ID":"ID goes here"]
            notification.userInfo = dict as! [String : String]
            notification.alertBody = self.Label.text // Current mantra
            notification.alertAction = "Open"
            notification.fireDate = nextDay // Set date
            // Determine frequency
            if tfreq == "Weekly" {
                notification.repeatInterval = .weekday
            }
            else if tfreq == "Daily" {
                notification.repeatInterval = .day
            }
            else {
                notification.repeatInterval = .hour // MINIMUM IS MINUTE
            }
            // Set sound
            notification.soundName = UILocalNotificationDefaultSoundName
            // Schedule notification
            UIApplication.shared.scheduleLocalNotification(notification)
            // Check if notification set and made
            if (UIApplication.shared.scheduledLocalNotifications?.count)! > 0 {
                // Get notification and settings
                let setNot = UIApplication.shared.scheduledLocalNotifications![0]
                let notDate = setNot.fireDate
                let minute = NSCalendar.current.component(.minute, from: notDate!)
                var AMPM = "A.M"
                var minuteString: String
                var hourString: String
                // Get minute
                if(minute<=9){
                    minuteString = "0" + String(minute)
                }
                else {
                    minuteString = String(minute)
                }
                // Get hour
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
                // Get weekday
                let weekday = NSCalendar.current.component(.weekday, from: notDate!)
                // Set reminder text
                if(setNot.repeatInterval == NSCalendar.Unit.hour){
                    self.notificationSet.text = "Active Reminder: Each hour at ##:" + minuteString
                }
                else if(setNot.repeatInterval == NSCalendar.Unit.day){
                    self.notificationSet.text = "Active Reminder: Each Day at " + hourString + ":" + minuteString + " " + AMPM
                }
                else {
                    self.notificationSet.text = "Active Reminder: Each " + self.weekDay[weekday-1] + " at " + hourString + ":" + minuteString + " " + AMPM
                }
                self.notificationSet.textAlignment = NSTextAlignment.center
            }
            else {
                // Display error.
                self.notificationSet.text = "ERROR!"
            }
            self.present(notiSent, animated: true, completion: nil) // Presnt alert
        }
            // Present alerts depending which scenario.
        else if (self.Label.text == "" && tfreq == "Never") {
            // Present alert to user.
            self.present(notBoth, animated: true, completion: nil) //Present alert
        }
        else if(self.Label.text == ""){
            // Present alert to user.
            self.present(removeNot, animated: true, completion: nil) //Present alert
        }
        else {
            // Present alert to user.
            self.present(notExist, animated: true, completion: nil) //Present alert
        }
    }
}


