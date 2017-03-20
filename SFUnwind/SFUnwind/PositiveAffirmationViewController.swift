//
// PositiveAffirmationViewController.swift - View Controller for the Positive Affirmation feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Joseph Zhou
// Contributing Programmers:
// Known issues: the datePicker only works on iOS10
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import UIKit
import UserNotifications

class PositiveAffirmationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    var pathToAff: String? = nil
    var txtIndex = UITextField()
    var totalMantras: Int = 0
    var currentIndex: Int = 0
    var txt = "rrr"
    var blank = "\n"
    var arrayOfMantra = [String]()
    let alreadyInFile = UIAlertController(title: "Already in List", message: "This mantra is already entered.", preferredStyle: .alert)
    let notInFile = UIAlertController(title: "Not in List", message: "Mantra not found.", preferredStyle: .alert)
    let notEntered = UIAlertController(title: "Mantra Missing", message: "Mantra not entered.", preferredStyle: .alert)
    let notBoth = UIAlertController(title: "Notifications Cleared/Mantra Missing", message: "All notifications (if any) removed from this application. Please enter mantra.", preferredStyle: .alert)
    let notExist = UIAlertController(title: "Notifications Cleared", message: "All notifications (if any) removed from this application.", preferredStyle: .alert)
    let removeNot = UIAlertController(title: "Mantra Not Found", message: "Please enter mantra.", preferredStyle: .alert)
    let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    //Create button - not on verson 1
    @IBAction func Create(_ sender: AnyObject) {
        //create an alert
        let alert = UIAlertController(title: "Enter Mantra", message: "Write down the mantra you like", preferredStyle: UIAlertControllerStyle.alert)
        
        //add textField
        alert.addTextField { (textField) in textField.placeholder = "Enter here"
        }
        
        //Save aciton
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) -> Void in
            let saveText = (alert.textFields?[0])!.text  //take the input text
            //print("1: " + self.txtIndex.text!)    //print
            //print(self.fixed)
            
            // find file
            if(saveText != ""){
                let theFileManager = FileManager.default
                if theFileManager.fileExists(atPath: self.pathToAff!) {
                    print("AVAIL")
                    do {
                        let exportText = try String(contentsOfFile: self.pathToAff!)
                        print("Export -- : " + exportText)
                        let tempArray = exportText.components(separatedBy: "\n")
                        if(tempArray[0] != ""){
                            self.arrayOfMantra = exportText.components(separatedBy: "\n")
                        }
                        if self.arrayOfMantra.contains(saveText!) {
                            print("W1")
                            self.alreadyInFile.title = "Mantra Already Entered"
                            // Present alert to user.
                            self.present(self.alreadyInFile, animated: true, completion: nil) //Present alert
                        }
                        else {
                            print("W2")
                            print("CH: " + String(describing: self.arrayOfMantra))
                            self.arrayOfMantra.append(saveText!)
                            print("CH2: " + String(describing: self.arrayOfMantra))
                            if(exportText == ""){
                                try (saveText!).write(toFile: self.pathToAff!, atomically: false, encoding: .utf8)
                            }
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
                    print("NOT AVAIL")
                    do {
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
                // Present alert to user.
                self.present(self.notEntered, animated: true, completion: nil) //Present alert
            }
        })
        
        alert.addAction(saveAction) //run the save action
        
        //Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancelAction)   //run the cancel action
        
        self.present(alert, animated: true, completion: nil)    //present it
        
    }
    
    //Delete button - not on verson 1
    @IBAction func DeleteAlert(_ sender: AnyObject) {
        let mantraRemove: String = self.Label.text!
        let theFileManager = FileManager.default
        if theFileManager.fileExists(atPath: self.pathToAff!) {
            print("AVAIL")
            do {
                let exportText = try String(contentsOfFile: self.pathToAff!)
                print("Export -- : " + exportText)
                self.arrayOfMantra = exportText.components(separatedBy: "\n")
                if self.arrayOfMantra.contains(mantraRemove) {
                    print("FOUND")
                    let theIndex = self.arrayOfMantra.index(of: mantraRemove)
                    self.arrayOfMantra.remove(at: theIndex!)
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
                        print(self.totalMantras)
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
                        self.Label.text = self.arrayOfMantra[self.currentIndex]
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
            print("NOT AVAIL")
            self.alreadyInFile.title = "Mantra Not Found"
            // Present alert to user.
            self.present(self.notInFile, animated: true, completion: nil) //Present alert
        }
        print("CH: " + String(describing: self.arrayOfMantra))

        
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
            //print(String(self.currentIndex) + " " + String(self.totalMantras) + " " + String(self.arrayOfMantra.count))
            self.Label.text = self.arrayOfMantra[self.currentIndex]
        }
        print("KO: " + String(self.totalMantras) + String(self.currentIndex))
        print("CH: " + String(describing: self.arrayOfMantra))
    }
    
    //Next button
    @IBAction func Next(_ sender: AnyObject) {
        if(self.totalMantras > 0){
            self.currentIndex += 1
            if (self.currentIndex >= self.totalMantras) {
                self.currentIndex = 0
            }
            self.Label.text = self.arrayOfMantra[self.currentIndex]
        }
        print("KO: " + String(self.totalMantras) + String(self.currentIndex))
        print("CH: " + String(describing: self.arrayOfMantra))
    }

    //Label
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var textTime: UITextField!
    
    var index = 0   //index of the position of the list
    
    //fixed 10 postivite affirmations
    //    var fixed = ["I am awesome!", "I am the architect of my life; I build its foundation and choose its contents.", "Today, I am brimming with energy and overflowing with joy.", "My body is healthy; my mind is brilliant; my soul is tranquil.", "I am superior to negative thoughts and low actions.", "I have been given endless talents which I begin to utilize today.", "I forgive those who have harmed me in my past and peacefully detach from them.", "A river of compassion washes away my anger and replaces it with love.", "I am guided in my every step by Spirit who leads me towards what I must know and do.", "I possess the qualities needed to be extremely successful.", "My ability to conquer  my challenges is limitless; my potential to succeed is infinite."]
    //
    
    
    
    @IBOutlet weak var weekday: UITextField!
    @IBOutlet weak var weekdayDrop: UIPickerView!
    
    @IBOutlet weak var hour: UITextField!
    @IBOutlet weak var hourDrop: UIPickerView!
    
    @IBOutlet weak var minute: UITextField!
    @IBOutlet weak var minuteDrop: UIPickerView!
    
    var freq = ""
    var weekDay = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var hr = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
    var min = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    
    
    @IBOutlet weak var dataDrop: UIPickerView!
    //options of the frequency
    var data = ["Never", "Weekly", "Daily", "Hourly"]
 //   var picker = UIPickerView()
    @IBOutlet weak var atLabelText: UILabel!
    
    @IBOutlet weak var sepLabel: UILabel!
    // Called once when the view loads for the first time
    
    override func viewDidLoad() {
        totalMantras = 0
        currentIndex = 0
        let desiredFile = "affirmations.txt"
        let thePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let theURL = NSURL(fileURLWithPath: thePath)
        pathToAff = theURL.appendingPathComponent(desiredFile)?.path
        let theFileManager = FileManager.default
        if theFileManager.fileExists(atPath: self.pathToAff!){
            do {
                let getText = try String(contentsOfFile: self.pathToAff!)
                //print("Export -- : " + getText)
                let tempArray = getText.components(separatedBy: "\n")
                if(tempArray[0] != ""){
                    self.arrayOfMantra = getText.components(separatedBy: "\n")
                }
                print(self.arrayOfMantra)
                self.totalMantras = self.arrayOfMantra.count
                print("0: " + String(self.totalMantras))
                if(self.totalMantras != 0){
                    self.Label.text = self.arrayOfMantra[0]
                }
            }
            catch {
                print("error loading contents of url \(self.pathToAff!)")
                print(error.localizedDescription)
            }
        }
        alreadyInFile.addAction(theOkAction)
        notInFile.addAction(theOkAction)
        notEntered.addAction(theOkAction)
        notBoth.addAction(theOkAction)
        notExist.addAction(theOkAction)
        removeNot.addAction(theOkAction)
        super.viewDidLoad()
        weekday.isHidden = true
        weekday.isEnabled = false
        hour.isHidden = true
        hour.isEnabled = false
        minute.isHidden = true
        minute.isEnabled = false
        atLabelText.isHidden = true
        sepLabel.isHidden = true
        //make the date picker works
//        picker.delegate = self
//        picker.dataSource = self
//        textTime.inputView = picker
//        
    }
    
    // Check if we've recieved a memory warning.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()// dispose of any resources that can be recreated.
    }
    
    //return the components of data
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
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
        return countrows
    }
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
        return ""
    }
    
    //make the pickerView shows the option which the user selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print(component)
