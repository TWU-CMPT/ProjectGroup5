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
    
    //Create button - not on verson 1
    @IBAction func Create(_ sender: AnyObject) {
        //create an alert
        let alert = UIAlertController(title: "Enter Mantra", message: "Write down the mantra you like", preferredStyle: UIAlertControllerStyle.alert)
        
        //add textField
        alert.addTextField { (textField) in textField.placeholder = "Enter here"
        }
        
        //Save aciton
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) -> Void in
            let textField0 = alert.textFields?[0]   //take the input text
            print(textField0?.text!)    //print
            self.Label.text = textField0?.text! //change the label to the next same as the user input
            self.fixed.append((textField0?.text!)!)
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
        let alert = UIAlertController(title: "Are you sure?", message: " ", preferredStyle: UIAlertControllerStyle.alert)
        
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
    var data = ["Never", "weekly", "Daily", "hourly"]
 //   var picker = UIPickerView()
    
    // Called once when the view loads for the first time
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
    }
    
    
    //Notification button
    @available(iOS 10.0, *)
    @IBAction func scheduleNotification(_ sender: AnyObject) {
        let center = UNUserNotificationCenter.current() //set up a current value to a var
        
        let content = UNMutableNotificationContent()
        content.title = "How are you doing today"   //set up a title
        content.body = "This is just a sample"  //set up a body
        content.sound = UNNotificationSound.default()   //make the default sound
        content.categoryIdentifier = "notificationID1"  //ID the above categories
        
        //3s testting
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        var dateComponnets = DateComponents()
        dateComponnets.weekday = 0
        dateComponnets.hour = 0
        dateComponnets.minute = 0
        let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponnets, repeats: true)
        
        let request2 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger2)
        center.add(request2)
        
        
//        let triggerTime = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)  //send notification at a time when the user wants to
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: true)   //make a trigger
//        let identifier = "LocalNotificationIdentifier"  //set up a identifier
//        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger) //test the error case
        center.add(request2){ (error) in
            if error != nil {
                print(error!)
            }
        }
    }
}

