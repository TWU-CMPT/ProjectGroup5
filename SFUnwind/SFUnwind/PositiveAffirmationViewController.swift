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
        //create am alert
        let alert = UIAlertController(title: "Enter Mantra", message: "Write down the mantra you like", preferredStyle: UIAlertControllerStyle.alert)
        
        //add textField
        alert.addTextField { (textField) in textField.placeholder = "Enter here"
        }
        
        //Save aciton
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) -> Void in
            let textField0 = alert.textFields?[0]   //take the input text
            print(textField0?.text!)    //print
            self.Label.text = textField0?.text! //change the label to the next same as the user input
        })
        
        alert.addAction(saveAction) //run the save action
        
        //Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancelAction)   //run the cancel action
        
        self.present(alert, animated: true, completion: nil)    //present it
    }
    
    //Delete button - not on verson 1
    @IBAction func DeleteAlert(_ sender: AnyObject) {
        
    }
    
    //Previous button
    @IBAction func Previous(_ sender: AnyObject) {
        if index > 0 {
            Label.text = fixed[index]   //change the labe; text to the previous one
            index = index - 1
        }
    }
    
    //Next button
    @IBAction func Next(_ sender: AnyObject) {
        if index < fixed.count - 1 {
            Label.text = fixed[index]   //change the labe; text to the next one
            index = index + 1
        }
    }
    
    //Label
    @IBOutlet weak var Label: UILabel!
    
    
    @IBOutlet weak var textTime: UITextField!
    
    var index = 0   //index of the position of the list
    
    //fixed 10 postivite affirmations
    var fixed = ["I am awesome!", "I am the architect of my life; I build its foundation and choose its contents.", "Today, I am brimming with energy and overflowing with joy.", "My body is healthy; my mind is brilliant; my soul is tranquil.", "I am superior to negative thoughts and low actions.", "I have been given endless talents which I begin to utilize today.", "I forgive those who have harmed me in my past and peacefully detach from them.", "A river of compassion washes away my anger and replaces it with love.", "I am guided in my every step by Spirit who leads me towards what I must know and do.", "I possess the qualities needed to be extremely successful.", "My ability to conquer  my challenges is limitless; my potential to succeed is infinite."]
    
    //DatePicker
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //options of the frequency
    var data = ["Never", "weekly", "Daily", "hourly"]
    var picker = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //make the date picker works
        picker.delegate = self
        picker.dataSource = self
        textTime.inputView = picker
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()// dispose of any resources that can be recreated.
    }
    
    //return the components of the UIPickerView, in this case jsut return 1
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    //make the datePicker of the values in "data"
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return data.count
    }
    
    //make the datePicker shows the option which the user selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textTime.text = data[row]
        self.view.endEditing(false)
    }
    
    //return the option which the user selected in string type
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    //DatePicker
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
        
        let triggerTime = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)  //send notification at a time when the user wants to
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: true)   //make a trigger
        let identifier = "LocalNotificationIdentifier"  //set up a identifier
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger) //test the error case
        center.add(request){ (error) in
            if error != nil {
                print(error!)
            }
        }
    }
}

