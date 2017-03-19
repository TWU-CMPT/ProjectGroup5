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
    
    var txtIndex = UITextField()
    var txt = "rrr"
    //Create button - not on verson 1
    @IBAction func Create(_ sender: AnyObject) {
        //create an alert
        let alert = UIAlertController(title: "Enter Mantra", message: "Write down the mantra you like", preferredStyle: UIAlertControllerStyle.alert)
        
        //add textField
        alert.addTextField { (textField) in textField.placeholder = "Enter here"
        }
        
        //Save aciton
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) -> Void in
            self.txtIndex = (alert.textFields?[0])!   //take the input text
            print(self.txtIndex.text!)    //print
            self.txt = self.txtIndex.text!
            self.createTxtFile()
            self.Label.text = self.txt //change the label to the next same as the user input
            //self.fixed.append((self.txtIndex.text!))
        })
        
        alert.addAction(saveAction) //run the save action
        
        
        
        
        //Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancelAction)   //run the cancel action
        
        self.present(alert, animated: true, completion: nil)    //present it
    }
    
    //Delete button - not on verson 1
    @IBAction func DeleteAlert(_ sender: AnyObject) {
        //create an alert
        let alert = UIAlertController(title: "Are you sure?", message: fixed[index], preferredStyle: UIAlertControllerStyle.alert)
        
        //delete aciton
        let deleteAction = UIAlertAction(title: "submit", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) -> Void in
            if self.index == self.fixed.count - 1{
                self.fixed.remove(at: self.index - 1)
                self.index -= 1
            }else if(self.index == 0){
                self.fixed.remove(at: self.fixed.count - 1)
            }
        })
        
        alert.addAction(deleteAction) //run the delete action
        
        //Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancelAction)   //run the cancel action
        
        self.present(alert, animated: true, completion: nil)    //present it
    }
    @IBOutlet weak var helpButton: UIButton!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! HelpViewController
        nav.callingScreen = 2 // Notify the popup who's calling it: 0 = Square Breathing, 1 = Grounding, 2 = Positive Affirmations, 3 = Panic Alerts
    }
    
    //Previous button
    @IBAction func Previous(_ sender: AnyObject) {
        if index > -1 {
            Label.text = fixed[index]   //change the labe; text to the previous one
            index = index - 1
        }
        if index == -1{
            index = fixed.count - 1
        }
        print(index)
    }
    
    //Next button
    @IBAction func Next(_ sender: AnyObject) {
        if index < fixed.count + 1 {
            Label.text = fixed[index]   //change the labe; text to the next one
            index = index + 1
        }
        if index == fixed.count{
            index = 0
        }
        print(index)
    }
    
    //Label
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var textTime: UITextField!
    
    var index = 1   //index of the position of the list
    
    //fixed 10 postivite affirmations
    //    var fixed = ["I am awesome!", "I am the architect of my life; I build its foundation and choose its contents.", "Today, I am brimming with energy and overflowing with joy.", "My body is healthy; my mind is brilliant; my soul is tranquil.", "I am superior to negative thoughts and low actions.", "I have been given endless talents which I begin to utilize today.", "I forgive those who have harmed me in my past and peacefully detach from them.", "A river of compassion washes away my anger and replaces it with love.", "I am guided in my every step by Spirit who leads me towards what I must know and do.", "I possess the qualities needed to be extremely successful.", "My ability to conquer  my challenges is limitless; my potential to succeed is infinite."]
    //
    
    var fixed = [" ","1","2","3","4","5","6","7"]
    
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
        UIApplication.shared.cancelAllLocalNotifications()
        if tfreq != "Never" {
            print(nextDay?.description)
            print(calendar.timeZone)
            let notification = UILocalNotification()
            let dict:NSDictionary = ["ID":"ID goes here"]
            notification.userInfo = dict as! [String : String]
            notification.alertBody = "MESSAGE GOES HERE"
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
    }
    
    
    func createTxtFile(){

        if let theDocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            
            let path = theDocumentsDirectory.appendingPathComponent("mantras")
            
            //write
            do {
                try txt.write(to: path, atomically: true, encoding: String.Encoding.utf8)
            }
            catch _ {
                
                print("something went wrong")
            }
            
            //read
            do {
                txt = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch _ {
                print("something went wrong2")
            }
        }
    }
    
    

    
    
}
    
    