//        print(row)
//        switch (component) {
//        case 0:
//            freq = data[component][row]
//            textTime.text = freq
//            print(freq)
//        case 1:
//            weekDay = data[component][row]
//            weekday.text = weekDay
//            print(weekDay)
//        case 2:
//            hr = data[component][row]
//            hour.text = hr
//            print(hr)
//        case 3:
//            min = data[component][row]
//            minute.text = min
//            print(min)
//        default:
//            break
//        }
        if pickerView == dataDrop{
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
    }
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
//        toolbar.setItems([doneButton], animated: false)
//        textTime.inputAccessoryView = toolbar
//    }
//    func donePressed(){
//        self.view.endEditing(true)
//    }
//
    
    
    func textFieldDidBeginEditing(_ textFiled:UITextField){
        textFiled.isEnabled = false
        if (textFiled == self.textTime){
            self.dataDrop.isHidden = false
        }
        else if (textFiled == self.weekday){
            self.weekdayDrop.isHidden = false
        }
        else if (textFiled == self.hour){
            self.hourDrop.isHidden = false
        }
        else if (textFiled == self.minute){
            self.minuteDrop.isHidden = false
        }
        textFiled.isEnabled = true
    }
    
    //DatePicker
    @IBAction func scheduleNotification(_ sender: AnyObject) {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_POSIX_US")
        let weekDaySymbols = calendar.weekdaySymbols
        var indexOfDay = weekDaySymbols.index(of: weekday.text!) // INSERT WEEKDAY STRING HERE
        print(indexOfDay)
        if indexOfDay == nil {
            indexOfDay = weekDaySymbols.index(of: "Monday")
        }
        let weekDay = indexOfDay! + 1
        var matchingComponents = DateComponents()
        var tfreq = ""
        if textTime.text == "" {
            tfreq = "Never"
        }
        else {
            tfreq = textTime.text!
        }
        if tfreq == "Weekly" {
            matchingComponents.weekday = weekDay
        }
        if tfreq != "Hourly" {
            if(hour.text != ""){
                matchingComponents.hour = Int(hour.text!)
            }
            else {
                matchingComponents.hour = 0
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
        if tfreq == "Hourly" && matchingComponents.minute! <= Calendar.current.component(.minute, from: Date()) {
            matchingComponents.hour! += 1
            matchingComponents.hour! = matchingComponents.hour! % 24
        }
        let nextDay = calendar.nextDate(after: Date(), matching: matchingComponents, matchingPolicy: .nextTime)
        if(self.Label.text != ""){
            UIApplication.shared.cancelAllLocalNotifications()
        }
        if (tfreq != "Never" && self.Label.text != "") {
            print(nextDay?.description)
            print(calendar.timeZone)
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
    
    
